namespace Service.DTOs
{
    public class ProductDTO
    {
        public int Id { get; set; }
        public string? Name { get; set; }
        public string? Alias { get; set; }
        public decimal Price { get; set; }
        public bool IsHot { get; set; } = false;
        public bool IsActive { get; set; } = true;
        public string ThumbURL { get; set; }
    }
}
