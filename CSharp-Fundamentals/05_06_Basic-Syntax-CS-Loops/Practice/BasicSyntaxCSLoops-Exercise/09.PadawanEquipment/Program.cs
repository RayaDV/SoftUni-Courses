using System;

namespace _09.PadawanEquipment
{
    class Program
    {
        static void Main(string[] args)
        {
            double budget = double.Parse(Console.ReadLine());
            int students = int.Parse(Console.ReadLine());
            double lightsaberPrice = double.Parse(Console.ReadLine());
            double robePrice = double.Parse(Console.ReadLine());
            double beltPrice = double.Parse(Console.ReadLine());

            double lightsabersCount = Math.Ceiling(students * 1.1);
            double freeBelts = students / 6;
            double totalPrice = lightsaberPrice * lightsabersCount + robePrice * students + beltPrice * (students - freeBelts);

            if (totalPrice <= budget)
            {
                Console.WriteLine($"The money is enough - it would cost {totalPrice:f2}lv.");
            }
            else
            {
                Console.WriteLine($"John will need {totalPrice - budget:f2}lv more.");
            }
        }
    }
}
