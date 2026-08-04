using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Service.Models
{
    [Table("Transactions")]
    public class Transaction
    {
        [Key]
        public int id { get; set; }

        [Required]
        public int order_id { get; set; }

        [Required]
        [StringLength(100)]
        public string transaction_id { get; set; } = string.Empty;

        [Required]
        public DateTime paid_at { get; set; } = DateTime.UtcNow;

        [ForeignKey(nameof(order_id))]
        public virtual Order Order { get; set; } = null!;
    }
}