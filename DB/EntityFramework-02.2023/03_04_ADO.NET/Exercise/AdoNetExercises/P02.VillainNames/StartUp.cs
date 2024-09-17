using Microsoft.Data.SqlClient;
using System.Net.Http.Headers;
using System.Text;

namespace P02.VillainNames
{
    public class StartUp
    {
        static async Task Main()
        {
            //In .Net 6 ToString() is working properly
            //If using 'using' operator, no need to coll CloseAsync, else -> Close()/Dispose()

            await using SqlConnection sqlConnection = new SqlConnection(Config.ConnectionString);
            await sqlConnection.OpenAsync();

            //P02
            //string result = await GetVillainsWithTheirMinionsAsync(sqlConnection);
            //Console.WriteLine(result);

            //P03
            //int villainId = int.Parse(Console.ReadLine());
            //string result = await GetVillainWithAllMinionsByIdAsync(sqlConnection, villainId);
            //Console.WriteLine(result);

            //P04
            string[] minionArgs = Console.ReadLine().Split(": ", StringSplitOptions.RemoveEmptyEntries).ToArray();
            string[] villainArgs = Console.ReadLine().Split(": ", StringSplitOptions.RemoveEmptyEntries).ToArray();

            string result = await AddMinionAsync(sqlConnection, minionArgs[1], villainArgs[1]);
            Console.WriteLine(result);
        }

        //P02
        static async Task<string> GetVillainsWithTheirMinionsAsync(SqlConnection sqlConnection)
        {
            StringBuilder sb = new StringBuilder();

            SqlCommand sqlCommand = new SqlCommand(SqlQueries.GetVillainsAndTheirMinions, sqlConnection);
            //One row with many columns
            //First the reader hasn't loaded any data. We must call Read() first!
            SqlDataReader reader = await sqlCommand.ExecuteReaderAsync();
            while(reader.Read())
            {
                string villainName = (string)reader["Name"];
                int minionsCount = (int)reader["MinionsCount"];

                sb.AppendLine($"{villainName} - {minionsCount}");
            }

            //No more data
            return sb.ToString().TrimEnd();
        }

        //P03
        static async Task<string> GetVillainWithAllMinionsByIdAsync(SqlConnection sqlConnection, int villainId)
        {
            //SQL Injection Prevention -> Using SqlParameters
            //One row with one column -> ExecuteScalar
            SqlCommand getVillainNameCmd = new SqlCommand(SqlQueries.GetVillainNameById, sqlConnection);
            getVillainNameCmd.Parameters.AddWithValue("@Id", villainId);

            object? villainNameObj = await getVillainNameCmd.ExecuteScalarAsync();
            if (villainNameObj == null)
            {
                return $"No villain with ID {villainId} exists in the database.";
            }

            string villainName = (string)villainNameObj;

            //SQL Injection Prevention -> Using SqlParameters
            //Many rows with many columns -> ExecuteReader()
            SqlCommand getAllMinionsCmd = new SqlCommand(SqlQueries.GetAllMinionsByVillainId, sqlConnection);
            getAllMinionsCmd.Parameters.AddWithValue("@Id", villainId);

            SqlDataReader minionsReader = await getAllMinionsCmd.ExecuteReaderAsync();

            return GenerateVillainWithMinionsOutput(villainName, minionsReader);
        }

        private static string GenerateVillainWithMinionsOutput(string villainName, SqlDataReader minionsReader)
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine($"Villain: {villainName}");
            if (!minionsReader.HasRows)
            {
                sb.AppendLine("(no minions)");
            }
            else
            {
                while (minionsReader.Read())
                {
                    long rowNum = (long)minionsReader["RowNum"];
                    string minionName = (string)minionsReader["Name"];
                    int minionAge = (int)minionsReader["Age"];

                    sb.AppendLine($"{rowNum}. {minionName} {minionAge}");
                }
            }

            return sb.ToString().TrimEnd();
        }

        //P04
        static async Task<string> AddMinionAsync(SqlConnection sqlConnection, string minionInfo, string villainName)
        {
            StringBuilder sb = new StringBuilder();

            string[] minionArgs = minionInfo.Split(' ', StringSplitOptions.RemoveEmptyEntries).ToArray();
            string minionName = minionArgs[0];
            int minionAge = int.Parse(minionArgs[1]);
            string townName = minionArgs[2];

            //Check if given Town exist and if it is not -> adding it
            SqlTransaction sqlTransaction = sqlConnection.BeginTransaction();
            try
            {
                int townId = await GetTownIdOrAddByNameAsync(sqlConnection, sqlTransaction, sb, townName);

                int villainId = await GetVillainIdOrAddByNameAsync(sqlConnection, sqlTransaction, sb, villainName);

                int minionId = await AddNewMinionAndReturnIdAsync(sqlConnection, sqlTransaction, sb, minionName, minionAge, townId);

                await SetMinionToBeServentOfVilllainAsync(sqlConnection, sqlTransaction, minionId, villainId);
                sb.AppendLine($"Successfully added {minionName} to be minion of {villainName}.");

                await sqlTransaction.CommitAsync();
            }
            catch (Exception e)
            {
                await sqlTransaction.RollbackAsync();
            }

            return sb.ToString().TrimEnd();
        }

        private static async Task<int> GetTownIdOrAddByNameAsync(SqlConnection sqlConnection, SqlTransaction sqlTransaction,  StringBuilder sb, string townName)
        {
            SqlCommand getTownIdCmd = new SqlCommand(SqlQueries.GetTownIdByName, sqlConnection, sqlTransaction);
            getTownIdCmd.Parameters.AddWithValue("@townName", townName);

            object? townIdObj = await getTownIdCmd.ExecuteScalarAsync();
            if (townIdObj == null)
            {
                SqlCommand addNewTownCmd = new SqlCommand(SqlQueries.AddNewTown, sqlConnection, sqlTransaction);
                addNewTownCmd.Parameters.AddWithValue("@townName", townName);

                //Add the town command
                await addNewTownCmd.ExecuteNonQueryAsync();

                //Take the Id of the newly added town
                townIdObj = await getTownIdCmd.ExecuteScalarAsync();

                sb.AppendLine($"Town {townName} was added to the database.");
            }

            return (int)townIdObj;
        }

        private static async Task<int> GetVillainIdOrAddByNameAsync(SqlConnection sqlConnection, SqlTransaction sqlTransaction, StringBuilder sb, string villainName)
        {
            SqlCommand getVillainIdCmd = new SqlCommand(SqlQueries.GetVillainIdByName, sqlConnection, sqlTransaction);
            getVillainIdCmd.Parameters.AddWithValue("@Name", villainName);

            int? villainId = (int?)await getVillainIdCmd.ExecuteScalarAsync(); //(int?) = nullable value
            if (!villainId.HasValue)
            {
                SqlCommand addNewVillainCmd = new SqlCommand(SqlQueries.AddNewVillain, sqlConnection, sqlTransaction);
                addNewVillainCmd.Parameters.AddWithValue("@villainName", villainName);

                //Add the new villain to the db
                await addNewVillainCmd.ExecuteNonQueryAsync();

                //Take the Id of the newly created villain
                villainId = (int?)await getVillainIdCmd.ExecuteScalarAsync();

                sb.AppendLine($"Villain {villainName} was added to the database.");
            }

            return villainId.Value;
        }

        private static async Task<int> AddNewMinionAndReturnIdAsync(SqlConnection sqlConnection, SqlTransaction sqlTransaction, StringBuilder sb, string minionName, int minionAge, int townId)
        {
            SqlCommand addNewMinionCmd = new SqlCommand(SqlQueries.AddNewMinion, sqlConnection, sqlTransaction);
            addNewMinionCmd.Parameters.AddWithValue("@name", minionName);
            addNewMinionCmd.Parameters.AddWithValue("@age", minionAge);
            addNewMinionCmd.Parameters.AddWithValue("@townId", townId);

            //We are adding new minion
            await addNewMinionCmd.ExecuteNonQueryAsync();

            //We need to find the Id of the newly created minion
            SqlCommand getMinionIdCmd = new SqlCommand(SqlQueries.GetMinionIdByName, sqlConnection, sqlTransaction);
            getMinionIdCmd.Parameters.AddWithValue("@Name", minionName);

            int minionId = (int)await getMinionIdCmd.ExecuteScalarAsync();

            return minionId;

        }

        private static async Task SetMinionToBeServentOfVilllainAsync(SqlConnection sqlConnection, SqlTransaction sqlTransaction, int minionId, int villainId)
        {
            SqlCommand addMinionVillainCmd = new SqlCommand(SqlQueries.SetMinionToBeServentOfVillain, sqlConnection, sqlTransaction);
            addMinionVillainCmd.Parameters.AddWithValue("@minionId", minionId);
            addMinionVillainCmd.Parameters.AddWithValue("@villainId", villainId);

            await addMinionVillainCmd.ExecuteNonQueryAsync();
        }
    }
}