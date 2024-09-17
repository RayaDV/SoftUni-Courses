using Microsoft.Data.SqlClient;

SqlConnection dbCon = new SqlConnection(
      "Server=.; " +
  "Database=MinionsDB; " +
  "Integrated Security=true; " +
  "Trust Server Certificate=true ");
dbCon.Open();

using(dbCon)
{
    int @Id = int.Parse(Console.ReadLine());

    SqlCommand command1 = new SqlCommand("SELECT Name FROM Villains WHERE Id = @Id", dbCon);
    SqlCommand command2= new SqlCommand("SELECT ROW_NUMBER() OVER (ORDER BY m.Name) AS RowNum,\r\n                                         m.Name, \r\n                                         m.Age\r\n                                    FROM MinionsVillains AS mv\r\n                                    JOIN Minions As m ON mv.MinionId = m.Id\r\n                                   WHERE mv.VillainId = @Id\r\n                                ORDER BY m.Name", dbCon);

    SqlDataReader reader1 = await command1.ExecuteReaderAsync();
    SqlDataReader reader2 = await command2.ExecuteReaderAsync();

}
