namespace FastFood.Models;

using FastFood.Common.EntityConfiguration;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class OrderItem
{
    [MaxLength(EntitiesValidation.GuidMaxLength)]
    [ForeignKey(nameof(Order))]
    public string OrderId { get; set; } = null!;

    [Required] //Without Required after DotNet6.0
    public virtual Order Order { get; set; } = null!;

    [MaxLength(EntitiesValidation.GuidMaxLength)]
    [ForeignKey(nameof(Item))]
    public string ItemId { get; set; } = null!;

    [Required]
    public virtual Item Item { get; set; } = null!;

    [Range(1, int.MaxValue)]
    public int Quantity { get; set; }
}