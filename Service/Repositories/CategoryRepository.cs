using Microsoft.EntityFrameworkCore;
using Service.Data;
using Service.Models;
using Service.Repositories.Interfaces;

namespace Service.Repositories
{
    public class CategoryRepository(DBContext context) : ICategoryRepository
    {
        private readonly DBContext _context = context;
        public async Task<List<Category>> GetAllAsync()
        {
            return await _context.Categories.Where(c => c.is_active).ToListAsync();
        }
    }
}
