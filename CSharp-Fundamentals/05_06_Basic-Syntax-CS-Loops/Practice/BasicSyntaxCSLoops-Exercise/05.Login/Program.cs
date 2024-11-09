using System;

namespace _05.Login
{
    class Program
    {
        static void Main(string[] args)
        {
            string username = Console.ReadLine();
            string rightPass = "";
            for (int i = username.Length - 1; i >= 0; i--)
            {
                rightPass += username[i];
            }

            string password = Console.ReadLine();
            int counter = 0;
            while (password != rightPass)
            {
                counter++;
                if (counter == 4)
                {
                    Console.WriteLine($"User {username} blocked!");
                    return;
                }
                Console.WriteLine($"Incorrect password. Try again.");
                password = Console.ReadLine();
            }

            Console.WriteLine($"User {username} logged in.");
        }
    }
}
