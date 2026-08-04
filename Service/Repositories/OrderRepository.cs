using Microsoft.EntityFrameworkCore;
using Service.Data;
using Service.Models;
using Service.Repositories.Interfaces;

namespace Service.Repositories
{
    public class OrderRepository : IOrderRepository
    {
        private readonly DBContext _context;
        public OrderRepository(DBContext context)
        {
            _context = context;
        }
        public void Insert(Order order)
        {
            Order test = new Order
            {
                user_id = order.user_id,
                order_total = order.order_total,
                address = order.address,
                phone_number = order.phone_number,
                payment_method = order.payment_method,
                status = "Pending",
                created_at = DateTime.Now,
            };
            _context.Orders.Add(order);
        }
        public async Task<List<Order>> GetOrdersByUserId(int id)
        {
            return await _context.Orders.AsNoTracking().Include(p => p.OrderItems).Where(p => p.user_id == id).ToListAsync();
        }
    }
}
