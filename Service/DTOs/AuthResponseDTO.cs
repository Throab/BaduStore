namespace Service.DTOs
{
    public class AuthResponseDTO
    {
        public required string Token { get; set; }
        public required string Email { get; set; }
        public required string Role { get; set; }
    }
}
