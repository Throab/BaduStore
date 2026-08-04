using System.ComponentModel.DataAnnotations.Schema;

namespace Service.Models
{
    [Table("Products")]
    public class Product
    {
        public int id { get; set; }
        public int? category_id { get; set; }
        public int? brand_id { get; set; }
        public required string? product_name { get; set; }
        public required string? alias { get; set; }
        public string? description { get; set; }
        public decimal price { get; set; }
        public bool is_hot { get; set; }
        public int? quantity { get; set; }
        public bool is_active { get; set; } = true;
        public DateTime? created_at { get; set; }
        public DateTime? updated_at { get; set; }
        [ForeignKey("category_id")]
        public virtual Category Category { get; set; }
        [ForeignKey("brand_id")]
        public virtual Brand Brand { get; set; }
        public virtual List<ProductAttribute> ProductAttributes { get; set; } = new List<ProductAttribute>();

        public virtual List<Image> Images { get; set; } = new List<Image>();
    }
}
