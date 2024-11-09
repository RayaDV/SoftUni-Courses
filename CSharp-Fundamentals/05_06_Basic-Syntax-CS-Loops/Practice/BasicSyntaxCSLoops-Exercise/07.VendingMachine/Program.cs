using System;

namespace _07.VendingMachine
{
    class Program
    {
        static void Main(string[] args)
        {
            string input = Console.ReadLine();
            double budget = 0.0;

            while (input != "Start")
            {
                double coin = double.Parse(input);
                if (coin == 0.1 || coin == 0.2 || coin == 0.5 || coin == 1 || coin == 2)
                {
                    budget += coin;
                }
                else
                {
                    Console.WriteLine($"Cannot accept {coin}");
                }
                input = Console.ReadLine();
            }

            input = Console.ReadLine();
            double price = 0.0;
            while (input != "End")
            {
                bool productIsValid = true;
                switch (input)
                {
                    case "Nuts":
                        price = 2.0; 
                        break;
                    case "Water":
                        price = 0.7;
                        break;
                    case "Crisps":
                        price = 1.5;
                        break;
                    case "Soda":
                        price = 0.8;
                        break;
                    case "Coke":
                        price = 1.0;
                        break;
                    default:
                        Console.WriteLine($"Invalid product");
                        productIsValid = false;
                        break;
                }
                if (budget >= price && productIsValid)
                {
                    Console.WriteLine($"Purchased {input.ToLower()}");
                    budget -= price;
                }
                else if (budget < price && productIsValid)
                {
                    Console.WriteLine($"Sorry, not enough money");
                }

                input = Console.ReadLine();
            }

            Console.WriteLine($"Change: {budget:f2}");
        }
    }
}
