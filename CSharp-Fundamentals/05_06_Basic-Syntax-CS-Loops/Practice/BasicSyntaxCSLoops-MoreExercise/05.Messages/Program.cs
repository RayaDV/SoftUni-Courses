using System;

namespace _05.Messages
{
    class Program
    {
        static void Main(string[] args)
        {
            int n = int.Parse(Console.ReadLine());
            string message = string.Empty;
            for (int i = 1; i <= n; i++)
            {
                string num = Console.ReadLine();
                int numberOfDigits = num.Length;
                int mainDigit = int.Parse(num[0].ToString());
                int offset = (mainDigit - 2) * 3;
                if (mainDigit == 8 || mainDigit == 9)
                {
                    offset++;
                }
                int letterIndex = offset + numberOfDigits - 1;
                char letter = (char)(letterIndex + 97);
                if (mainDigit == 0)
                {
                    letter = ' ';
                }

                message += letter;
            }
            Console.WriteLine(message);
        }
    }
}
