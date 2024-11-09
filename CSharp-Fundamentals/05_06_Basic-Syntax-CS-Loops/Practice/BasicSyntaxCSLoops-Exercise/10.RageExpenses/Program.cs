using System;

namespace _10.RageExpenses
{
    class Program
    {
        static void Main(string[] args)
        {
            int lostGames = int.Parse(Console.ReadLine());
            double headsetPrice = double.Parse(Console.ReadLine());
            double mousePrice = double.Parse(Console.ReadLine());
            double keyboardPrice = double.Parse(Console.ReadLine());
            double displayPrice = double.Parse(Console.ReadLine());

            double trashedHeadset = Math.Floor(0.5 * lostGames);
            double trashedMouse = Math.Floor(1.0 / 3 * lostGames);
            double trashedKeyboard = Math.Floor(1.0 / 6 * lostGames);
            double trashedDisplay = Math.Floor(1.0 / 12 * lostGames);

            double rageExpenses = headsetPrice * trashedHeadset + mousePrice * trashedMouse + keyboardPrice * trashedKeyboard + displayPrice * trashedDisplay;
            Console.WriteLine($"Rage expenses: {rageExpenses:f2} lv.");
        }
    }
}
