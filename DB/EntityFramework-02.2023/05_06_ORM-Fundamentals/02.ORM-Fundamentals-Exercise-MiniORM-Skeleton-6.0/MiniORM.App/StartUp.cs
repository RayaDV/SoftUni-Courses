using MiniORM.App.Data;

namespace MiniORM.App
{
    public class StartUp
    {
        static void Main(string[] args)
        {
            OurDbContext dbContext = new OurDbContext(Config.ConnectionString);

            Console.WriteLine("Connection success!");
        }
    }
}