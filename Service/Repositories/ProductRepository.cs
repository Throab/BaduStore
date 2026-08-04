using Azure.Core;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration.UserSecrets;
using Service.Data;
using Service.DTOs;
using Service.Models;
using Service.Repositories.Interfaces;
using System.Data.Entity.SqlServer.Utilities;
using System.Linq;
using static System.Net.Mime.MediaTypeNames;

namespace Service.Repositories
{
    public class ProductRepository(DBContext context) : IProductRepository
    {
        private readonly DBContext _context = context;
        public async Task<List<Product>> GetAllAsync()
        {
            return await _context.Products.AsNoTracking().Where(p => p.is_active).Include(p => p.Images).ToListAsync();
        }
        public async Task<Product?> GetByIdAsync(int id)
        {
            return await _context.Products.AsNoTracking().Where(p => p.is_active).Include(p => p.Category).Include(p => p.Brand).Include(p => p.Images).Include(p => p.ProductAttributes).ThenInclude(pa => pa.Attribute).FirstOrDefaultAsync(p => p.id == id);
        }
        public async Task<Product?> GetByIdToUpdateAsync(int id)
        {
            return await _context.Products
                .Where(p => p.is_active && p.id == id)
                .FirstOrDefaultAsync();
        }
        public async Task<List<Product>> GetProductsByCategoryAsync(int categoryId)
        {
            return await _context.Products.AsNoTracking().Where(p => p.is_active).Where(p => p.category_id == categoryId).ToListAsync();
        }
        public async Task<List<Product>> GetProductsByBrandAsync(int brandId)
        {
            return await _context.Products.AsNoTracking().Where(p => p.is_active).Where(p => p.brand_id == brandId).ToListAsync();
        }
        public async Task<Product?> GetProductByAliasAsync(string alias)
        {
            return await _context.Products.AsNoTracking().Where(p => p.is_active).Include(p => p.Category).Include(p => p.Brand).Include(p => p.Images).Include(p => p.ProductAttributes).ThenInclude(pa => pa.Attribute).FirstOrDefaultAsync(p => p.alias == alias);
        }
        public async Task<List<ProductDTO>> GetProductsByFilterAsync(ProductFilterDTO dto)
        {
            var query = _context.Products.AsNoTracking().AsQueryable().Where(p => p.is_active);
            // Search
            if (!string.IsNullOrWhiteSpace(dto.KeySearch))
            {
                query = query.Where(x =>
                    x.product_name.Contains(dto.KeySearch) ||
                    x.alias.Contains(dto.KeySearch));
            }

            // Category
            if (dto.CategoryId.HasValue)
            {
                query = query.Where(x => x.category_id == dto.CategoryId);
            }

            // Brand
            if (dto.BrandId.HasValue)
            {
                query = query.Where(x => x.brand_id == dto.BrandId);
            }

            // Price
            if (dto.PriceFrom.HasValue)
            {
                query = query.Where(x => x.price >= dto.PriceFrom);
            }

            if (dto.PriceTo.HasValue)
            {
                query = query.Where(x => x.price <= dto.PriceTo);
            }
            // Sort
            if (!string.IsNullOrWhiteSpace(dto.OrderBy))
            {
                switch (dto.OrderBy)
                {
                    case "price-asc":
                        query = query.OrderBy(x => x.price);
                        break;
                    case "price-desc":
                        query = query.OrderByDescending(x => x.price);
                        break;
                }
            }

            var totalItems = await query.CountAsync();

            var items = await query
            .Skip((dto.Page - 1) * dto.PageSize)
            .Take(dto.PageSize)
                .Select(x => new ProductDTO
                {
                    Id = x.id,
                    Name = x.product_name,
                    Alias = x.alias,
                    Price = x.price,
                    IsHot = x.is_hot,
                    IsActive = x.is_active,
                    ThumbURL = x.Images
                        .Where(i => i.is_thumb)
                        .Select(i => i.url)
                        .FirstOrDefault()
                })
                .ToListAsync();
            return items;
        }
        public void InsertProduct(Product product)
        {
            _context.Products.Add(product);
        }

        public void UpdateProduct(Product product)
        {
            _context.Products.Update(product);
        }

        public void DeleteProduct(Product product)
        {
            _context.Products.Remove(product);
        }
        public async Task<List<Product>> GetHotProductsAsync(int take)
        {
            return await _context.Products.AsNoTracking().Where(p => p.is_active && p.is_hot).Include(p => p.Images).OrderByDescending(p => p.created_at).Take(take).ToListAsync();
        }
        public async Task<List<Product>> GetProductsByIdsAsync(List<int> productIds)
        {
            if (productIds == null || !productIds.Any())
                return new List<Product>();

            return await _context.Products
                .AsNoTracking()
                .Where(p => p.is_active && productIds.Contains(p.id))
                .Include(p => p.Images)
                .ToListAsync();
        }
    }
}
