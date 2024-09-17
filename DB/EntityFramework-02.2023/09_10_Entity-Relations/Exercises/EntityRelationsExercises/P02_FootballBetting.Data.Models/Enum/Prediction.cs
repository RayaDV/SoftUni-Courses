namespace P02_FootballBetting.Data.Models.Enum;

//Enumerations are not entities in the DB
//Enumerations are string representation of int values
//In the DB -> int

public enum Prediction
{
    Draw = 0,
    Win = 1,
    Lose = 2
}
