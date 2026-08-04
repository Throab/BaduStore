using Service.DTOs;

namespace Service.Services.Interfaces
{
    public interface IProductService
    {
        Task<List<ProductDTO>> GetAllAsync();
        Task<ProductDetailDTO?> GetByIdAsync(int id);
        Task<ProductDetailDTO?> GetByAliasAsync(string alias);
        Task<List<ProductDTO>> GetProductsByCategoryAsync(int categoryId);
        Task<List<ProductDTO>> GetProductsByBrandAsync(int brandId);
        Task InsertProductAsync(ProductCreateDTO dto);
        Task DeleteProductAsync(int id);
        Task ChangeProductStateAsync(int id);
        Task<List<ProductDTO>> GetProductsByFilterAsync(ProductFilterDTO dto);
        Task<List<ProductDTO>> GetHotProductsAsync(int take);
    }
}
