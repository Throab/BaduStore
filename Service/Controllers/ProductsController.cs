using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Service.DTOs;
using Service.Services.Interfaces;

namespace Service.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductsController(IProductService service) : ControllerBase
    {
        protected IProductService _service = service;
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var products = await _service.GetAllAsync();
            return Ok(products);
        }
        [HttpGet("{id:int}")]
        public async Task<IActionResult> GetById(int id)
        {
            var product = await _service.GetByIdAsync(id);
            if (product == null) return NotFound();
            return Ok(product);
        }
        [HttpGet("{alias}")]
        public async Task<IActionResult> GetByAlias(string alias)
        {
            var product = await _service.GetByAliasAsync(alias);
            if (product == null) return NotFound();
            return Ok(product);
        }
        [HttpGet("category/{categoryId}")]
        public async Task<IActionResult> GetProductsByCategory(int categoryId)
        {
            var products = await _service.GetProductsByCategoryAsync(categoryId);
            return Ok(products);
        }
        [HttpGet("brand/{brandId}")]
        public async Task<IActionResult> GetProductsByBrand(int brandId)
        {
            var products = await _service.GetProductsByBrandAsync(brandId);
            return Ok(products);
        }
        [HttpPost]
        [Authorize(Roles = "Admin")]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> InsertProduct(ProductCreateDTO dto)
        {
            await _service.InsertProductAsync(dto);
            return Ok();
        }
        [HttpDelete("{id:int}")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> DeleteProduct(int id)
        {
            await _service.DeleteProductAsync(id);
            return Ok();
        }
        [HttpPatch("{id:int}/status")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> ChangeState(int id)
        {
            await _service.ChangeProductStateAsync(id);
            return Ok();
        }
        [Route("search")]
        [HttpGet]
        public async Task<IActionResult> Search([FromQuery] ProductFilterDTO filter)
        {
            try
            {
                return Ok(await service.GetProductsByFilterAsync(filter));
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [Route("hot/{take:int}")]
        [HttpGet]
        public async Task<IActionResult> GetHotProducts(int take)
        {
            try
            {
                return Ok(await service.GetHotProductsAsync(take));
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
