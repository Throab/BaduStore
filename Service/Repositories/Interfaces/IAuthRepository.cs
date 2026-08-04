using Service.DTOs;
using Service.Models;

namespace Service.Repositories.Interfaces
{
    public interface IAuthRepository
    {
        Task<User?> GetByEmailAsync(string email);
        Task<User> CreateUserAsync(User user);
        void UpdateUser(User user);
    }
}
