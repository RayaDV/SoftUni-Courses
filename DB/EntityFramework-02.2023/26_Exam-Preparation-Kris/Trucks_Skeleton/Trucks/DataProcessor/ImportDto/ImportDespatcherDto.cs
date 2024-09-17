﻿using System.ComponentModel.DataAnnotations;
using System.Xml.Serialization;
using Trucks.Common;

namespace Trucks.DataProcessor.ImportDto;

[XmlType("Despatcher")]
public class ImportDespatcherDto
{
    [XmlElement("Name")]
    [Required]
    [MinLength(ValidationConstants.DespatcherNameMinLength)]
    [MaxLength(ValidationConstants.DespatcherNameMaxLength)]
    public string Name { get; set; } = null!;

    [XmlElement("Position")]
    [Required]
    public string? Position { get; set; }

    [XmlArray("Trucks")]
    public ImportTruckDto[] Trucks { get; set; }    
}
