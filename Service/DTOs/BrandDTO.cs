namespace Service.DTOs
{
    public class BrandDTO
    {
        public int? Id { get; set; }
        public string? Name { get; set; }
        public string? DisplayName { get; set; }
        public string? Alias { get; set; }
        public string? Image { get; set; }
        public bool IsActive { get; set; }
    }
}
