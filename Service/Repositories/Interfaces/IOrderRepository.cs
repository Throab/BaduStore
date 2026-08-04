using Service.Models;

namespace Service.Repositories.Interfaces
{
    public interface IOrderRepository
    {
        void Insert(Order order);
        Task<List<Order>> GetOrdersByUserId(int id);

    }
}
