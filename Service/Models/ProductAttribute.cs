using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace Service.Models
{
    [Table("ProductAttributes")]
    [PrimaryKey(nameof(product_id), nameof(attribute_id))]
    public class ProductAttribute
    {
        public int product_id { get; set; }
        public int attribute_id { get; set; }
        [ForeignKey("product_id")]
        public virtual Product Product { get; set; }
        [ForeignKey("attribute_id")]
        public virtual Attribute Attribute { get; set; }
    }
}
