namespace FastFood.Models;

using FastFood.Common.EntityConfiguration;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

public class Position
{
    public Position()
    {
        this.Employees = new HashSet<Employee>();
    }

    public int Id { get; set; }

    [Required]
    [MaxLength(EntitiesValidation.PositionNameMaxLength)]
    public string Name { get; set; } = null!;

    public virtual ICollection<Employee> Employees { get; set; }
}