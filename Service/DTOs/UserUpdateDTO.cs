using Service.Enum;

namespace Service.DTOs
{
    public class UserUpdateDTO
    {
        public required string Email { get; set; }
        public required string FullName { get; set; }
        public string PhoneNumber { get; set; }
        public string Address { get; set; }
        public DateTime? DateOfBirth { get; set; }
        public Gender? Gender { get; set; }
    }
}
