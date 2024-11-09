using System;

namespace _06.StrongNumber
{
    class Program
    {
        static void Main(string[] args)
        {
            string num = Console.ReadLine();
            int number = int.Parse(num);
            int sum = 0;
            for (int i = 0; i < num.Length; i++)
            {
                int currDigit = int.Parse(num[i].ToString());
                int currSum = 1;
                for (int j = 1; j <= currDigit; j++)
                {
                    currSum *= j;
                }
                sum += currSum;
            }
            if (number == sum)
            {
                Console.WriteLine("yes");
            }
            else
            {
                Console.WriteLine("no");
            }
        }
    }
}
