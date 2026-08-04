using Service.DTOs;

namespace Service.Services.Interfaces
{
    public interface ICartService
    {
        Task<CartDTO> GetCartAsync();

        Task AddToCartAsync(AddCartDTO dto);

        Task UpdateCartAsync(UpdateCartDTO dto);

        Task RemoveFromCartAsync(int productId);

        Task ClearCartAsync();
        Task MergeCartAsync();
    }
}
