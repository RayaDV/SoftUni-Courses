namespace FastFood.Web.ViewModels.Orders
{
    using System.Collections.Generic;

    public class CreateOrderViewModel
    {
        public CreateOrderViewModel()
        {
            this.Items = new List<int>();
            this.Employees = new List<int>();
        }

        public List<int> Items { get; set; }

        public List<int> Employees { get; set; }
    }
}
