﻿using Newtonsoft.Json;
using ProductShop.Models;

namespace ProductShop.DTOs.Export;

public class ExportProductInRangeDto
{
    [JsonProperty("name")]
    public string ProductName { get; set; } = null!;

    [JsonProperty("price")]
    public decimal ProductPrice { get; set; }

    [JsonProperty("seller")]
    public string SellerName { get; set; } = null!;
}
