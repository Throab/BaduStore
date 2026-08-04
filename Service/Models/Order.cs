using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Service.Models
{
    [Table("Orders")]
    public class Order
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("id")]
        public int id { get; set; }

        [Column("user_id")]
        public int user_id { get; set; }

        [Column("order_total")]
        public decimal order_total { get; set; }

        [Column("status")]
        public string status { get; set; } = "Pending";

        [Column("payment_method")]
        public string payment_method { get; set; } = string.Empty;

        [Column("address")]
        public string address { get; set; } = string.Empty;

        [Column("phone_number")]
        public string phone_number { get; set; } = string.Empty;

        [Column("created_at")]
        public DateTime created_at { get; set; }

        [ForeignKey("user_id")]
        public virtual User User { get; set; } = null!;

        public virtual ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();
    }
}