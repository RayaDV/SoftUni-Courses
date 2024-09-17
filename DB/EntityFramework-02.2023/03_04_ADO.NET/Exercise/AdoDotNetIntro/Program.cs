using Microsoft.Data.SqlClient;

SqlConnection dbCon = new SqlConnection(
 @"Server=DESKTOP-HPM2TJI\SQLEXPRESS01;
   Database=SoftUni;
   Integrated Security=true;
   Encrypt=Optional");

dbCon.Open();

using (dbCon)
{
    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Employees", dbCon);
    int employeesCount = (int)await cmd.ExecuteScalarAsync();
    Console.WriteLine($"Employees Count: {employeesCount}");

    SqlCommand command = new SqlCommand("SELECT * FROM Employees WHERE DepartmentID = 7", dbCon);
    SqlDataReader reader = await command.ExecuteReaderAsync();

    using (reader)
    {
        while (reader.Read())
        {
            string? firstName = reader["FirstName"]?.ToString();
            string? lastName = reader[2]?.ToString();

            Console.WriteLine($"{firstName} {lastName}");
        }
    }
}

