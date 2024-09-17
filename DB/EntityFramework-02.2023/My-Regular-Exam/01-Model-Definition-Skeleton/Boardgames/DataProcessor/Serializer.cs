namespace Boardgames.DataProcessor;

using Boardgames.Data;
using Boardgames.DataProcessor.ExportDto;
using Boardgames.Utilities;
using Newtonsoft.Json;
using System.Xml.Linq;

public class Serializer
{
    private static XmlHelper xmlHelper;

    public static string ExportCreatorsWithTheirBoardgames(BoardgamesContext context)
    {
        xmlHelper = new XmlHelper();

        ExportCreatorDto[] creators = context.Creators
                                        .Where(c => c.Boardgames.Count > 0)
                                        .Select(c => new ExportCreatorDto()
                                        {
                                            BoardgamesCount = c.Boardgames.Count,
                                            CreatorName = c.FirstName + " " + c.LastName,
                                            Boardgames = c.Boardgames
                                                          .Select(b => new ExportBoardgameDto()
                                                          {
                                                              Name = b.Name,
                                                              YearPublished = b.YearPublished,
                                                          })
                                                          .OrderBy(b => b.Name)
                                                          .ToArray()
                                        })
                                        .OrderByDescending(c => c.BoardgamesCount)
                                        .ThenBy(c => c.CreatorName)
                                        .ToArray();

        return xmlHelper.Serialize(creators, "Creators");
    }

    public static string ExportSellersWithMostBoardgames(BoardgamesContext context, int year, double rating)
    {
        var sellers = context.Sellers
               .Where(s => s.BoardgamesSellers.Any(bs => bs.Boardgame.YearPublished >= year &&
                                                         bs.Boardgame.Rating <= rating))
               .ToArray()
               .Select(s => new
               {
                   Name = s.Name,
                   Website = s.Website,
                   Boardgames = s.BoardgamesSellers
                                 .Where(bs => bs.Boardgame.YearPublished >= year &&
                                              bs.Boardgame.Rating <= rating)
                                 .Select(bs => new
                                 {
                                     Name = bs.Boardgame.Name,
                                     Rating = bs.Boardgame.Rating,
                                     Mechanics = bs.Boardgame.Mechanics,
                                     Category = bs.Boardgame.CategoryType.ToString()
                                 })
                                 .OrderByDescending(b => b.Rating)
                                 .ThenBy(b => b.Name.ToLower())
                                 .ToArray()
               })
               .OrderByDescending(s => s.Boardgames.Length)
               .ThenBy(s => s.Name.ToLower())
               .Take(5)
               .ToArray();

        return JsonConvert.SerializeObject(sellers, Formatting.Indented);
    }
}