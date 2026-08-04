using Service.DTOs;
using Service.Repositories.Interfaces;
using Service.Services.Interfaces;

namespace Service.Services
{
    public class BrandService(IBrandRepository repo) : IBrandService
    {
        private readonly IBrandRepository _repo = repo;
        public async Task<List<BrandDTO>> GetAllAsync()
        {
            var brands = await _repo.GetAllAsync();
            return brands.Select(x => new BrandDTO
            {
                Id = x.id,
                Name = x.name,
                DisplayName = x.display_name,
                Alias = x.alias,
                Image = (x.image != null) ? x.image : "",
                IsActive = x.is_active
            }).ToList();
        }
    }
}
