namespace Service.DTOs
{
    public class ChangePasswordDTO
    {
        public required string email { get; set; }
        public required string oldPassword { get; set; }
        public required string newPassword { get; set; }
    }
}
