using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Service.DTOs;
using Service.Services.Interfaces;

namespace Service.Controllers
{
    [ApiController]
    [Route("api/carts")]
    public class CartsController : ControllerBase
    {
        private readonly ICartService _service;

        public CartsController(ICartService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
            => Ok(await _service.GetCartAsync());

        [HttpPost]
        public async Task<IActionResult> Add(AddCartDTO dto)
        {
            await _service.AddToCartAsync(dto);
            return Ok();
        }

        [HttpPut]
        public async Task<IActionResult> Update(UpdateCartDTO dto)
        {
            await _service.UpdateCartAsync(dto);
            return Ok();
        }

        [HttpDelete("{productId}")]
        public async Task<IActionResult> Remove(int productId)
        {
            await _service.RemoveFromCartAsync(productId);
            return Ok();
        }

        [HttpDelete]
        public async Task<IActionResult> Clear()
        {
            await _service.ClearCartAsync();
            return Ok();
        }
        [Authorize]
        [HttpPost("merge")]
        public async Task<IActionResult> MergeCart()
        {
            await _service.MergeCartAsync();
            return Ok();
        }
    }
}
