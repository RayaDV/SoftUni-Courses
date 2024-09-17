using Newtonsoft.Json;
using ProductShop.Models;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProductShop.DTOs.Export;

public class ExportUserWithSoldProductsDto
{
    public string? FirstName { get; set; }

    public string LastName { get; set; } = null!;

    [JsonProperty("SoldProducts")]
    public ICollection<ExportSoldProductDto> SoldProductDtos { get; set; }
}
