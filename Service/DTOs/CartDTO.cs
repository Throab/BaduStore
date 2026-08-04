namespace Service.DTOs
{
    public class CartDTO
    {
        public List<CartItemDTO> Items { get; set; } = new();

        public int TotalQuantity { get; set; }

        public decimal TotalAmount { get; set; }
    }
}
