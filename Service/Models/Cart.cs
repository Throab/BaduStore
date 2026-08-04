namespace Service.Models
{
    public class Cart
    {
        public virtual List<CartItem> items { get; set; } = new();
    }
}
