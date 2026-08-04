using Service.Enum;
using System.ComponentModel.DataAnnotations.Schema;

namespace Service.Models
{
    [Table("Users")]
    public class User
    {
        public int id { get; set; }
        public string? email { get; set; }
        public string? phone_number { get; set; }
        public string? password { get; set; }
        public string? address { get; set; }
        public string? full_name { get; set; }
        public string? role { get; set; }
        public bool? is_active { get; set; }
        public DateTime? created_at { get; set; }
        public DateTime? updated_at { get; set; }
        public DateTime? date_of_birth { get; set; }
        public Gender? gender { get; set; }
        public string? google_id { get; set; }
        public string? login_type { get; set; }
    }
}
