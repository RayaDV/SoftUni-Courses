﻿using Boardgames.Data.Models.Enums;
using System.ComponentModel.DataAnnotations;
using System.Xml.Serialization;

namespace Boardgames.DataProcessor.ImportDto;

[XmlType("Boardgame")]
public class ImportBoardgameDto
{
    [XmlElement("Name")]
    [Required]
    [MinLength(10)]
    [MaxLength(20)]
    public string Name { get; set; } = null!;

    [XmlElement("Rating")]
    [Required]
    [Range(1, 10)]
    public double Rating { get; set; }

    [XmlElement("YearPublished")]
    [Required]
    [Range(2018, 2023)]
    public int YearPublished { get; set; }

    [XmlElement("CategoryType")]
    [Required]
    [Range(0, 4)]
    public int CategoryType { get; set; }

    [XmlElement("Mechanics")]
    [Required]
    public string Mechanics { get; set; } = null!;
}
