namespace Service.DTOs
{
    public class PaymentResponseDTO
    {
        public bool Success { get; set; }
        public string Message { get; set; } = "";
        public string? PaymentIntentId { get; set; }
        public string? ClientSecret { get; set; }
        public string? OrderStatus { get; set; }
        public string? ReceiptUrl { get; set; }
    }
}
