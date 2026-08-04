namespace Service.DTOs
{
    public class CheckoutDTO
    {
        public int UserId { get; set; }
        public string Address { get; set; } = "";

        public string PhoneNumber { get; set; } = "";

        public string PaymentMethod { get; set; } = "";
        public Decimal TotalAmount { get; set; }
    }
}
