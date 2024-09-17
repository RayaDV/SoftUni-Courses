using MiniORM.App.Data.Entities;

namespace MiniORM.App.Data;

public class OurDbContext : DbContext
{
    public OurDbContext(string connectionString) 
        : base(connectionString)
    {
        
    }

    public DbSet<Employee> Employees { get; set; }

    public DbSet<Project> Projects { get; set; }

    public DbSet<Department> Departments { get; set; }

    public DbSet<EmployeeProject> EmployeeProjects { get; set; }
}
