using Service.DTOs;
using Service.Repositories.Interfaces;
using Service.Services.Interfaces;

namespace Service.Services
{
    public class CategoryService(ICategoryRepository repo) : ICategoryService
    {
        private readonly ICategoryRepository _repo = repo;
        public async Task<List<CategoryDTO>> GetAllAsync()
        {
            var categories = await _repo.GetAllAsync();
            return categories.Select(x => new CategoryDTO
            {
                Id = x.id,
                Name = x.name,
                DisplayName = x.display_name,
                Alias = x.alias,
                ParentId = x.parent_id,
                Image = x.image ?? "",
                IsActive = x.is_active,
            }).ToList();
        }
    }
}
