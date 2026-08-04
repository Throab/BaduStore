using System.ComponentModel.DataAnnotations.Schema;

namespace Service.Models
{
    [Table("Categories")]
    public class Category
    {
        public int id { get; set; }
        public int? parent_id { get; set; }
        public required string name { get; set; }
        public required string display_name { get; set; }
        public required string alias { get; set; }
        public string image { get; set; }

        public bool is_active { get; set; } = true;

        [ForeignKey("parent_id")]
        public virtual Category? PCategory { get; set; }
        public virtual ICollection<Product>? Products { get; set; }

    }
}
