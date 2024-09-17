using System.Xml.Serialization;

namespace CarDealer.DTOs.Import;

[XmlType("Customer")]
public class ImportCustomerDto
{
    [XmlElement("name")]
    public string Name { get; set; } = null!;

    //Always read DateTime, Enums and other hard to parse data types as strings!!! Recommendation!
    //Parse it yourself in your business logic (manually or with AutoMapper)
    //JsonConvert and XmlSerializer are not capable of parsing!!!
    [XmlElement("birthDate")]
    public string BirthDate { get; set; } = null!;

    [XmlElement("isYoungDriver")]
    public bool IsYoungDriver { get; set; }
}
