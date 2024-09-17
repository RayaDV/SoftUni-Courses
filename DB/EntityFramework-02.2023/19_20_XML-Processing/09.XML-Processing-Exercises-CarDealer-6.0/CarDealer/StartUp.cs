using AutoMapper;
using AutoMapper.QueryableExtensions;
using CarDealer.Data;
using CarDealer.DTOs.Export;
using CarDealer.DTOs.Import;
using CarDealer.Models;
using CarDealer.Utilities;
using Castle.Core.Resource;
using System.Data;
using System.IO;
using System.Text;
using System.Xml.Serialization;

namespace CarDealer;

public class StartUp
{
    public static void Main()
    {
        //XmlSerializer -> Analogue to JsonConvert. Provide us with Serialize and Deserialize methods.
        using CarDealerContext context = new CarDealerContext();
        //string inputXml = File.ReadAllText("../../../Datasets/sales.xml");

        string result = GetTotalSalesByCustomer(context);
        Console.WriteLine(result);
    }

    private static IMapper InitializeAutoMapper()
    {
        return new Mapper(new MapperConfiguration(cfg =>
        {
            cfg.AddProfile<CarDealerProfile>();
        }));
    }

    //Query 9 -> Import
    public static string ImportSuppliers(CarDealerContext context, string inputXml)
    {
        IMapper mapper = InitializeAutoMapper();

        XmlHelper xmlHelper = new XmlHelper();
        ImportSupplierDto[] supplierDtos = 
            xmlHelper.Deserialize<ImportSupplierDto[]>(inputXml, "Suppliers");

        //The second method is just syntaxis sugar; written for user experience
        //ImportSupplierDto[] supplierDtos2 = 
        //    xmlHelper.DeserialiseCollection<ImportSupplierDto>(inputXml, "Suppliers")
        //             .ToArray();

        ICollection<Supplier> validSuppliers = new HashSet<Supplier>();
        foreach (ImportSupplierDto supplierDto in supplierDtos)
        {
            //Validation - if the name in xml is null or empty, omit it
            if (string.IsNullOrEmpty(supplierDto.Name))
            {
                continue;
            }

            //Manual mapping without AutoMapper
            //Supplier supplier = new Supplier()
            //{
            //    Name = supplierDto.Name,
            //    IsImporter = supplierDto.IsImporter
            //};
            //Using AutoMapper and previously created mapper
            Supplier supplier = mapper.Map<Supplier>(supplierDto);

            validSuppliers.Add(supplier);
        }

        context.Suppliers.AddRange(validSuppliers);
        context.SaveChanges();

        return $"Successfully imported {validSuppliers.Count}";
    }

    //Query 10
    public static string ImportParts(CarDealerContext context, string inputXml)
    {
        IMapper mapper = InitializeAutoMapper();

        XmlHelper xmlHelper = new XmlHelper();
        ImportPartDto[] partDtos =
            xmlHelper.Deserialize<ImportPartDto[]>(inputXml, "Parts");

        ICollection<Part> validParts = new HashSet<Part>();
        foreach (ImportPartDto partDto in partDtos)
        {
            if (string.IsNullOrEmpty(partDto.Name))
            {
                continue;
            }

            if (!partDto.SupplierId.HasValue ||
                !context.Suppliers.Any(s => s.Id == partDto.SupplierId))
            {
                //Missing or wrong SupplierId
                continue;
            }

            Part part = mapper.Map<Part>(partDto);
            validParts.Add(part);
        }

        context.Parts.AddRange(validParts); 
        context.SaveChanges();

        return $"Successfully imported {validParts.Count}";
    }

    //Query 11
    public static string ImportCars(CarDealerContext context, string inputXml)
    {
        IMapper mapper = InitializeAutoMapper();

        XmlHelper xmlHelper = new XmlHelper();
        ImportCarDto[] carDtos =
            xmlHelper.Deserialize<ImportCarDto[]>(inputXml, "Cars");

        ICollection<Car> validCars = new HashSet<Car>();
        foreach (ImportCarDto carDto in carDtos)
        {
            if (string.IsNullOrEmpty(carDto.Model) ||
                string.IsNullOrEmpty(carDto.Make))
            {
                continue;
            }

            Car car = mapper.Map<Car>(carDto);

            foreach (ImportCarPartDto carPartDto in carDto.Parts.DistinctBy(p => p.PartId))
            {
                if (!context.Parts.Any(p => p.Id == carPartDto.PartId))
                {
                    continue;
                }

                PartCar carPart = new PartCar()
                {
                    PartId = carPartDto.PartId,
                };
                car.PartsCars.Add(carPart);
            }

            validCars.Add(car);
        }

        context.Cars.AddRange(validCars);
        context.SaveChanges();

        return $"Successfully imported {validCars.Count}";
    }

    //Query 12
    public static string ImportCustomers(CarDealerContext context, string inputXml)
    {
        IMapper mapper = InitializeAutoMapper();
        XmlHelper xmlHelper = new XmlHelper();
        ImportCustomerDto[] customerDtos =
            xmlHelper.Deserialize<ImportCustomerDto[]>(inputXml, "Customers");

        ICollection<Customer> validCustomers = new HashSet<Customer>();
        foreach (ImportCustomerDto customerDto in customerDtos)
        {
            if (string.IsNullOrEmpty(customerDto.Name) ||
                string.IsNullOrEmpty(customerDto.BirthDate))
            {
                continue;
            }

            Customer customer = mapper.Map<Customer>(customerDto);
            validCustomers.Add(customer);
        }

        context.Customers.AddRange(validCustomers);
        context.SaveChanges();

        return $"Successfully imported {validCustomers.Count}";
    }

    //Query 13
    public static string ImportSales(CarDealerContext context, string inputXml)
    {
        IMapper mapper = InitializeAutoMapper();
        XmlHelper xmlHelper = new XmlHelper();
        ImportSaleDto[] saleDtos =
            xmlHelper.Deserialize<ImportSaleDto[]>(inputXml, "Sales");
        //Optimization
        ICollection<int> dbCarsIds = context.Cars
                                        .Select(c => c.Id)
                                        .ToArray();

        ICollection<Sale> validSales = new HashSet<Sale>();
        foreach (ImportSaleDto saleDto in saleDtos)
        {
            if (!saleDto.CarId.HasValue ||
                dbCarsIds.All(id => id != saleDto.CarId.Value))
            {
                continue;
            }

            Sale sale = mapper.Map<Sale>(saleDto);
            validSales.Add(sale);
        }

        context.Sales.AddRange(validSales);
        context.SaveChanges();

        return $"Successfully imported {validSales.Count}";
    }

    //Query 14
    public static string GetCarsWithDistance(CarDealerContext context)
    {
        IMapper mapper = InitializeAutoMapper();
        XmlHelper xmlHelper = new XmlHelper();

        ExportCarDto[] cars = context.Cars
                                     .Where(c => c.TraveledDistance > 2000000)
                                     .OrderBy(c => c.Make)
                                     .ThenBy(c => c.Model)
                                     .Take(10)
                                     .ProjectTo<ExportCarDto>(mapper.ConfigurationProvider)
                                     .ToArray();

        return xmlHelper.Serialize<ExportCarDto[]>(cars, "cars");
    }

    //Query 15
    public static string GetCarsFromMakeBmw(CarDealerContext context)
    {
        IMapper mapper = InitializeAutoMapper();
        XmlHelper xmlHelper = new XmlHelper();

        ExportCarBmwDto[] bmwCars = context.Cars
                                        .Where(c => c.Make.ToUpper() == "BMW")
                                        .OrderBy(c => c.Model)
                                        .ThenByDescending(c => c.TraveledDistance)
                                        .ProjectTo<ExportCarBmwDto>(mapper.ConfigurationProvider)
                                        .ToArray();

        return xmlHelper.Serialize(bmwCars, "cars");
    }

    //Query 16
    public static string GetLocalSuppliers(CarDealerContext context)
    {
        IMapper mapper = InitializeAutoMapper();
        XmlHelper xmlHelper = new XmlHelper();

        ExportLocalSupplierDto[] localSuppliers = context.Suppliers
                                        .Where(s => s.IsImporter == false)
                                        .ProjectTo<ExportLocalSupplierDto>(mapper.ConfigurationProvider)
                                        .ToArray();

        return xmlHelper.Serialize(localSuppliers, "suppliers");
    }

    //Query 17
    public static string GetCarsWithTheirListOfParts(CarDealerContext context)
    {
        IMapper mapper = InitializeAutoMapper();
        XmlHelper xmlHelper = new XmlHelper();

        ExportCarWithPartsDto[] carsWithParts = context.Cars
                                    .OrderByDescending(c => c.TraveledDistance)
                                    .ThenBy(c => c.Model)
                                    .Take(5)
                                    .ProjectTo<ExportCarWithPartsDto>(mapper.ConfigurationProvider)
                                    .ToArray();

        return xmlHelper.Serialize(carsWithParts, "cars");
    }

    //Query 18 ???
    public static string GetTotalSalesByCustomer(CarDealerContext context)
    {
        IMapper mapper = InitializeAutoMapper();
        XmlHelper xmlHelper = new XmlHelper();

        ExportCustomerDto[] customers = context.Customers
                                            .Where(c => c.Sales.Count > 0)
                                            .ProjectTo<ExportCustomerDto>(mapper.ConfigurationProvider)
                                            .OrderByDescending(c => c.SpentMoney)
                                            .ToArray();

        return xmlHelper.Serialize(customers, "customers");
    }

}   