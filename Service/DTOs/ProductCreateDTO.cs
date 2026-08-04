namespace Service.DTOs
{
    public class ProductCreateDTO
    {
        public string? Name { get; set; }
        public int CategoryId { get; set; }
        public int BrandId { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; }
        public string? Description { get; set; }
        public bool IsHot { get; set; }
        public bool IsActive { get; set; }
        public IFormFile ThumbImage { get; set; }
        public List<IFormFile> Images { get; set; }
    }
}
