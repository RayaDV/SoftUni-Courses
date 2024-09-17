using Microsoft.EntityFrameworkCore;
using SoftUni.Data;
using SoftUni.Models;
using System.Globalization;
using System.Net;
using System.Runtime.CompilerServices;
using System.Text;

namespace SoftUni;

public class StartUp
{
    static void Main(string[] args)
    {
        SoftUniContext dbContext = new SoftUniContext();

        string result = RemoveTown(dbContext);

        Console.WriteLine(result);
    }

    //P03
    public static string GetEmployeesFullInformation(SoftUniContext context)
    {
        StringBuilder sb = new StringBuilder();

        var employees = context.Employees
                                      .OrderBy(e => e.EmployeeId)
                                      .Select(e => new
                                      {
                                          e.FirstName,
                                          e.LastName,
                                          e.MiddleName,
                                          e.JobTitle,
                                          e.Salary
                                      })
                                      .ToArray(); //ToList() or ToArray()-> Materialize collection - Detach from the change tracker like AsNoTracking(), any changes on the data inside will not be saved into db.
        foreach (var e in employees)
        {
            sb.AppendLine($"{e.FirstName} {e.LastName} {e.MiddleName} {e.JobTitle} {e.Salary:f2}");
        }

        return sb.ToString().TrimEnd();
    }

    //P04
    public static string GetEmployeesWithSalaryOver50000(SoftUniContext context) 
    {
        StringBuilder sb = new StringBuilder();

        var employees = context.Employees
                               .OrderBy(e => e.FirstName)
                               .Where(e => e.Salary > 50000)
                               .Select(e => new
                               {
                                   e.FirstName,
                                   e.Salary
                               })
                               .ToArray();
        foreach( var e in employees)
        {
            sb.AppendLine($"{e.FirstName} - {e.Salary:f2}");
        }

        return sb.ToString().TrimEnd();
    }

    //P05
    public static string GetEmployeesFromResearchAndDevelopment(SoftUniContext context)
    {
        StringBuilder sb = new StringBuilder();

        var employees = context.Employees
                               .Where(e => e.Department.Name == "Research and Development")
                               .Select(e => new
                               {
                                   e.FirstName,
                                   e.LastName,
                                   e.Salary,
                                   DepartmentName = e.Department.Name
                               })
                               .OrderBy(e => e.Salary)
                               .ThenByDescending(e => e.FirstName)
                               .ToArray();
        foreach ( var e in employees)
        {
            sb.AppendLine($"{e.FirstName} {e.LastName} from {e.DepartmentName} - ${e.Salary:f2}");
        }

        return sb.ToString().TrimEnd();
    }

    //P06
    public static string AddNewAddressToEmployee(SoftUniContext context)
    {
        Address newAddress = new Address()
        {
            AddressText = "Vitoshka 15",
            TownId = 4
        };
        //context.Addresses.Add(newAddress); //This is the way for adding the new address but now it will be added by EF

        Employee? employee = context.Employees
                                   .FirstOrDefault(e => e.LastName == "Nakov");
        employee!.Address = newAddress;

        context.SaveChanges();

        var employeesAddresses = context.Employees
                                        .OrderByDescending(e => e.AddressId)
                                        .Take(10)
                                        .Select(e => e.Address!.AddressText)
                                        .ToArray();

        return String.Join(Environment.NewLine, employeesAddresses);
    }

    //P07
    public static string GetEmployeesInPeriod(SoftUniContext context)
    {
        StringBuilder sb = new StringBuilder();

        var employeesWithProjects = context.Employees
                                           //.Where(e => e.EmployeesProjects.Any(ep => ep.Project.StartDate.Year >= 2001 &&
                                           //                                          ep.Project.StartDate.Year <= 2003))
                                           .Take(10)
                                           .Select(e => new
                                           {
                                               e.FirstName,
                                               e.LastName,
                                               ManagerFirstName = e.Manager!.FirstName,
                                               ManagerLastName = e.Manager!.LastName,
                                               Projects = e.EmployeesProjects
                                                           .Where(ep => ep.Project.StartDate.Year >= 2001 &&
                                                                        ep.Project.StartDate.Year <= 2003)
                                                           .Select(ep => new
                                                           {
                                                               ProjectName = ep.Project.Name,
                                                               StartDate = ep.Project.StartDate.ToString
                                                                        ("M/d/yyyy h:mm:ss tt", CultureInfo.InvariantCulture),
                                                               EndDate = ep.Project.EndDate.HasValue ?
                                                                        ep.Project.EndDate.Value.ToString
                                                                        ("M/d/yyyy h:mm:ss tt", CultureInfo.InvariantCulture)
                                                                                : "not finished"

                                                           })
                                                           .ToArray()
                                           })
                                           .ToArray();
        foreach (var e in employeesWithProjects)
        {
            sb.AppendLine($"{e.FirstName} {e.LastName} - Manager: {e.ManagerFirstName} {e.ManagerLastName}");
            foreach (var p in e.Projects)
            {
                sb.AppendLine($"--{p.ProjectName} - {p.StartDate} - {p.EndDate}");
            }
        }

        return sb.ToString().TrimEnd();
    }

    //P08
    public static string GetAddressesByTown(SoftUniContext context)
    {
        StringBuilder sb = new StringBuilder();

        var addresses = context.Addresses
                            .OrderByDescending(a => a.Employees.Count)
                            .ThenBy(a => a.Town!.Name)
                            .ThenBy(a => a.AddressText)
                            .Take(10)
                            .Select(a => new
                            {
                                a.AddressText,
                                TownName = a.Town!.Name,
                                EmployeeCount = a.Employees.Count()
                            })
                            .ToArray();

        foreach (var a in addresses)
        {
            sb.AppendLine($"{a.AddressText}, {a.TownName} - {a.EmployeeCount} employees");
        }

        return sb.ToString().TrimEnd();
    }

    //P09
    public static string GetEmployee147(SoftUniContext context)
    {
        StringBuilder sb = new StringBuilder();

        //Employee? e147 = context.Employees.Include(e => e.EmployeesProjects)
        //    .FirstOrDefault(e => e.EmployeeId == 147);

        //var e147projectsIds = e147.EmployeesProjects
        //                          .Select(ep => ep.ProjectId)
        //                          .ToList();

        //var projects = context.Projects.Where(p => e147projectsIds.Any(pid => pid == p.ProjectId)).ToArray();

        //var projects = context.Projects
        //    .Where(p => e147.EmployeesProjects.Select(ep => ep.ProjectId)
        //                                      .ToList()
        //                                      .Any(pid => pid == p.ProjectId))
        //    .OrderBy(p => p.Name)
        //    .ToList();

        var employee = context.Employees
                               .Where(e => e.EmployeeId == 147)
                               .Select(e => new {
                                      e.FirstName,
                                      e.LastName,
                                      e.JobTitle,
                                      Projects = e.EmployeesProjects
                                          .Select(ep => ep.Project.Name)
                                          .OrderBy(p => p)
                                          .ToList()
                                        })
                               .First();

        sb.AppendLine($"{employee.FirstName} {employee.LastName} - {employee.JobTitle}");
        sb.AppendLine(string.Join(Environment.NewLine, employee.Projects));


        return sb.ToString().TrimEnd();
    }

    //P10
    public static string GetDepartmentsWithMoreThan5Employees(SoftUniContext context)
    {
        StringBuilder sb = new StringBuilder();

        var departments = context.Departments
                                 .Where(d => d.Employees.Count > 5)
                                 .OrderBy(d => d.Employees.Count)
                                 .ThenBy(d => d.Name)
                                 .Select(d => new
                                    {
                                     DepartmentName = d.Name,
                                     ManagerFirstName = d.Manager.FirstName,
                                     ManagerLastName = d.Manager.LastName,
                                     Employees = d.Employees
                                                  .Select(e => new
                                                  {
                                                      e.FirstName,
                                                      e.LastName,
                                                      e.JobTitle
                                                  })
                                                  .OrderBy(e => e.FirstName)
                                                  .ThenBy(e => e.LastName)
                                                  .ToArray()
                                    })
                                 .ToArray();

        foreach (var d in departments)
        {
            sb.AppendLine($"{d.DepartmentName} – {d.ManagerFirstName} {d.ManagerLastName}");

            foreach (var e in d.Employees)
            {
                sb.AppendLine($"{e.FirstName} {e.LastName} - {e.JobTitle}");
            }
        }
        
        return sb.ToString().TrimEnd();     
    }

    //P11
    public static string GetLatestProjects(SoftUniContext context)
    {
        StringBuilder sb = new StringBuilder();

        var projects = context.Projects
                            .OrderByDescending(p => p.StartDate)
                            .Take(10)
                            .OrderBy(p => p.Name)
                            .Select(p => new
                            {
                                p.Name,
                                p.Description,
                                p.StartDate
                            })
                            .ToArray();

        foreach (var p in projects) 
        {
            sb.AppendLine(p.Name);
            sb.AppendLine(p.Description);
            sb.AppendLine(p.StartDate.ToString("M/d/yyyy h:mm:ss tt", CultureInfo.InvariantCulture));
        }

        return sb.ToString().TrimEnd();
    }

    //P12
    public static string IncreaseSalaries(SoftUniContext context)
    {
        StringBuilder sb = new StringBuilder();

        context.Employees
                    .Where(e => e.Department.Name == "Engineering" || e.Department.Name == "Tool Design"
                             || e.Department.Name == "Marketing" || e.Department.Name == "Information Services")
                    .ToList()
                    .ForEach(e => e.Salary *= 1.12m);
        context.SaveChanges();

        var employees = context.Employees
                            .Where(e => new[] { "Engineering", "Tool Design", "Marketing", "Information Services" }
                                             .Contains(e.Department.Name))
                            .Select(e => new
                            {
                                e.FirstName,
                                e.LastName,
                                e.Salary
                            })
                            .OrderBy(e => e.FirstName)
                            .ThenBy(e => e.LastName)
                            .ToList();

        foreach ( var e in employees)
        {
            sb.AppendLine($"{e.FirstName} {e.LastName} (${e.Salary:f2})");
        }

        return sb.ToString().TrimEnd();
    }

    //P13
    public static string GetEmployeesByFirstNameStartingWithSa(SoftUniContext context)
    {
        StringBuilder sb = new StringBuilder();

        var employees = context.Employees
                            .Where(e => e.FirstName.Substring(0, 2) == "Sa")
                            .Select(e => new
                            {
                                e.FirstName,
                                e.LastName,
                                e.JobTitle,
                                e.Salary
                            })
                            .OrderBy(e => e.FirstName)
                            .ThenBy(e => e.LastName)
                            .ToArray();

        foreach (var e in employees)
        {
            sb.AppendLine($"{e.FirstName} {e.LastName} - {e.JobTitle} - (${e.Salary:f2})");
        }

        return sb.ToString().TrimEnd();
    }

    //P14
    public static string DeleteProjectById(SoftUniContext context)
    {
        //Delete all rows from EmployeeProjects that refer to Project with Id = 2
        IQueryable<EmployeeProject> epToDelete = context.EmployeesProjects
                                                    .Where(ep => ep.ProjectId == 2);
        context.EmployeesProjects.RemoveRange(epToDelete);

        Project project = context.Projects.Find(2)!;
        context.Projects.Remove(project);

        context.SaveChanges();

        string[] projectNames = context.Projects
                                    .Take(10)
                                    .Select(p => p.Name)
                                    .ToArray();
        return String.Join(Environment.NewLine, projectNames);

    }

    //P15
    public static string RemoveTown(SoftUniContext context)
    {
        //First, setting the AddressId of each employee for the given address to null
           context.Employees.Where(e => e.Address.Town.Name == "Seattle")
                            .ToList()
                            .ForEach(e => e.AddressId = null);

        //Second, remove all the addresses from the context 
        var addressesToRemove = context.Addresses
                                    .Where(a => a.Town.Name == "Seattle")
                                    .ToList();
        int addressesCount = addressesToRemove.Count();

        context.Addresses.RemoveRange(addressesToRemove);

        //Finally, remove the given town
        Town townToRemove = context.Towns
                                .FirstOrDefault(t => t.Name == "Seattle")!;
        context.Towns.Remove(townToRemove);

        context.SaveChanges();

        return $"{addressesCount} addresses in Seattle were deleted";

    }

}