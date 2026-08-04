using Service.DTOs;
using Service.Models;
using Service.Repositories.Interfaces;
using Service.Services.Interfaces;
using Service.UnitOfWork;
using Service.Utils;
using System.Security.Claims;

namespace Service.Services
{
    public class AuthService(IAuthRepository repo, JwtHelper jwtHelper, IUnitOfWork unitOfWork) : IAuthService
    {
        private readonly IAuthRepository _repo = repo;
        private readonly JwtHelper _jwtHelper = jwtHelper;
        private readonly IUnitOfWork _unitOfWork = unitOfWork;
        public async Task<AuthResponseDTO> LoginAsync(LoginDTO dto)
        {
            var user = await _repo.GetByEmailAsync(dto.Email);
            if (user == null || !BCrypt.Net.BCrypt.Verify(dto.Password, user.password))
                return null;
            if (user.is_active == false)
                return null;
            return new AuthResponseDTO
            {
                Email = user.email,
                Role = user.role,
                Token = _jwtHelper.generateToken(user)
            };
        }
        public async Task<AuthResponseDTO> RegisterAsync(RegisterDTO dto)
        {
            if (string.IsNullOrWhiteSpace(dto.Email))
                throw new ArgumentException("Email không được để trống");

            if (string.IsNullOrWhiteSpace(dto.Password))
                throw new ArgumentException("Mật khẩu không được để trống");

            if (dto.Password != dto.ConfirmPassword)
                throw new ArgumentException("Mật khẩu xác nhận không khớp");

            var existingUser = await _repo.GetByEmailAsync(dto.Email);
            if (existingUser != null)
                throw new InvalidOperationException("Email đã được đăng ký");

            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(dto.Password);

            var newUser = new User
            {
                email = dto.Email,
                password = hashedPassword,
                full_name = dto.FullName,
                role = dto.Role ?? "User",
                phone_number = dto.PhoneNumber,
                is_active = true,
                created_at = DateTime.UtcNow,
                updated_at = DateTime.UtcNow,
                login_type = "Local"
            };

            var createdUser = await _repo.CreateUserAsync(newUser);

            return new AuthResponseDTO
            {
                Email = createdUser.email!,
                Role = createdUser.role!,
                Token = _jwtHelper.generateToken(createdUser)
            };
        }
        public async Task<User?> getUserByToken(string token)
        {
            var principal = _jwtHelper.ValidateToken(token);
            if (principal == null)
                return null;
            var emailClaim = principal.FindFirst(ClaimTypes.Email)?.Value;
            if (string.IsNullOrEmpty(emailClaim))
                return null;
            return await _repo.GetByEmailAsync(emailClaim);
        }
        public async Task<UserDTO?> GetUserByEmailAsync(string email)
        {
            var user = await _repo.GetByEmailAsync(email);
            if (user == null)
                return null;
            return new UserDTO
            { 
                Id = user.id,
                Address = user.address,
                Email = user.email,
                FullName = user.full_name,
                PhoneNumber = user.phone_number,
                DateOfBirth = user.date_of_birth,
                Role = user.role,
                Gender = user.gender
            };
        }
        public async Task UpdateUserAsync(UserUpdateDTO dto)
        {
            var user = await _repo.GetByEmailAsync(dto.Email);
            if (user == null)
                throw new InvalidOperationException("Người dùng không tồn tại");
            user.full_name = dto.FullName;
            user.phone_number = dto.PhoneNumber;
            user.address = dto.Address;
            user.gender = dto.Gender;
            user.date_of_birth = dto.DateOfBirth;
            user.updated_at = DateTime.UtcNow;
            _repo.UpdateUser(user);
            await _unitOfWork.SaveChangesAsync();
        }
        public async Task ChangePassword(ChangePasswordDTO dto)
        {
            var user = await _repo.GetByEmailAsync(dto.email);
            if (user == null)
                throw new InvalidOperationException("Người dùng không tồn tại");
            if (!BCrypt.Net.BCrypt.Verify(dto.oldPassword, user.password))
                throw new InvalidOperationException("Mật khẩu cũ không đúng");
            user.password = BCrypt.Net.BCrypt.HashPassword(dto.newPassword);
            user.updated_at = DateTime.UtcNow;
            _repo.UpdateUser(user);
            await _unitOfWork.SaveChangesAsync();
        }
        public async Task<AuthResponseDTO?> GoogleLoginAsync(GoogleLoginDTO dto)
        {
            var payload = await _jwtHelper.VerifyGoogleTokenAsync(dto.Token);
            if (payload == null)
                return null;
            var user = await _repo.GetByEmailAsync(payload.Email);
            if (user == null)
            {
                user = new User
                {
                    email = payload.Email,
                    full_name = payload.Name,
                    role = "User",
                    is_active = true,
                    created_at = DateTime.UtcNow,
                    updated_at = DateTime.UtcNow,
                    login_type = "Google",
                    google_id = payload.Subject,
                };
                user = await _repo.CreateUserAsync(user);
            }
            else
            {
                user.google_id = payload.Subject;
                if (user.login_type == "Local")
                    user.login_type = "Both";
                else
                    user.login_type = "Google";

                user.updated_at = DateTime.UtcNow;

                _repo.UpdateUser(user);
                await _unitOfWork.SaveChangesAsync();
            }

            // Nếu đã liên kết Google thì kiểm tra Google ID
            if (!string.IsNullOrEmpty(user.google_id) &&
                user.google_id != payload.Subject)
            {
                throw new Exception("Google account không khớp.");
            }
            Console.WriteLine(user);
            return new AuthResponseDTO
            {
                Email = user.email!,
                Role = user.role!,
                Token = _jwtHelper.generateToken(user)
            };
        }
    }
}
