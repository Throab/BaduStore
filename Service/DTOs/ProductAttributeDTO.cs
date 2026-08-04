namespace Service.DTOs
{
    public class ProductAttributeDTO
    {
        public int? Id { get; set; }
        public int? ProductId { get; set; }
        public int? AttributeId { get; set; }
        public string? Value { get; set; }

        public AttributeDTO? Attribute { get; set; }
    }
}
