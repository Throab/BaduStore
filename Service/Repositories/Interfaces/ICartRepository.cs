using Service.Models;

namespace Service.Repositories.Interfaces
{
    public interface ICartRepository
    {
        Task<Cart?> GetAsync(string key);

        Task SaveAsync(string key, Cart cart);

        Task DeleteAsync(string key);
    }
}
