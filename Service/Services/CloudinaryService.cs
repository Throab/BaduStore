using CloudinaryDotNet;
using CloudinaryDotNet.Actions;
using Service.DTOs;
using Service.Services.Interfaces;

namespace Service.Services
{
    public class CloudinaryService : IImageService
    {
        private readonly Cloudinary _cloudinary;
        public CloudinaryService(IConfiguration configuration)
        {
            var account = new Account(
                configuration["Cloudinary:CloudName"],
                configuration["Cloudinary:ApiKey"],
                configuration["Cloudinary:ApiSecret"]
            );
            _cloudinary = new Cloudinary(account);
        }
        public async Task<ImageUpdateDTO> UploadImageAsync(IFormFile file)
        {
            if (file == null || file.Length == 0)
                return null;

            if (!file.ContentType.StartsWith("image/"))
                return null;

            using var stream = file.OpenReadStream();

            var uploadParams = new ImageUploadParams
            {
                File = new FileDescription(file.FileName, stream),
                Folder = "products",
                Transformation = new Transformation().Width(800).Height(800)
                    .Quality("auto")
                    .FetchFormat("auto")
            };

            var uploadResult = await _cloudinary.UploadAsync(uploadParams);

            if (uploadResult.Error != null)
                return null;

            return new ImageUpdateDTO
            {
                Url = uploadResult.SecureUrl.ToString(),
                Key = uploadResult.PublicId,
            };
        }
        public async Task<List<ImageUpdateDTO>> UploadImagesAsync(List<IFormFile> files)
        {
            var result = new List<ImageUpdateDTO>();

            foreach (var file in files)
            {
                var uploadResult = await UploadImageAsync(file);

                if (uploadResult == null)
                    continue;

                result.Add(new ImageUpdateDTO
                {
                    Url = uploadResult.Url,
                    Key = uploadResult.Key
                });
            }

            return result;
        }
        public async Task<bool> DeleteImageAsync(string key)
        {
            if (string.IsNullOrWhiteSpace(key))
                return false;

            var deleteParams = new DeletionParams(key);

            var result = await _cloudinary.DestroyAsync(deleteParams);

            return result.Result == "ok";
        }
    }
}
