using Microsoft.Identity.Client;
using Service.Data;
using Service.DTOs;
using Service.Models;
using Service.Repositories.Interfaces;
using Service.Services.Interfaces;
using Service.UnitOfWork;
using Service.Utils;
using System;

namespace Service.Services
{
    public class ProductService : IProductService
    {
        private readonly IProductRepository _repo;
        private readonly IImageRepository _imageRepository;
        private readonly IImageService _imageService;
        private readonly IUnitOfWork _unitOfWork;

        public ProductService(IProductRepository repo, IImageService imageService, IImageRepository imageRepository, IUnitOfWork unitOfWork)
        {
            _repo = repo;
            _imageService = imageService;
            _imageRepository = imageRepository;
            _unitOfWork = unitOfWork;
        }
        public async Task<List<ProductDTO>> GetAllAsync()
        {
            var products = await _repo.GetAllAsync();
            return products.Select(x => new ProductDTO
            {
                Id = x.id,
                Name = x.product_name,
                Alias = x.alias,
                Price = x.price,
                IsHot = x.is_hot,
                IsActive = x.is_active,
                ThumbURL = x.Images.Where(i => i.is_thumb).Select(i => i.url).FirstOrDefault() ?? "",
            }).ToList();
        }
        public async Task<ProductDetailDTO?> GetByIdAsync(int id)
        {

            var product = await _repo.GetByIdAsync(id);
            if (product == null) return null;
            return new ProductDetailDTO
            {
                Id = product.id,
                Name = product.product_name,
                Alias = product.alias,
                BrandId = product.brand_id,
                CategoryId = product.category_id,
                Price = product.price,
                Quantity = product.quantity,
                Description = product.description,
                IsHot = product.is_hot,
                IsActive = product.is_active,
                CreatedAt = product.created_at,
                UpdatedAt = product.updated_at,
                BrandName = product.Brand != null ? product.Brand.display_name : null,
                CategoryName = product.Category != null ? product.Category.display_name : null,
                Images = product.Images.Select(i => new ImageDTO
                {
                    Id = i.id,
                    Url = i.url,
                    IsThumb = i.is_thumb
                }).ToList(),
                Attributes = product.ProductAttributes.Where(pa => pa.Attribute != null).Select(pa => new AttributeDTO
                {
                    Id = pa.Attribute.id,
                    AttributeName = pa.Attribute.name,
                    Value = pa.Attribute.value
                }).ToList()
            };
        }
        public async Task<ProductDetailDTO?> GetByAliasAsync(string alias)
        {

            var product = await _repo.GetProductByAliasAsync(alias);
            if (product == null) return null;
            return new ProductDetailDTO
            {
                Id = product.id,
                Name = product.product_name,
                Alias = product.alias,
                BrandId = product.brand_id,
                CategoryId = product.category_id,
                Price = product.price,
                Quantity = product.quantity,
                Description = product.description,
                IsHot = product.is_hot,
                IsActive = product.is_active,
                CreatedAt = product.created_at,
                UpdatedAt = product.updated_at,
                BrandName = product.Brand != null ? product.Brand.display_name : null,
                CategoryName = product.Category != null ? product.Category.display_name : null,
                Images = product.Images.Select(i => new ImageDTO
                {
                    Id = i.id,
                    Url = i.url,
                    IsThumb = i.is_thumb
                }).ToList(),
                Attributes = product.ProductAttributes.Where(pa => pa.Attribute != null).Select(pa => new AttributeDTO
                {
                    Id = pa.Attribute.id,
                    AttributeName = pa.Attribute.name,
                    Value = pa.Attribute.value
                }).ToList()
            };
        }
        public async Task<List<ProductDTO>> GetProductsByCategoryAsync(int categoryId)
        {
            var products = await _repo.GetProductsByCategoryAsync(categoryId);
            return products.Select(x => new ProductDTO
            {
                Id = x.id,
                Name = x.product_name,
                Alias = x.alias,
                Price = x.price,
                IsHot = x.is_hot,
                IsActive = x.is_active,
                ThumbURL = x.Images.Where(i => i.is_thumb).Select(i => i.url).FirstOrDefault() ?? "",
            }).ToList();
        }
        public async Task<List<ProductDTO>> GetProductsByBrandAsync(int brandId)
        {
            var products = await _repo.GetProductsByBrandAsync(brandId);
            return products.Select(x => new ProductDTO
            {
                Id = x.id,
                Name = x.product_name,
                Alias = x.alias,
                Price = x.price,
                IsHot = x.is_hot,
                IsActive = x.is_active,
                ThumbURL = x.Images.Where(i => i.is_thumb).Select(i => i.url).FirstOrDefault() ?? "",
            }).ToList();
        }

        public async Task InsertProductAsync(ProductCreateDTO dto)
        {
            var uploadedKeys = new List<string>();
            await using var transaction = await _unitOfWork.BeginTransactionAsync();
            try
            {
                Product product = new Product
                {
                    product_name = dto.Name,
                    alias = "",
                    brand_id = dto.BrandId,
                    category_id = dto.CategoryId,
                    price = dto.Price,
                    quantity = dto.Quantity,
                    is_hot = dto.IsHot,
                    is_active = dto.IsActive,
                    description = dto.Description,
                    created_at = DateTime.Now,
                    updated_at = DateTime.Now,
                };
                _repo.InsertProduct(product);
                await _unitOfWork.SaveChangesAsync();
                product.alias = DataHelper.ToAlias(product.product_name) + "-" + product.id;
                if (dto.ThumbImage != null && dto.ThumbImage.Length > 0)
                {
                    var thumbUrl = await _imageService.UploadImageAsync(dto.ThumbImage);
                    if (thumbUrl == null)
                        throw new Exception("Upload image failed!");
                    uploadedKeys.Add(thumbUrl.Key);
                    Image thumbImg = new Image
                    {
                        product_id = product.id,
                        url = thumbUrl.Url,
                        key = thumbUrl.Key,
                        is_thumb = true,
                    };
                    _imageRepository.InsertImage(thumbImg);
                }
                if (dto.Images != null && dto.Images.Count > 0)
                {
                    var images = await _imageService.UploadImagesAsync(dto.Images);
                    if (images == null)
                        throw new Exception("Upload images failed!");
                    foreach (var item in images)
                    {
                        _imageRepository.InsertImage(new Image
                        {
                            product_id = product.id,
                            url = item.Url,
                            key = item.Key,
                            is_thumb = false
                        });
                        uploadedKeys.Add(item.Key);
                    }
                }
                await _unitOfWork.SaveChangesAsync();
                await transaction.CommitAsync();
            }
            catch
            {
                await transaction.RollbackAsync();
                foreach (var key in uploadedKeys)
                {
                    await _imageService.DeleteImageAsync(key);
                }
                throw;

            }
        }
        public async Task DeleteProductAsync(int id)
        {
            var product = await _repo.GetByIdAsync(id);
            if (product == null) throw new Exception("Product not found.");
            _repo.DeleteProduct(product);
            await _unitOfWork.SaveChangesAsync();
        }
        public async Task ChangeProductStateAsync(int id)
        {
            var product = await _repo.GetByIdAsync(id);
            if (product == null) throw new Exception("Product not found.");
            product.is_active = !product.is_active;
            product.updated_at = DateTime.Now;
            _repo.UpdateProduct(product);
            await _unitOfWork.SaveChangesAsync();
        }
        public async Task<List<ProductDTO>> GetProductsByFilterAsync(ProductFilterDTO dto)
        {
            var products = await _repo.GetProductsByFilterAsync(dto);
            return products;
        }
        public async Task<List<ProductDTO>> GetHotProductsAsync(int take)
        {
            var products = await _repo.GetHotProductsAsync(take);
            return products.Select(x => new ProductDTO
            {
                Id = x.id,
                Name = x.product_name,
                Alias = x.alias,
                Price = x.price,
                IsHot = x.is_hot,
                IsActive = x.is_active,
                ThumbURL = x.Images.Where(i => i.is_thumb).Select(i => i.url).FirstOrDefault() ?? "",
            }).ToList();
        }
    }
}