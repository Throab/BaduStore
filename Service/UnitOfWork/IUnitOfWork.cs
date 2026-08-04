using Microsoft.EntityFrameworkCore.Storage;
using System.Threading.Tasks;

namespace Service.UnitOfWork
{
    public interface IUnitOfWork
    {
        Task<int> SaveChangesAsync();
        Task<IDbContextTransaction> BeginTransactionAsync();
    }
}
