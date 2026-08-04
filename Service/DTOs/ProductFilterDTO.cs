namespace Service.DTOs
{
    public class ProductFilterDTO
    {
        public string? KeySearch { get; set; }
        public int? CategoryId { get; set; }
        public int? BrandId { get; set; }
        public string? OrderBy { get; set; }
        public decimal? PriceFrom { get; set; }
        public decimal? PriceTo { get; set; }
        public int Page { get; set; } = 1;
        public int PageSize { get; set; } = 5;
    }
}
