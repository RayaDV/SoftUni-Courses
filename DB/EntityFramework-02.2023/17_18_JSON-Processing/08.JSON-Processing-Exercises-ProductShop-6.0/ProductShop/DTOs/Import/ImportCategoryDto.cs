using Newtonsoft.Json;
using System.Xml.Linq;

namespace ProductShop.DTOs.Import;

public class ImportCategoryDto
{
    [JsonProperty("name")]
    public string? Name { get; set; }
}
