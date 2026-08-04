using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Service.DTOs;
using Service.Services.Interfaces;

namespace Service.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrdersController(IOrderService service) : ControllerBase
    {
        private readonly IOrderService _service = service;

        [Authorize]
        [HttpPost("checkout")]
        public async Task<IActionResult> Checkout(CheckoutDTO dto)
        {
            await _service.CreateOrderAsync(dto);

            return Ok();
        }
        [HttpGet("{userId:int}")]
        public async Task<IActionResult> GetByUser(int userId)
        {
            var order = await _service.GetOrdersByUserIdAsync(userId);
            return Ok(order);
        }
    }
}
