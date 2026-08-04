namespace Service.DTOs
{
    public class OrderDTO
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string PaymentMethod { get; set; } = "";
        public string OrderStatus { get; set; } = "";
        public DateTime CreatedAt { get; set; }
        public Decimal TotalAmount { get; set; }
        public string PhoneNumber { get; set; } = "";
        public string Address { get; set; } = "";
        public List<OrderItemDTO> Items { get; set; } = new List<OrderItemDTO>();
    }
}
