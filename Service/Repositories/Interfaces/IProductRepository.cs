using Service.DTOs;
using Service.Models;

namespace Service.Repositories.Interfaces
{
    public interface IProductRepository
    {
        Task<List<Product>> GetAllAsync();
        Task<Product?> GetByIdAsync(int id);
        Task<List<Product>> GetProductsByCategoryAsync(int categoryId);
        Task<List<Product>> GetProductsByBrandAsync(int brandId);
        Task<List<Product>> GetHotProductsAsync(int take);
        Task<Product?> GetProductByAliasAsync(string alias);
        Task<List<ProductDTO>> GetProductsByFilterAsync(ProductFilterDTO filter);
        void DeleteProduct(Product product);
        void InsertProduct(Product product);
        void UpdateProduct(Product product);
        Task<List<Product>> GetProductsByIdsAsync(List<int> productIds);
        Task<Product?> GetByIdToUpdateAsync(int id);
    }
}
