using Microsoft.EntityFrameworkCore.Storage;
using Newtonsoft.Json.Linq;
using Service.Data;
using Service.Models;
using Service.Repositories.Interfaces;
using StackExchange.Redis;
using System.Text.Json;

namespace Service.Repositories
{
    public class CartRepository : ICartRepository
    {
        private readonly StackExchange.Redis.IDatabase _db;
        public CartRepository(IConnectionMultiplexer connection)
        {
            _db = connection.GetDatabase();
        }
        public async Task<Cart?> GetAsync(string key)
        {
            var value = await _db.StringGetAsync(key);

            if (value.IsNullOrEmpty)
                return null;

            return JsonSerializer.Deserialize<Cart>(value!);
        }
        public async Task SaveAsync(string key, Cart cart)
        {
            var value = JsonSerializer.Serialize(cart);
            if (key.StartsWith("cart:guest:"))
            {
                await _db.StringSetAsync(
                key,
                    value,
                    TimeSpan.FromDays(30)
                );
            }
            else
            {
                await _db.StringSetAsync(
                key,
                    value
                );
            }
        }

        public async Task DeleteAsync(string key)
        {
            await _db.KeyDeleteAsync(key);
        }
    }
}
