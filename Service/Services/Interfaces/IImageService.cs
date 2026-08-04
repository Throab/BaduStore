using Service.DTOs;

namespace Service.Services.Interfaces
{
    public interface IImageService
    {
        Task<ImageUpdateDTO> UploadImageAsync(IFormFile file);
        Task<List<ImageUpdateDTO>> UploadImagesAsync(List<IFormFile> files);
        Task<bool> DeleteImageAsync(string key);
    }
}
