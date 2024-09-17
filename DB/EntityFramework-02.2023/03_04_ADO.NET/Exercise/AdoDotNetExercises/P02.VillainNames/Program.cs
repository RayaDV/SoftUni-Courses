using Microsoft.Data.SqlClient;

SqlConnection dbCon = new SqlConnection(
  "Server=.; " +
  "Database=MinionsDB; " +
  "Integrated Security=true; " + 
  "Trust Server Certificate=true ");
dbCon.Open();

using(dbCon)
{
    SqlCommand command = new SqlCommand("  SELECT v.Name, COUNT(mv.VillainId) AS MinionsCount  \r\n    FROM Villains AS v \r\n    JOIN MinionsVillains AS mv ON v.Id = mv.VillainId \r\nGROUP BY v.Id, v.Name \r\n  HAVING COUNT(mv.VillainId) > 3 \r\nORDER BY COUNT(mv.VillainId)", dbCon);

    SqlDataReader reader = await command.ExecuteReaderAsync();
    using(reader)
    {
        while(reader.Read())
        {
            string name = (string) reader["Name"];
            int minionsCount =  (int) reader["MinionsCount"];
            Console.WriteLine($"{name} – {minionsCount}");
        }
    }
}
