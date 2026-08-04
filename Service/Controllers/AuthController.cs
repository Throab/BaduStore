using Castle.Core.Resource;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Service.DTOs;
using Service.Services.Interfaces;
using System.Security.Claims;

namespace Service.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController(IAuthService service) : ControllerBase
    {
        protected IAuthService _service = service;
        [HttpPost("login")]
        [AllowAnonymous]
        public async Task<IActionResult> Login([FromBody] LoginDTO dto)
        {
            var result = await _service.LoginAsync(dto);
            if (result == null)
                return Unauthorized();
            return Ok(result);

        }
        [HttpPost("register")]
        [AllowAnonymous]
        public async Task<IActionResult> Register([FromBody] RegisterDTO dto)
        {
            try
            {
                var result = await _service.RegisterAsync(dto);
                return Ok(new
                {
                    success = true,
                    message = "Register successful",
                    data = result
                });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [Authorize]
        [HttpGet("me")]
        public async Task<IActionResult> GetMe()
        {
            var email =
                User.FindFirst(ClaimTypes.Email)?.Value;

            if (string.IsNullOrEmpty(email))
                return Unauthorized();

            var user =
                await _service.GetUserByEmailAsync(email);

            if (user == null)
                return NotFound();

            return Ok(user);
        }
        [Authorize]
        [HttpPut("me")]
        public async Task<IActionResult> UpdateMe([FromBody] UserUpdateDTO dto)
        {
            var email =
                User.FindFirst(ClaimTypes.Email)?.Value;
            if (string.IsNullOrEmpty(email))
                return Unauthorized();
            var user =
                await _service.GetUserByEmailAsync(email);
            if (user == null)
                return NotFound();
            dto.Email = user.Email;
            await _service.UpdateUserAsync(dto);
            return Ok(new
            {
                success = true,
                message = "Update successful"
            });
        }
        [Authorize]
        [HttpPut("me/password")]
        public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordDTO dto)
        {
            var email =
                User.FindFirst(ClaimTypes.Email)?.Value;
            if (string.IsNullOrEmpty(email))
                return Unauthorized();
            var user =
                await _service.GetUserByEmailAsync(email);
            if (user == null)
                return NotFound();
            await _service.ChangePassword(dto);
            return Ok(new
            {
                success = true,
                message = "Change password successful"
            });
        }
        [AllowAnonymous]
        [HttpPost("google-login")]
        public async Task<IActionResult> GoogleLogin(
        [FromBody] GoogleLoginDTO dto)
        {
            var result = await _service.GoogleLoginAsync(dto);

            return Ok(result);
        }
    }
}
