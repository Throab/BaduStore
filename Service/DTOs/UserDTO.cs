using Service.Enum;

namespace Service.DTOs
{
    public class UserDTO
    {
        public required int Id { get; set; }
        public required string Email { get; set; }
        public required string FullName { get; set; }
        public required string PhoneNumber { get; set; }
        public required string Address { get; set; }
        public required string Role { get; set; }
        public required DateTime? DateOfBirth { get; set; }
        public required Gender? Gender { get; set; }
    }
}
