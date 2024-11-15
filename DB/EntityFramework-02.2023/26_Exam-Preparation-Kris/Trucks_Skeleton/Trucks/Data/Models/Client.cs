﻿using System.ComponentModel.DataAnnotations;
using Trucks.Common;

namespace Trucks.Data.Models;

public class Client
{
    public Client()
    {
        this.ClientsTrucks = new HashSet<ClientTruck>();
    }

    [Key]
    public int Id { get; set; }

    [Required]
    [MaxLength(ValidationConstants.ClientNameMaxLength)]
    public string Name { get; set; } = null!;

    [Required]
    [MaxLength(ValidationConstants.ClientNameMaxLength)]
    public string Nationality { get; set; } = null!;

    [Required]
    public string? Type { get; set; }

    public virtual ICollection<ClientTruck> ClientsTrucks { get; set; }
}
