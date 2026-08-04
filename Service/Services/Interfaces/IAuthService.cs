using Service.DTOs;
using Service.Models;

namespace Service.Services.Interfaces
{
    public interface IAuthService
    {
        Task<AuthResponseDTO> LoginAsync(LoginDTO dto);
        Task<AuthResponseDTO> RegisterAsync(RegisterDTO dto);
        Task<User?> getUserByToken(string token);
        Task<UserDTO> GetUserByEmailAsync(string email);
        Task UpdateUserAsync(UserUpdateDTO dto);
        Task ChangePassword(ChangePasswordDTO dto);
        Task<AuthResponseDTO?> GoogleLoginAsync(GoogleLoginDTO dto);
    }
}
