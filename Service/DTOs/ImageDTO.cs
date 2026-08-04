namespace Service.DTOs
{
    public class ImageDTO
    {
        public int Id { get; set; }
        public string? Url { get; set; }
        public int? ProductId { get; set; }
        public bool IsThumb { get; set; } = false;
    }
}
