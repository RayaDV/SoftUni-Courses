using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace EFIntro.Models
{
    public partial class Employee
    {
        public Employee()
        {
            Projects = new HashSet<Project>();
        }

        [Key]
        public int Id { get; set; }
        [StringLength(50)]
        [Unicode(false)]
        public string FirstName { get; set; } = null!;
        [StringLength(50)]
        [Unicode(false)]
        public string? MiddleName { get; set; }
        [StringLength(50)]
        [Unicode(false)]
        public string LastName { get; set; } = null!;
        public bool IsEmployed { get; set; }
        public int? DepartmentId { get; set; }

        [ForeignKey(nameof(DepartmentId))]
        [InverseProperty("Employees")]
        public virtual Department? Department { get; set; }

        [ForeignKey("EmployeeId")]
        [InverseProperty(nameof(Project.Employees))]
        public virtual ICollection<Project> Projects { get; set; }
    }
}
