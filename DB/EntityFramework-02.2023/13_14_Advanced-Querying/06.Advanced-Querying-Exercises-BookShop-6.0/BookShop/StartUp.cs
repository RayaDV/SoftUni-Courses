namespace BookShop
{
    using BookShop.Models;
    using BookShop.Models.Enums;
    using Data;
    using Initializer;
    using Microsoft.EntityFrameworkCore.Metadata;
    using System.Diagnostics;
    using System.Globalization;
    using System.Text;

    public class StartUp
    {
        public static void Main()
        {
            using var dbContest = new BookShopContext();
            //DbInitializer.ResetDatabase(dbContest);

            //int input = int.Parse(Console.ReadLine());
            //Stopwatch sw = Stopwatch.StartNew();
            int result = RemoveBooks(dbContest);
            //sw.Stop();
            //Console.WriteLine(sw.ElapsedMilliseconds);
            Console.WriteLine(result);
        }

        //P02 - Solution 1
        //public static string GetBooksByAgeRestriction(BookShopContext context, string command)
        //{
        //    var bookTitles = context.Books
        //                    .ToArray()
        //                    .Where(b => b.AgeRestriction.ToString().ToLower() == command.ToLower())
        //                    .Select(b => b.Title)
        //                    .OrderBy(b => b);

        //    return string.Join(Environment.NewLine, bookTitles);
        //}


        //P02 - Solution 2
        //public static string GetBooksByAgeRestriction(BookShopContext context, string command)
        //{
        //    bool hasParsed = Enum.TryParse(typeof(AgeRestriction), command, true, out object? ageRestrictionObj);
        //    AgeRestriction ageRestriction;
        //    if (hasParsed)
        //    {
        //        ageRestriction = (AgeRestriction)ageRestrictionObj;

        //        string[] bookTitles = context.Books
        //                        .Where(b => b.AgeRestriction == ageRestriction)
        //                        .OrderBy(b => b.Title)
        //                        .Select(b => b.Title)
        //                        .ToArray();

        //        return string.Join(Environment.NewLine, bookTitles);
        //    }

        //    return null;
        //}

        //P02 - Solution 3
        public static string GetBooksByAgeRestriction(BookShopContext context, string command)
        {
            try
            {
                AgeRestriction ageRestriction = Enum.Parse<AgeRestriction>(command, true);

                string[] bookTitles = context.Books
                                .Where(b => b.AgeRestriction == ageRestriction)
                                .OrderBy(b => b.Title)
                                .Select(b => b.Title)
                                .ToArray();

                return string.Join(Environment.NewLine, bookTitles);
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }

        //P03
        public static string GetGoldenBooks(BookShopContext context)
        {
            string[] goldenBooks = context.Books
                                .Where(b => b.Copies < 5000 && 
                                            b.EditionType == EditionType.Gold)
                                .OrderBy(b => b.BookId)
                                .Select(b => b.Title)
                                .ToArray();

            return string.Join(Environment.NewLine, goldenBooks);
        }

        //P04
        public static string GetBooksByPrice(BookShopContext context)
        {
            StringBuilder sb = new StringBuilder();

            var books = context.Books
                            .Where(b => b.Price > 40)
                            .OrderByDescending(b => b.Price)
                            .Select(b => new
                            {
                                b.Price,
                                b.Title
                            })
                            .ToArray();

            foreach (var book in books)
            {
                sb.AppendLine($"{book.Title} - ${book.Price:f2}");
            }

            return sb.ToString().TrimEnd();

        }

        //P05
        public static string GetBooksNotReleasedIn(BookShopContext context, int year)
        {
            var bookTitles = context.Books
                                .Where(b => b.ReleaseDate.Value.Year != year)
                                .OrderBy(b => b.BookId)
                                .Select(b => b.Title)
                                .ToArray();

            return string.Join (Environment.NewLine, bookTitles);
        }

        //P06
        public static string GetBooksByCategory(BookShopContext context, string input)
        {
            string[] inputCategories = input.Split (' ', StringSplitOptions.RemoveEmptyEntries)
                                            .Select(c => c.ToLower())
                                            .ToArray();

            var bookTitles = context.Books
                                .Where(b => b.BookCategories
                                               .Any(bc => inputCategories.Contains(bc.Category.Name.ToLower())))
                                .OrderBy(b => b.Title)
                                .Select(b => b.Title)
                                .ToArray();

            return string.Join(Environment.NewLine, bookTitles);
        }

        //P07
        public static string GetBooksReleasedBefore(BookShopContext context, string date)
        {
            StringBuilder sb = new StringBuilder();

            DateTime givenDate = DateTime.Parse(date);

            var booksInfo = context.Books
                                .Where(b => b.ReleaseDate < givenDate)
                                .OrderByDescending(b => b.ReleaseDate)
                                .Select(b => new
                                {
                                    b.Title,
                                    b.EditionType,
                                    b.Price
                                })
                                .ToArray();

            foreach (var b in booksInfo) 
            {
                sb.AppendLine($"{b.Title} - {b.EditionType} - ${b.Price}");
            }

            return sb.ToString().TrimEnd();

        }

        //P08
        public static string GetAuthorNamesEndingIn(BookShopContext context, string input)
        {
            string[] authors = context.Authors
                            .Where(a => a.FirstName.EndsWith(input))
                            .Select(a => a.FirstName + ' ' + a.LastName)
                            .OrderBy(a => a)
                            .ToArray();

            return string.Join(Environment.NewLine, authors);
        }

        //P09
        public static string GetBookTitlesContaining(BookShopContext context, string input)
        {
            string[] bookTitles = context.Books
                                    .Where(b => b.Title.ToLower().Contains(input.ToLower()))
                                    .OrderBy(b => b.Title)
                                    .Select(b => b.Title)
                                    .ToArray();

            return string.Join(Environment.NewLine, bookTitles);

        }

        //P10
        public static string GetBooksByAuthor(BookShopContext context, string input)
        {
            StringBuilder sb = new StringBuilder();

            var booksInfo = context.Books
                                    .Where(b => b.Author.LastName.ToLower().StartsWith(input.ToLower()))
                                    .OrderBy(b => b.BookId)
                                    .Select(b => new
                                    {
                                        b.Title,
                                        AuthorName = b.Author.FirstName + " " + b.Author.LastName
                                    })
                                    .ToArray();

            foreach (var b in booksInfo)
            {
                sb.AppendLine($"{b.Title} ({b.AuthorName})");
            }

            return sb.ToString().TrimEnd();

        }

        //P11
        public static int CountBooks(BookShopContext context, int lengthCheck)
        {

            int booksCount = context.Books
                                .Where(b => b.Title.Length > lengthCheck)
                                .Count();

            return booksCount;
        }

        //P12
        public static string CountCopiesByAuthor(BookShopContext context)
        {
            StringBuilder sb = new StringBuilder();

            //Solution 1 (sw = 5200ms) - slower than Sol.2; order in sql
            //var authors = context.Authors
            //                        .OrderByDescending(a => a.Books.Sum(b => b.Copies))
            //                        .Select(a => new
            //                        {
            //                            AuthorName = a.FirstName + " " + a.LastName,
            //                            CopiesCount = a.Books.Sum(b => b.Copies)
            //                        })
            //                        .ToArray();

            //Solution 2 (sw = 1510ms) - order in-memory
            var authors = context.Authors
                        .Select(a => new
                        {
                            AuthorName = a.FirstName + " " + a.LastName,
                            CopiesCount = a.Books.Sum(b => b.Copies)
                        })
                        .ToArray()
                        .OrderByDescending(a => a.CopiesCount); //This is optimization

            foreach (var a in authors)
            {
                sb.AppendLine($"{a.AuthorName} - {a.CopiesCount}");
            }

            return sb.ToString().TrimEnd();
        }

        //P13
        public static string GetTotalProfitByCategory(BookShopContext context)
        {
            StringBuilder sb = new StringBuilder();

            //Sol.1 (sw = 4294ms) when order is in sql (ToArray() is after OrderBy())
            //Solution 2 - faster (sw = 1537ms) when order is in-memory (ToArray() is before OrderBy())
            var categories = context.Categories
                        .Select(c => new
                        {
                            CategoryName = c.Name,
                            TotalProfit = c.CategoryBooks.Sum(cb => cb.Book.Copies * cb.Book.Price)
                        })
                        .ToArray()
                        .OrderByDescending(c => c.TotalProfit)
                        .ThenBy(c => c.CategoryName);

            foreach (var c in categories)
            {
                sb.AppendLine($"{c.CategoryName} ${c.TotalProfit:f2}");
            }

            return sb.ToString().TrimEnd();
        }

        //P14
        public static string GetMostRecentBooks(BookShopContext context)
        {
            StringBuilder sb = new StringBuilder();

            //This solution gives sw = 3000; may optimize the Sql query if we move .Take(3) in foreach()
            var categoriesWithBooks = context.Categories
                            .OrderBy(c => c.Name)
                            .Select(c => new
                            {
                                CategoryName = c.Name,
                                Books = c.CategoryBooks
                                         .OrderByDescending(cb => cb.Book.ReleaseDate)
                                         .Take(3)
                                         .Select(cb => new
                                         {
                                             BookTitle = cb.Book.Title,
                                             BookReleaseYear = cb.Book.ReleaseDate.Value.Year
                                         })
                                         .ToArray()
                            })
                            .ToArray();

            foreach (var c in categoriesWithBooks)
            {
                sb.AppendLine($"--{c.CategoryName}");
                foreach (var b in c.Books)
                {
                    sb.AppendLine($"{b.BookTitle} ({b.BookReleaseYear})");
                }
            }

            return sb.ToString().TrimEnd();
        }

        //P15
        public static void IncreasePrices(BookShopContext context)
        {

            //Materializing the query does not detach entities from Change Tracker
            //Book[] booksBefore2010 = context.Books
            //                        .Where(b => b.ReleaseDate.HasValue 
            //                                 && b.ReleaseDate.Value.Year < 2010)
            //                        .ToArray();

            //foreach (var book in booksBefore2010)
            //{
            //    book.Price += 5;
            //}

            //Solution 1 - without Bulk operations; sw = 3228ms
            //context.SaveChanges();
            //Solution 2 - with Bulk operations and Z.EntityFramework.Plus; sw = 2774ms; ok is for judge
            //context.BulkUpdate(booksBefore2010);

            //Solution 3 - Using BatchUpdate from EFCore.Extensions; sw = 1838ms
            context.Books
                   .Where(b => b.ReleaseDate.HasValue
                            && b.ReleaseDate.Value.Year < 2010)
                   .UpdateFromQuery(b => new Book() { Price = b.Price + 5 });
        }

        //P16
        public static int RemoveBooks(BookShopContext context)
        {
            var booksToRemove = context.Books
                                    .Where(b => b.Copies < 4200);
            int countOfBooks = booksToRemove.Count();

            booksToRemove.DeleteFromQuery();

            return countOfBooks;
        }
    }
}


