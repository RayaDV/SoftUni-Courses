using AutoMapper;
using CarDealer.DTOs.Export;
using CarDealer.DTOs.Import;
using CarDealer.Models;
using System.Globalization;

namespace CarDealer
{
    public class CarDealerProfile : Profile
    {
        public CarDealerProfile()
        {
            //Supplier
            this.CreateMap<ImportSupplierDto, Supplier>();
            this.CreateMap<Supplier, ExportLocalSupplierDto>()
                .ForMember(d => d.PartsCount, opt => opt.MapFrom(s => s.Parts.Count));

            //Part
            this.CreateMap<ImportPartDto, Part>()
                .ForMember(d => d.SupplierId, opt => opt.MapFrom(s => s.SupplierId!.Value));
            this.CreateMap<Part, ExportCarPartDto>();

            //Car
            //this.CreateMap<ImportCarPartDto, PartCar>();
            //this.CreateMap<ImportCarDto, Car>()
            //    .ForMember(d => d.PartsCars, opt => opt.MapFrom(s => s.Parts.Select(p => new PartCar() { PartId = p.PartId })));
            this.CreateMap<ImportCarDto, Car>()
                .ForSourceMember(s => s.Parts, opt => opt.DoNotValidate());
            this.CreateMap<Car, ExportCarDto>();
            this.CreateMap<Car, ExportCarBmwDto>();
            this.CreateMap<Car, ExportCarWithPartsDto>()
                .ForMember(d => d.Parts, opt => opt.MapFrom(s => s.PartsCars
                                                                  .Select(pc => pc.Part)
                                                                  .OrderByDescending(p => p.Price)
                                                                  .ToArray()));

            //Customer
            this.CreateMap<ImportCustomerDto, Customer>()
                .ForMember(d => d.BirthDate, opt => opt.MapFrom(s => DateTime.Parse(s.BirthDate, CultureInfo.InvariantCulture)));
            this.CreateMap<Customer, ExportCustomerDto>()
                .ForMember(d => d.BoughtCars, opt => opt.MapFrom(s => s.Sales.Count()))
                .ForMember(d => d.SpentMoney, opt => opt.MapFrom(s => s.Sales
                                                                       .Select(s => s.Car.PartsCars
                                                                                     .Sum(pc => pc.Part.Price))));


            //Sale
            this.CreateMap<ImportSaleDto, Sale>()
                .ForMember(d => d.CarId, opt => opt.MapFrom(s => s.CarId.Value));
        }
    }
}
