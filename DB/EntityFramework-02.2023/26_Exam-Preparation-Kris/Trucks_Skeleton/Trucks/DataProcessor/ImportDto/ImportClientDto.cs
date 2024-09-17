using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;
using Trucks.Common;

namespace Trucks.DataProcessor.ImportDto;

public class ImportClientDto
{
    [JsonProperty("Name")]
    [Required]
    [MinLength(ValidationConstants.ClientNameMinLength)]
    [MaxLength(ValidationConstants.ClientNameMaxLength)]
    public string Name { get; set; } = null!;

    [JsonProperty("Nationality")]
    [Required]
    [MinLength(ValidationConstants.ClientNationalityMinLength)]
    [MaxLength(ValidationConstants.ClientNationalityMaxLength)]
    public string? Nationality { get; set; }

    [JsonProperty("Type")]
    [Required]
    public string? Type { get; set; }

    [JsonProperty("Trucks")]
    public int[] TruckIds { get; set; }
}
