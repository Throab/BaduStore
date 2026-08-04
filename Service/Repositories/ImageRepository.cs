using Service.Data;
using Service.Models;
using Service.Repositories.Interfaces;

namespace Service.Repositories
{
    public class ImageRepository(DBContext context) : IImageRepository
    {
        DBContext _context = context;
        public void InsertImage(Image img)
        {
            _context.Images.Add(img);
        }
    }
}
