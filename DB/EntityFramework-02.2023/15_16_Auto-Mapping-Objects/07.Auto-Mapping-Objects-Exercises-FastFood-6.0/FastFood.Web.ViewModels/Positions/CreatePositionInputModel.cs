using FastFood.Common.EntityConfiguration;
using System.ComponentModel.DataAnnotations;

namespace FastFood.Web.ViewModels.Positions
{
    public class CreatePositionInputModel
    {
        [MinLength(ViewModelsValidation.PositionNameMinLength)]
        [MaxLength(ViewModelsValidation.PositionNameMaxLength)]
        [StringLength(ViewModelsValidation.PositionNameMaxLength, 
                      ErrorMessage = $"Position name should be between 3 and 30 characters long")]
        public string PositionName { get; set; } = null!;
    }
}