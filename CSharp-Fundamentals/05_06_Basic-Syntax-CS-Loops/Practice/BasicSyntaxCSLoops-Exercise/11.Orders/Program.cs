using System;

namespace _11.Orders
{
    class Program
    {
        static void Main(string[] args)
        {
            int n = int.Parse(Console.ReadLine());
            decimal totalPrice = 0;
            for (int i = 1; i <= n; i++)
            {
                decimal pricePerCapsule = decimal.Parse(Console.ReadLine());
                int daysInMonth = int.Parse(Console.ReadLine());
                int capsulesCount = int.Parse(Console.ReadLine());

                decimal price = (pricePerCapsule * (daysInMonth * capsulesCount));
                totalPrice += price;
                Console.WriteLine($"The price for the coffee is: ${price:F2}");
            }
            Console.WriteLine($"Total: ${totalPrice:F2}");
        }
    }
}
