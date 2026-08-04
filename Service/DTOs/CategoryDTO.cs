namespace Service.DTOs
{
    public class CategoryDTO
    {
        public int? Id { get; set; }
        public int? ParentId { get; set; }
        public string Name { get; set; }
        public string DisplayName { get; set; }
        public string? Alias { get; set; }
        public string? Image { get; set; }
        public string? PCatename { get; set; }
        public bool IsActive { get; set; }
    }
}
