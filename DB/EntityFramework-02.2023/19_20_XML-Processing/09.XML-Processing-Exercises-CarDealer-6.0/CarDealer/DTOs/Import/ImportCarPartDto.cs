using System.Xml.Serialization;

namespace CarDealer.DTOs.Import;

[XmlType("partId")]
public class ImportCarPartDto
{
    //XmlAttriute cannot be over nullable type (int?)!!!
    [XmlAttribute("id")]
    public int PartId { get; set; }
}
