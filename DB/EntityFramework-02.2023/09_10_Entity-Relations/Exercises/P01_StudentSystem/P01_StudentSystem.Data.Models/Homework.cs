﻿using P01_StudentSystem.Data.Models.Enum;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace P01_StudentSystem.Data.Models;

public class Homework
{
    [Key]
    public int HomeworkId { get; set; }

    public string Content { get; set; } = null!;

    public ContentType ContentType { get; set; }

    public DateTime SubmissionTime { get; set; }


    [ForeignKey(nameof(Student))]
    public int StudentId { get; set; }

    public virtual Student Student { get; set; } = null!;


    [ForeignKey(nameof(Course))]
    public int CourseId { get; set; }

    public virtual Course Course { get; set; } = null!;

}
