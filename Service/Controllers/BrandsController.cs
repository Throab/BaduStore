using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Service.Repositories.Interfaces;
using Service.Services.Interfaces;

namespace Service.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BrandsController(IBrandService service) : ControllerBase
    {
        protected IBrandService _service = service;
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            return Ok(await _service.GetAllAsync());
        }
    }
}
