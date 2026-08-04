using Service.DTOs;

namespace Service.Services.Interfaces
{
    public interface IBrandService
    {
        Task<List<BrandDTO>> GetAllAsync();
    }
}
