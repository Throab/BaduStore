using System.ComponentModel.DataAnnotations.Schema;

namespace Service.Models
{
    [Table("Brands")]
    public class Brand
    {
        public int id { get; set; }
        public required string name { get; set; }
        public required string display_name { get; set; }
        public required string alias { get; set; }
        public string image { get; set; }
        public bool is_active { get; set; } = true;
        public virtual ICollection<Product>? products { get; set; }
    }
}
