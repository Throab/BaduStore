namespace Service.DTOs
{
    public class ProductDetailDTO
    {
        public int Id { get; set; }
        public int? CategoryId { get; set; }
        public int? BrandId { get; set; }
        public string? CategoryName { get; set; }
        public string? BrandName { get; set; }
        public string? Name { get; set; }
        public string? Alias { get; set; }
        public string? Description { get; set; }
        public decimal Price { get; set; }
        public int? Quantity { get; set; }
        public bool IsHot { get; set; } = false;
        public bool IsActive { get; set; } = true;
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public List<AttributeDTO> Attributes { get; set; } = new List<AttributeDTO>();
        public List<ImageDTO> Images { get; set; } = new List<ImageDTO>();

    }
}
