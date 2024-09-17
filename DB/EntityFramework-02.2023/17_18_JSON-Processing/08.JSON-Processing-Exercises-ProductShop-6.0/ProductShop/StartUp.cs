using AutoMapper;
using AutoMapper.QueryableExtensions;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using ProductShop.Data;
using ProductShop.DTOs.Export;
using ProductShop.DTOs.Import;
using ProductShop.Models;

namespace ProductShop;

public class StartUp
{
    public static void Main()
    {
        ProductShopContext context = new ProductShopContext();

        //string inputJson = 
        //    File.ReadAllText(@"../../../Datasets/categories-products.json");

        string result = GetUsersWithProducts(context);
        Console.WriteLine(result);
    }

    private static IMapper CreateMapper()
    {
        return new Mapper(new MapperConfiguration(cfg =>
        {
            cfg.AddProfile<ProductShopProfile>();
        }));
    }

    //Query 1 -> Import
    public static string ImportUsers(ProductShopContext context, string inputJson)
    {
        IMapper mapper = CreateMapper();

        ImportUserDto[] userDtos = 
            JsonConvert.DeserializeObject<ImportUserDto[]>(inputJson);

        //AutoMapper can map collections also
        //In case of no validation (as now) you can:
        //User[] users = mapper.Map<User[]>(userDtos);

        //This way allows you addition validations
        ICollection<User> validUsers = new HashSet<User>();
        foreach (ImportUserDto userDto in userDtos)
        {
            User user = mapper.Map<User>(userDto);

            validUsers.Add(user);
        }

        //Here we have all valid users ready for the DB
        context.Users.AddRange(validUsers);
        context.SaveChanges();

        return $"Successfully imported {validUsers.Count}";
    }

    //Query 2
    public static string ImportProducts(ProductShopContext context, string inputJson)
    {
        IMapper mapper = CreateMapper();

        ImportProductDto[] productDtos = 
            JsonConvert.DeserializeObject<ImportProductDto[]>(inputJson);

        Product[] products = mapper.Map<Product[]>(productDtos);

        context.Products.AddRange(products);
        context.SaveChanges();

        return $"Successfully imported {products.Length}";
    }

    //Query 3
    public static string ImportCategories(ProductShopContext context, string inputJson)
    {
        IMapper mapper = CreateMapper();

        //In this collection of DTOs, there can be invalid entries
        ImportCategoryDto[] categoryDtos = 
            JsonConvert.DeserializeObject<ImportCategoryDto[]>(inputJson);

        ICollection<Category> validCategories = new HashSet<Category>();
        foreach (var categoryDto in categoryDtos)
        {
            if (string.IsNullOrEmpty(categoryDto.Name))
            {
                continue;
            }
            Category category = mapper.Map<Category>(categoryDto);
            validCategories.Add(category);
        }

        context.Categories.AddRange(validCategories);
        context.SaveChanges();

        return $"Successfully imported {validCategories.Count}";
    }

    //Query 4
    public static string ImportCategoryProducts(ProductShopContext context, string inputJson)
    {
        IMapper mapper = CreateMapper();

        ImportCategoryProductDto[] categoryProductDtos = 
            JsonConvert.DeserializeObject<ImportCategoryProductDto[]>(inputJson);

        ICollection<CategoryProduct> validEntries = new HashSet<CategoryProduct>();
        foreach (ImportCategoryProductDto cpDto in categoryProductDtos)
        {
            //This is not wanted in description but we do it for security
            //if (!context.Categories.Any(c => c.Id == cpDto.CategoryId) ||
            //    !context.Products.Any(p => p.Id == cpDto.ProductId))
            //    {
            //        continue;
            //    }
            CategoryProduct categoryProduct = mapper.Map<CategoryProduct>(cpDto);
            validEntries.Add(categoryProduct);
        }

        context.CategoriesProducts.AddRange(validEntries);
        context.SaveChanges();

        return $"Successfully imported {validEntries.Count}";
    }

    //Query 5 -> Export
    public static string GetProductsInRange(ProductShopContext context)
    {
        //Anonymous objects + Manual Mapping
        //DTO + Manual Mapping
        //DTO + AutoMapper

        //Solution 1: Anonymous objects + Manual Mapping
        //var products = context.Products
        //                 .Where(p => p.Price >= 500 && p.Price <= 1000)
        //                 .OrderBy(p => p.Price)
        //                 .Select(p => new
        //                 {
        //                     name = p.Name,
        //                     price = p.Price,
        //                     seller = p.Seller.FirstName + " " + p.Seller.LastName,
        //                 })
        //                 .AsNoTracking()
        //                 .ToArray();
        //
        //return JsonConvert.SerializeObject(products, Formatting.Indented);

        //Solution 2: DTO + AutoMapper
        IMapper mapper = CreateMapper();
        ExportProductInRangeDto[] productDtos = context.Products
                        .Where(p => p.Price >= 500 && p.Price <= 1000)
                        .OrderBy(p => p.Price)
                        .AsNoTracking()
                        .ProjectTo<ExportProductInRangeDto>(mapper.ConfigurationProvider)
                        .ToArray();

        return JsonConvert.SerializeObject(productDtos, Formatting.Indented);
    }

    private static IContractResolver ConfigureCamelCaseNaming()
    {
        return new DefaultContractResolver()
        {
            NamingStrategy = new CamelCaseNamingStrategy(false, true)
        };
    }
    //Query 6
    public static string GetSoldProducts(ProductShopContext context)
    {
        
        IContractResolver contractResolver = ConfigureCamelCaseNaming(); //automaticaly use camelCase naming in Json

        //Solution 1: Anonymous objects + Manual Mapping
        //var usersWithSoldProducts = context.Users
        //                    .Where(u => u.ProductsSold.Any(p => p.Buyer != null))
        //                    .OrderBy(u => u.LastName)
        //                    .ThenBy(u => u.FirstName)
        //                    .Select(u => new
        //                    {
        //                        u.FirstName,
        //                        u.LastName,
        //                        SoldProducts = u.ProductsSold
        //                                        .Where(p => p.Buyer != null)
        //                                        .Select(p => new
        //                                        {
        //                                            p.Name,
        //                                            p.Price,
        //                                            BuyerFirstName = p.Buyer.FirstName,
        //                                            BuyerLastName = p.Buyer.LastName
        //                                        })
        //                                        .ToArray()
        //                    })
        //                    .AsNoTracking()
        //                    .ToArray();

        //Solution 2: DTO + AutoMapper
        IMapper mapper = CreateMapper();
        ExportUserWithSoldProductsDto[] usersWithSoldProductsDtos = context.Users
                            .Where(u => u.ProductsSold.Any(p => p.Buyer != null))
                            .OrderBy(u => u.LastName)
                            .ThenBy(u => u.FirstName)
                            .AsNoTracking()
                            .ProjectTo<ExportUserWithSoldProductsDto>(mapper.ConfigurationProvider)
                            .ToArray();

        return JsonConvert.SerializeObject(usersWithSoldProductsDtos, 
                                           Formatting.Indented, 
                                           new JsonSerializerSettings()
                                           {
                                               ContractResolver = contractResolver
                                           });
    }

    //Query 7
    public static string GetCategoriesByProductsCount(ProductShopContext context)
    {
        IContractResolver contractResolver = ConfigureCamelCaseNaming();

        //Solution 1: Anonymous objects + Manual Mapping
        //var categories = context.Categories
        //                    .OrderByDescending(c => c.CategoriesProducts.Count())
        //                    .Select(c => new
        //                    {
        //                        Category = c.Name,
        //                        ProductsCount = c.CategoriesProducts
        //                                         .Count(),
        //                        AveragePrice = c.CategoriesProducts.Any() ?
        //                                       c.CategoriesProducts.Average(cp => cp.Product.Price).ToString("f2") : "0",
        //                        TotalRevenue = c.CategoriesProducts.Any() ?
        //                                       c.CategoriesProducts.Sum(cp => cp.Product.Price).ToString("f2") : "0"
        //                    })
        //                    .AsNoTracking()
        //                    .ToArray();

        //Solution 2: DTO + AutoMapper
        IMapper mapper = CreateMapper();
        ExportCategoryByProductsDto[] categoriesDtos = context.Categories
                .OrderByDescending(c => c.CategoriesProducts.Count())
                .AsNoTracking()
                .ProjectTo<ExportCategoryByProductsDto>(mapper.ConfigurationProvider)
                .ToArray();

        return JsonConvert.SerializeObject(categoriesDtos,
                                           Formatting.Indented,
                                           new JsonSerializerSettings()
                                           {
                                               ContractResolver = contractResolver
                                           });
    }

    //Query 8
    public static string GetUsersWithProducts(ProductShopContext context)
    {
        IContractResolver contractResolver = ConfigureCamelCaseNaming();

        //Solution 1: Anonymous objects + Manual Mapping
        var usersWithProducts = context.Users
                                    .Where(u => u.ProductsSold.Any(p => p.Buyer != null))
                                    .Select(u => new
                                    {  //UserDTO
                                        u.FirstName,
                                        u.LastName,
                                        u.Age,
                                        SoldProducts = new
                                        {  //ProductWrapperDTO
                                            Count = u.ProductsSold.Count(p => p.Buyer != null),
                                            Products = u.ProductsSold
                                                        .Where(p => p.Buyer != null)
                                                        .Select(p => new
                                                        {  //ProductDTO
                                                            p.Name,
                                                            p.Price
                                                        })
                                                        .ToArray()
                                        }
                                        
                                        
                                    })
                                    .OrderByDescending(u => u.SoldProducts.Count)
                                    .AsNoTracking()
                                    .ToArray();
        var userWrapperDto = new
        {
            UsersCount = usersWithProducts.Length,
            Users = usersWithProducts
        };

        return JsonConvert.SerializeObject(userWrapperDto,
                                           Formatting.Indented,
                                           new JsonSerializerSettings()
                                           {
                                               ContractResolver = contractResolver,
                                               NullValueHandling = NullValueHandling.Ignore,
                                           });
    }
}