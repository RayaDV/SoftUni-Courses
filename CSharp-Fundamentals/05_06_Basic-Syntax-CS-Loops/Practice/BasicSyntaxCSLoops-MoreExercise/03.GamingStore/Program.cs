using System;

namespace _03.GamingStore
{
    class Program
    {
        static void Main(string[] args)
        {
            double balance = double.Parse(Console.ReadLine());
            string game = Console.ReadLine();
            double totalSpent = 0;
            while (game != "Game Time")
            {
                double gamePrice = 0;
                switch (game)
                {
                    case "OutFall 4":
                        gamePrice = 39.99;
                        break;
                    case "CS: OG":
                        gamePrice = 15.99;
                        break;
                    case "Zplinter Zell":
                        gamePrice = 19.99;
                        break;
                    case "Honored 2":
                        gamePrice = 59.99;
                        break;
                    case "RoverWatch":
                        gamePrice = 29.99;
                        break;
                    case "RoverWatch Origins Edition":
                        gamePrice = 39.99;
                        break;
                    default:
                        Console.WriteLine("Not Found");
                        break;
                }
                if (balance == gamePrice)
                {
                    balance -= gamePrice;
                    totalSpent += gamePrice;
                    Console.WriteLine("Out of money! ");
                    return;
                }
                else if (balance < gamePrice)
                {
                    Console.WriteLine("Too Expensive");
                }
                else if (balance > gamePrice)
                {
                    balance -= gamePrice;
                    totalSpent += gamePrice;
                    Console.WriteLine($"Bought {game}");
                }

                game = Console.ReadLine();
            }
            Console.WriteLine($"Total spent: ${totalSpent:f2}. Remaining: ${balance:f2}");
        }
    }
}
