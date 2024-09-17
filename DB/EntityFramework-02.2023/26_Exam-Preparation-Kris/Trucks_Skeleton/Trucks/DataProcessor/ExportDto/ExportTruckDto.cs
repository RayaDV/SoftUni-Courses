using System.ComponentModel.DataAnnotations;
using System.Xml.Serialization;
using Trucks.Common;

namespace Trucks.DataProcessor.ExportDto;

[XmlType("Truck")]
public class ExportTruckDto
{
    [XmlElement("RegistrationNumber")]
    [MaxLength(ValidationConstants.TruckRegistrationNumberLength)]
    public string? RegistrationNumber { get; set; }

    [XmlElement("Make")]
    public string? Make { get; set; }
}

