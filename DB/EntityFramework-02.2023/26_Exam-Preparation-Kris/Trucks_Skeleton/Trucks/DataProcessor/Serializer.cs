namespace Trucks.DataProcessor
{
    using Boardgames.Utilities;
    using Data;
    using Newtonsoft.Json;
    using System.Security.Cryptography.X509Certificates;
    using Trucks.Data.Models.Enums;
    using Trucks.DataProcessor.ExportDto;

    public class Serializer
    {
        private static XmlHelper xmlHelper;

        public static string ExportDespatchersWithTheirTrucks(TrucksContext context)
        {
            xmlHelper = new XmlHelper();

            ExportDespatcherDto[] despetchers = context.Despatchers
                                                       .Where(d => d.Trucks.Any())
                                                       .Select(d => new ExportDespatcherDto()
                                                       {
                                                           TrucksCount = d.Trucks.Count,
                                                           DespatcherName = d.Name,
                                                           Trucks = d.Trucks
                                                                     .Select(t => new ExportTruckDto()
                                                                     {
                                                                         RegistrationNumber = t.RegistrationNumber,
                                                                         Make = t.MakeType.ToString()
                                                                     })
                                                                     .OrderBy(t => t.RegistrationNumber)
                                                                     .ToArray()
                                                       })
                                                       .OrderByDescending(d => d.TrucksCount)
                                                       .ThenBy(d => d.DespatcherName)
                                                       .ToArray();

            return xmlHelper.Serialize(despetchers, "Despatchers");
        }

        public static string ExportClientsWithMostTrucks(TrucksContext context, int capacity)
        {
            var clients = context.Clients
                                .Where(c => c.ClientsTrucks.Any(ct => ct.Truck.TankCapacity >= capacity))
                                .ToArray()
                                .Select(c => new
                                {
                                    Name = c.Name,
                                    Trucks = c.ClientsTrucks
                                              .Where(ct => ct.Truck.TankCapacity >= capacity)
                                              .ToArray()
                                              .Select(ct => new
                                              {
                                                  TruckRegistrationNumber = ct.Truck.RegistrationNumber,
                                                  VinNumber = ct.Truck.VinNumber,
                                                  TankCapacity = ct.Truck.TankCapacity,
                                                  CargoCapacity = ct.Truck.CargoCapacity,
                                                  CategoryType = ct.Truck.CategoryType.ToString(),
                                                  MakeType = ct.Truck.MakeType.ToString()
                                              })
                                              .OrderBy(t => t.MakeType)
                                              .ThenByDescending(t => t.CargoCapacity)
                                              .ToArray()
                                })
                                .OrderByDescending(c => c.Trucks.Count())
                                .ThenBy(c => c.Name)
                                .Take(10)
                                .ToArray();

            return JsonConvert.SerializeObject(clients, Formatting.Indented);
        }
    }
}
