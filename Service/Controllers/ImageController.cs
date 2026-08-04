using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Service.Services.Interfaces;

namespace Service.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ImageController(IImageService service) : ControllerBase
    {
        IImageService _service = service;
        [HttpPost("thumb")]
        [Authorize(Roles = "Admin")]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> UploadThumb(IFormFile file)
        {
            if (file == null || file.Length == 0)
            {
                return BadRequest("Please select an image.");
            }

            var imageUrl = await _service.UploadImageAsync(file);

            if (string.IsNullOrEmpty(imageUrl.Url))
            {
                return BadRequest("Upload failed.");
            }

            return Ok(new
            {
                Message = "Upload successful.",
                Url = imageUrl.Url
            });
        }

    }
}
