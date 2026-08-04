using Microsoft.EntityFrameworkCore;
using Service.Data;
using Service.DTOs;
using Service.Models;
using Service.Repositories.Interfaces;
using System.Reflection.Metadata.Ecma335;

namespace Service.Repositories
{
    public class AuthRepository(DBContext context) : IAuthRepository
    {
        private readonly DBContext _context = context;
        public async Task<User?> GetByEmailAsync(string email)
        {
            return await _context.Users.Where(u => u.email == email).FirstOrDefaultAsync();
        }
        public async Task<User> CreateUserAsync(User user)
        {
            _context.Users.Add(user);
            await _context.SaveChangesAsync();
            return user;
        }
        public void UpdateUser(User user)
        {
            _context.Users.Update(user);
        }
    }
}
