USE SoftUni
GO

--1.	Employees with Salary Above 35000
CREATE PROC usp_GetEmployeesSalaryAbove35000 
AS
	SELECT
		FirstName,
		LastName
	FROM Employees
	WHERE Salary > 35000
GO
EXEC usp_GetEmployeesSalaryAbove35000 
GO

--2.	Employees with Salary Above Number
CREATE PROC usp_GetEmployeesSalaryAboveNumber(@number DECIMAL(18,4))
AS
	SELECT
		FirstName,
		LastName
	FROM Employees
	WHERE Salary >= @number
GO
EXEC usp_GetEmployeesSalaryAboveNumber 48100
GO

--3.	Town Names Starting With
CREATE PROC usp_GetTownsStartingWith (@string VARCHAR(50))
AS
	SELECT [Name] AS Town
	FROM Towns
	WHERE [Name] LIKE CONCAT(@string, '%')
GO
EXEC usp_GetTownsStartingWith 'b'
DROP PROC usp_GetTownsStartingWith
GO

--4.	Employees from Town
CREATE PROC usp_GetEmployeesFromTown (@townName VARCHAR(50))
AS
	SELECT
		e.FirstName,
		e.LastName
	FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = a.AddressID
	JOIN Towns AS t ON a.TownID = t.TownID
	WHERE t.[Name] = @townName
GO
EXEC usp_GetEmployeesFromTown 'Sofia'
DROP PROC usp_GetEmployeesFromTown
SELECT * FROM Towns
SELECT * FROM Employees
GO

--5.	Salary Level Function
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS NVARCHAR(10)
AS
BEGIN
	DECLARE @salaryLevel VARCHAR(10)
	IF (@salary < 30000)
		SET @salaryLevel = 'Low'
	IF (@salary BETWEEN 30000 AND 50000)
		SET @salaryLevel = 'Average'
	IF (@salary > 50000)
		SET @salaryLevel = 'High'
	RETURN @salaryLevel
END;
GO

dbo.ufn_GetSalaryLevel 13500
SELECT
	FirstName,
	LastName,
	Salary,
	dbo.ufn_GetSalaryLevel (Salary) AS [Salary Level]
FROM Employees
GO

--6.	Employees by Salary Level
CREATE PROC usp_EmployeesBySalaryLevel (@levelOfSalary VARCHAR(10))
AS
	SELECT
		FirstName,
		LastName
	FROM Employees
	WHERE dbo.ufn_GetSalaryLevel (Salary) = @levelOfSalary
GO
EXEC usp_EmployeesBySalaryLevel 'High'
GO

--7.	Define Function
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(50), @word VARCHAR(50)) 
RETURNS BIT
AS 
BEGIN
	DECLARE @wordIndex INT = 1
	WHILE(@wordIndex <= LEN(@word))
	BEGIN
			DECLARE @currChar CHAR = SUBSTRING(@word, @wordIndex, 1)

			IF CHARINDEX(@currChar, @setOfLetters) = 0
			BEGIN
				RETURN 0
			END

			SET @wordIndex += 1
	END
	RETURN 1
END
GO

SELECT dbo.ufn_IsWordComprised ('oistmiahf', 'Sofia')
SELECT dbo.ufn_IsWordComprised ('oistmiahf', 'halves')
SELECT dbo.ufn_IsWordComprised ('bobr', 'Rob')
GO

--8.	Delete Employees and Departments
CREATE OR ALTER PROC usp_DeleteEmployeesFromDepartment (@departmentId INT) 
AS
BEGIN
	-- We need to store all id's of the Employees that are going to be deleted
	DECLARE @employeesToDelete TABLE ([Id] INT)
	INSERT INTO @employeesToDelete
		SELECT EmployeeID
		FROM Employees
		WHERE DepartmentID = @departmentId

	-- Employees which we are going to remove can be working on some projects. So we need to remove them from working on this projects.
	DELETE FROM EmployeesProjects
	WHERE EmployeeID IN (
			SELECT Id
			FROM @employeesToDelete
						)	

	-- Employees which we are going to remove can be managers of some Departments. So we need to set ManagerID to NULL of all Departmens with futurely deleted managers. First we need to alter column ManagerID
	ALTER TABLE Departments
	ALTER COLUMN ManagerID INT

	UPDATE Departments
	SET ManagerID = NULL
	WHERE ManagerID IN (
			SELECT Id
			FROM @employeesToDelete
					   )
	-- Employees which we are going to delete can be managers of another employees. So we need to set ManagerID to NULL of all employees with futurely deleted managers.
	UPDATE Employees
	SET ManagerID = NULL
	WHERE ManagerID IN (
			SELECT Id
			FROM @employeesToDelete
					   )

	-- Since we removed all references to the employees we want to remove. We can safely remove them.
	DELETE FROM Employees
	WHERE DepartmentID = @departmentId

	DELETE FROM Departments
	WHERE DepartmentID = @departmentId

	SELECT COUNT(*)
	FROM Employees
	WHERE DepartmentID = @departmentId
END

GO

EXEC dbo.usp_DeleteEmployeesFromDepartment 7

SELECT *
FROM Employees
WHERE DepartmentID = 7


GO
USE Bank
GO
--9.	Find Full Name
CREATE PROC usp_GetHoldersFullName 
AS
	SELECT
		CONCAT(FirstName, ' ', LastName) AS [Full Name]
	FROM AccountHolders

GO
EXEC usp_GetHoldersFullName 
GO

--10.	People with Balance Higher Than
CREATE PROC usp_GetHoldersWithBalanceHigherThan (@number MONEY)
AS
	SELECT
		FirstName,
		LastName
	FROM AccountHolders AS ac
	JOIN Accounts AS a ON ac.Id = a.AccountHolderId
	GROUP BY FirstName, LastName
	HAVING SUM(a.Balance) > @number
	ORDER BY FirstName, LastName

GO
EXEC usp_GetHoldersWithBalanceHigherThan 50000
GO

--11. Future Value Function
CREATE FUNCTION ufn_CalculateFutureValue (@sum DECIMAL, @yearlyInterestRate FLOAT, @years INT)
RETURNS DECIMAL(38, 4)
AS
BEGIN
	RETURN POWER ((1 + @yearlyInterestRate), @years) * @sum
END

GO
SELECT dbo.ufn_CalculateFutureValue (1000, 0.1, 5)
GO

--12.	Calculating Interest
CREATE PROC usp_CalculateFutureValueForAccount (@accountId INT, @interestRate FLOAT)
AS
	SELECT 
		ah.Id AS [Account Id],
		FirstName AS [First Name],
		LastName AS [Last Name],
		a.Balance AS [Current Balance],
		dbo.ufn_CalculateFutureValue (a.Balance, @interestRate, 5) AS [Balance in 5 years]
	FROM AccountHolders AS ah
	JOIN Accounts AS a ON ah.Id = a.AccountHolderId
	WHERE a.Id = @accountId

GO
EXEC usp_CalculateFutureValueForAccount 1, 0.1
GO


USE Diablo
GO

--13.	*Scalar Function: Cash in User Games Odd Rows
CREATE FUNCTION ufn_CashInUsersGames (@gameName NVARCHAR(50))
RETURNS TABLE AS
RETURN (
		SELECT 
			SUM(Cash) AS SumCash
		FROM (
			SELECT
				g.[Name],
				ug.Cash,
				ROW_NUMBER() OVER(ORDER BY ug.Cash DESC) AS RowNumber
			FROM UsersGames AS ug
			JOIN Games AS g ON ug.GameId = g.Id
			WHERE g.Name = @gameName
			 ) AS RankingSubquery
		WHERE RowNumber % 2 <> 0
	   )
GO
SELECT * 
FROM dbo.ufn_CashInUsersGames ('Love in a mist')