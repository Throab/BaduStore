using Service.DTOs;
using Service.Models;
using Service.Repositories;
using Service.Repositories.Interfaces;
using Service.Services.Interfaces;
using Service.UnitOfWork;

namespace Service.Services
{
    public class OrderService : IOrderService
    {
        private readonly ICartService _cartService;
        private readonly IOrderRepository _orderRepository;
        private readonly IUnitOfWork _unitOfWork;
        private readonly IProductRepository _productRepository;
        public OrderService(ICartService cartService, IOrderRepository orderRepository, IUnitOfWork unitOfWork, IProductRepository productRepository)
        {
            _cartService = cartService;
            _orderRepository = orderRepository;
            _unitOfWork = unitOfWork;
            _productRepository = productRepository;
        }


        public async Task<OrderDTO> CreateOrderAsync(CheckoutDTO dto)
        {
            using var transaction = await _unitOfWork.BeginTransactionAsync();
            try
            {
                var cart = await _cartService.GetCartAsync();
                if (cart == null || !cart.Items.Any())
                {
                    throw new InvalidOperationException("Cart is empty.");
                }
                var order = new Order
                {
                    user_id = dto.UserId,
                    order_total = cart.TotalAmount,
                    address = dto.Address,
                    phone_number = dto.PhoneNumber,
                    payment_method = dto.PaymentMethod,
                    status = "Pending",
                    created_at = DateTime.Now,
                    OrderItems = cart.Items.Select(i => new OrderItem
                    {
                        product_id = i.ProductId,
                        quantity = i.Quantity,
                        price = i.Price,
                        total = i.Quantity * i.Price
                    }).ToList()
                };

                // Lưu order
                _orderRepository.Insert(order);
                foreach (var item in cart.Items)
                {
                    var product = await _productRepository.GetByIdToUpdateAsync(item.ProductId);
                    product.quantity -= item.Quantity;
                    _productRepository.UpdateProduct(product);
                }


                await _unitOfWork.SaveChangesAsync();
                await _cartService.ClearCartAsync();
                await transaction.CommitAsync();

                return new OrderDTO
                {
                    Id = order.id,
                    TotalAmount = order.order_total,
                    CreatedAt = order.created_at,
                    OrderStatus = order.status,
                };
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();
                throw;
            }

        }
        public async Task<List<OrderDTO>> GetOrdersByUserIdAsync(int userId)
        {
            var orders = await _orderRepository.GetOrdersByUserId(userId);

            return orders.Select(order => new OrderDTO
            {
                Id = order.id,
                UserId = order.user_id,
                TotalAmount = order.order_total,
                OrderStatus = order.status,
                PaymentMethod = order.payment_method,
                Address = order.address,
                PhoneNumber = order.phone_number,
                CreatedAt = order.created_at,

                Items = order.OrderItems.Select(item => new OrderItemDTO
                {
                    Id = item.id,
                    Total = item.total,
                    OrderId = item.order_id,
                    ProductId = item.product_id,
                    Quantity = item.quantity,
                    Price = item.price
                }).ToList()

            }).ToList();
        }
    }
}

