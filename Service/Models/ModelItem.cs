using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Service.Models
{
    [Table("OrderItems")]
    public class OrderItem
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("id")]
        public int id { get; set; }

        [Column("order_id")]  // ✅ Sửa từ Orderid thành order_id
        public int order_id { get; set; }

        [Column("product_id")]  // ✅ Sửa từ Productid thành product_id
        public int product_id { get; set; }

        [Column("quantity")]
        public int quantity { get; set; }

        [Column("price")]
        public decimal price { get; set; }

        [Column("total")]
        public decimal total { get; set; }

        [ForeignKey("order_id")]
        public virtual Order Order { get; set; } = null!;

        [ForeignKey("product_id")]
        public virtual Product Product { get; set; } = null!;
    }
}