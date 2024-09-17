using AutoMapper;
using ProductShop.DTOs.Export;
using ProductShop.DTOs.Import;
using ProductShop.Models;

namespace ProductShop;

public class ProductShopProfile : Profile
{
    public ProductShopProfile() 
    {
        //User
        this.CreateMap<ImportUserDto, User>();
        this.CreateMap<User, ExportUserWithSoldProductsDto>()
            .ForMember(d => d.SoldProductDtos, opt => opt.MapFrom(s => s.ProductsSold
                                                                        .Where(p => p.Buyer != null)));
        //Product
        this.CreateMap<ImportProductDto, Product>();
        this.CreateMap<Product, ExportProductInRangeDto>()
            .ForMember(d => d.ProductName, opt => opt.MapFrom(s => s.Name))
            .ForMember(d => d.ProductPrice, opt => opt.MapFrom(s => s.Price))
            .ForMember(d => d.SellerName, opt => opt.MapFrom(s => $"{s.Seller.FirstName} {s.Seller.LastName}"));
        this.CreateMap<Product, ExportSoldProductDto>()
            .ForMember(d => d.BuyerFirstName, opt => opt.MapFrom(s => s.Buyer.FirstName))
            .ForMember(d => d.BuyerLastName, opt => opt.MapFrom(s => s.Buyer.LastName));
        //Category
        this.CreateMap<ImportCategoryDto, Category>();
        this.CreateMap<Category, ExportCategoryByProductsDto>()
            .ForMember(d => d.ProductsCount, opt => opt.MapFrom(s => s.CategoriesProducts.Count()))
            .ForMember(d => d.AveragePrice, opt => opt.MapFrom(s => s.CategoriesProducts.Any() ?
                                               s.CategoriesProducts.Average(cp => cp.Product.Price).ToString("f2") : "0"))
            .ForMember(d => d.TotalRevenue, opt => opt.MapFrom(s => s.CategoriesProducts.Any() ?
                                               s.CategoriesProducts.Sum(cp => cp.Product.Price).ToString("f2") : "0"));
        //CategryProduct
        this.CreateMap<ImportCategoryProductDto, CategoryProduct>();
    }
}
