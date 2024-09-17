using Microsoft.EntityFrameworkCore;
using P01_StudentSystem.Data.Common;
using P01_StudentSystem.Data.Models;

namespace P01_StudentSystem.Data;

public class StudentSystemContext : DbContext
{
    //Two constructors:
    public StudentSystemContext()
    {
        
    }
    public StudentSystemContext(DbContextOptions options)
        : base(options)
    {
        
    }

    //DbSets:
    public DbSet<Student> Students { get; set; } = null!;

    public DbSet<Course> Courses { get; set; } = null!;

    public DbSet<Resource> Resources { get; set; } = null!;

    public DbSet<Homework> Homeworks { get; set; } = null!;

    public DbSet<StudentCourse> StudentsCourses { get; set; } = null!;



    //Connection configuration
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (!optionsBuilder.IsConfigured)
        {
            //Set default connection string
            //Someone used empty constructor of our DbContext
            optionsBuilder.UseSqlServer(DbConfig.ConnectionString);
        }
        base.OnConfiguring(optionsBuilder);
    }

    //Fluent API and Entities config
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Student>()
            .Property(s => s.Name)
            .HasColumnType("NVARCHAR");

        modelBuilder.Entity<Course>()
            .Property(c => c.Name)
            .HasColumnType("NVARCHAR");
        modelBuilder.Entity<Course>()
            .Property(c => c.Description)
            .HasColumnType("NVARCHAR");

        modelBuilder.Entity<Resource>()
            .Property(c => c.Name)
            .HasColumnType("NVARCHAR");

        modelBuilder.Entity<StudentCourse>(entity =>
        {
            entity.HasKey(sc => new { sc.StudentId, sc.CourseId });
        });

    }
}   