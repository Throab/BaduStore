using System.ComponentModel.DataAnnotations.Schema;

namespace Service.Models
{
    [Table("Images")]
    public class Image
    {
        public int id { get; set; }
        public int? product_id { get; set; }
        public required string url { get; set; }
        public string? key { get; set; }

        public bool is_thumb { get; set; } = false;
        [ForeignKey("product_id")]
        public virtual Product Product { get; set; }
    }
}
