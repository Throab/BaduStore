using Service.DTOs;

namespace Service.Services.Interfaces
{
    public interface IOrderService
    {
        Task<OrderDTO> CreateOrderAsync(CheckoutDTO dto);
        Task<List<OrderDTO>> GetOrdersByUserIdAsync(int userId);
    }
}
