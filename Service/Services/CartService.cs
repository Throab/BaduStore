using System.Security.Claims;
using Service.DTOs;
using Service.Models;
using Service.Repositories.Interfaces;
using Service.Services.Interfaces;

public class CartService : ICartService
{
    private readonly ICartRepository _cartRepo;
    private readonly IProductRepository _productRepo;
    private readonly IHttpContextAccessor _httpContextAccessor;

    public CartService(
        ICartRepository cartRepo,
        IProductRepository productRepo,
        IHttpContextAccessor httpContextAccessor)
    {
        _cartRepo = cartRepo;
        _productRepo = productRepo;
        _httpContextAccessor = httpContextAccessor;
    }

    private string GetRedisKey()
    {
        var http = _httpContextAccessor.HttpContext!;
        foreach (var header in http.Request.Headers)
        {
            Console.WriteLine(
                $"{header.Key}: {header.Value}"
            );
        }
        var userId = http.User.FindFirstValue(ClaimTypes.NameIdentifier);

        if (!string.IsNullOrEmpty(userId))
            return $"cart:user:{userId}";

        if (!http.Request.Headers.TryGetValue("Guest-Id", out var guestId))
            throw new Exception("GuestId không tồn tại.");

        return $"cart:guest:{guestId}";
    }

    public async Task<CartDTO> GetCartAsync()
    {
        var key = GetRedisKey();

        // Lấy cart từ Redis
        var cart = await _cartRepo.GetAsync(key);

        if (cart == null || cart.items == null || !cart.items.Any())
        {
            return new CartDTO
            {
                Items = new List<CartItemDTO>(),
                TotalQuantity = 0,
                TotalAmount = 0
            };
        }


        // Lấy danh sách product id trong cart
        var productIds = cart.items
            .Select(x => x.product_id)
            .Distinct()
            .ToList();


        // Lấy product + images một lần từ database
        var products = await _productRepo.GetProductsByIdsAsync(productIds);


        var result = new CartDTO
        {
            Items = new List<CartItemDTO>()
        };


        foreach (var item in cart.items)
        {
            var product = products
                .FirstOrDefault(x => x.id == item.product_id);


            if (product == null)
                continue;


            var dto = new CartItemDTO
            {
                ProductId = product.id,
                ProductName = product.product_name ?? "",

                ThumbUrl = product.Images
                    .FirstOrDefault(x => x.is_thumb)?.url ?? "",

                Price = product.price,

                Quantity = item.quantity,

                Total = product.price * item.quantity
            };


            result.Items.Add(dto);
        }
        result.TotalQuantity = result.Items
            .Sum(x => x.Quantity);
        result.TotalAmount = result.Items
            .Sum(x => x.Total);
        return result;
    }
    public async Task AddToCartAsync(AddCartDTO dto)
    {
        var product = await _productRepo.GetByIdAsync(dto.ProductId);

        if (product == null)
            throw new Exception("Sản phẩm không tồn tại.");

        if (product.quantity < 1)
            throw new Exception("Không đủ số lượng sản phẩm.");

        var key = GetRedisKey();

        var cart = await _cartRepo.GetAsync(key);

        if (cart == null)
            cart = new Cart();

        var item = cart.items.FirstOrDefault(x => x.product_id == dto.ProductId);

        if (item == null)
        {
            cart.items.Add(new CartItem
            {
                product_id = dto.ProductId,
                quantity = 1
            });
        }
        else
        {
            item.quantity += 1;

            if (item.quantity > product.quantity)
                throw new Exception("Số lượng vượt quá tồn kho.");
        }

        await _cartRepo.SaveAsync(key, cart);
    }
    public async Task UpdateCartAsync(UpdateCartDTO dto)
    {
        var product = await _productRepo.GetByIdAsync(dto.ProductId);

        if (product == null)
            throw new Exception("Sản phẩm không tồn tại.");

        if (1 > product.quantity)
            throw new Exception("Không đủ hàng.");

        var key = GetRedisKey();

        var cart = await _cartRepo.GetAsync(key);

        if (cart == null)
            return;

        var item = cart.items.FirstOrDefault(x => x.product_id == dto.ProductId);

        if (item == null)
            return;

        item.quantity = 1;

        await _cartRepo.SaveAsync(key, cart);
    }
    public async Task RemoveFromCartAsync(int productId)
    {
        var key = GetRedisKey();

        var cart = await _cartRepo.GetAsync(key);

        if (cart == null)
            return;

        cart.items.RemoveAll(x => x.product_id == productId);

        await _cartRepo.SaveAsync(key, cart);
    }
    public async Task ClearCartAsync()
    {
        var key = GetRedisKey();

        await _cartRepo.DeleteAsync(key);
    }
    public async Task MergeCartAsync()
    {
        var http = _httpContextAccessor.HttpContext!;

        var userId = http.User.FindFirstValue(ClaimTypes.NameIdentifier);

        if (string.IsNullOrEmpty(userId))
            throw new Exception("Người dùng chưa đăng nhập.");

        if (!http.Request.Headers.TryGetValue("Guest-Id", out var guestId))
            return;

        var guestKey = $"cart:guest:{guestId}";
        var userKey = $"cart:user:{userId}";

        var guestCart = await _cartRepo.GetAsync(guestKey);

        if (guestCart == null || guestCart.items.Count == 0)
            return;

        var userCart = await _cartRepo.GetAsync(userKey) ?? new Cart();

        foreach (var guestItem in guestCart.items)
        {
            var userItem = userCart.items
                .FirstOrDefault(x => x.product_id == guestItem.product_id);

            if (userItem == null)
            {
                userCart.items.Add(new CartItem
                {
                    product_id = guestItem.product_id,
                    quantity = guestItem.quantity
                });
            }
            else
            {
                userItem.quantity += guestItem.quantity;
            }
        }

        await _cartRepo.SaveAsync(userKey, userCart);

        await _cartRepo.DeleteAsync(guestKey);
    }

}