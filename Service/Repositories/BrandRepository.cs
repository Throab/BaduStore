using Microsoft.EntityFrameworkCore;
using Service.Data;
using Service.Models;
using Service.Repositories.Interfaces;

namespace Service.Repositories
{
    public class BrandRepository(DBContext context) : IBrandRepository
    {
        private readonly DBContext _context = context;
        public async Task<List<Brand>> GetAllAsync()
        {
            return await _context.Brands.Where(b => b.is_active).ToListAsync();
        }
    }
}
