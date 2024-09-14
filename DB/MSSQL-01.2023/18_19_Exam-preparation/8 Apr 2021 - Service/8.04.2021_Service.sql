CREATE DATABASE Service
GO
USE Service
GO

--Section 1. DDL (30 pts)
--1.	Table design
CREATE TABLE Users (
	Id INT PRIMARY KEY IDENTITY,
	Username VARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR(50) NOT NULL,
	[Name] VARCHAR(50),
	Birthdate DATETIME2,
	Age INT CHECK (Age BETWEEN 14 AND 110),
	Email VARCHAR(50) NOT NULL
)
CREATE TABLE Departments (
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL
)
CREATE TABLE Employees (
	Id INT PRIMARY KEY IDENTITY,
	FirstName VARCHAR(25),
	LastName VARCHAR(25),
	Birthdate DATETIME2,
	Age INT CHECK (Age BETWEEN 18 AND 110),
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id)
)
CREATE TABLE Categories (
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id) NOT NULL
)
CREATE TABLE [Status] (
	Id INT PRIMARY KEY IDENTITY,
	[Label] VARCHAR(20) NOT NULL
)
CREATE TABLE Reports (
	Id INT PRIMARY KEY IDENTITY,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	StatusId INT FOREIGN KEY REFERENCES [Status](Id) NOT NULL,
	OpenDate DATETIME2 NOT NULL,
	CloseDate DATETIME2,
	[Description] VARCHAR(200) NOT NULL,
	UserId INT FOREIGN KEY REFERENCES Users(Id) NOT NULL,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id)
)

--Section 2. DML (10 pts)
--2.	Insert
INSERT INTO Employees
(FirstName, LastName, Birthdate, DepartmentId)
VALUES
('Marlo', 'O''Malley', '1958-9-21', 1),
('Niki', 'Stanaghan', '1969-11-26', 4),
('Ayrton', 'Senna', '1960-03-21', 9),
('Ronnie', 'Peterson', '1944-02-14', 9),
('Giovanna', 'Amati', '1959-07-20', 5)

INSERT INTO Reports
(CategoryId, StatusId, OpenDate, CloseDate, [Description], UserId, EmployeeId)
VALUES
(1, 1, '2017-04-13', NULL, 'Stuck Road on Str.133', 6, 2),
(6, 3, '2015-09-05', '2015-12-06', 'Charity trail running', 3, 5),
(14, 2, '2015-09-07', NULL, 'Falling bricks on Str.58', 5, 2),
(4, 3, '2017-07-03', '2017-07-06', 'Cut off streetlight on Str.11', 1, 1)

--3.	Update
UPDATE Reports
SET CloseDate = GETDATE()
WHERE CloseDate IS NULL

--4.	Delete
DELETE FROM Reports
WHERE StatusId = 4

--Section 3. Querying (40 pts)
--5.	Unassigned Reports
SELECT
	[Description],
	FORMAT(OpenDate, 'dd-MM-yyyy') AS [OpenDate]
FROM Reports
WHERE EmployeeId IS NULL
ORDER BY CAST(OpenDate AS DATE), [Description]

--6.	Reports & Categories
SELECT
	r.[Description],
	c.[Name]
FROM Reports AS r
JOIN Categories AS c ON c.Id = r.CategoryId
ORDER BY r.[Description], c.[Name]

--7.	Most Reported Category
SELECT TOP(5)
	c.[Name] AS CategoryName,
	COUNT(r.Id) AS ReportsNumber
FROM Reports AS r
JOIN Categories AS c ON c.Id = r.CategoryId
GROUP BY c.[Name]
ORDER BY ReportsNumber DESC, CategoryName

--8.	Birthday Report
SELECT
	u.Username,
	c.[Name] AS CategoryName
FROM Reports AS r
JOIN Categories AS c ON c.Id = r.CategoryId
JOIN Users AS u ON u.Id = r.UserId
WHERE FORMAT(u.Birthdate, 'dd-MM') = FORMAT(r.OpenDate, 'dd-MM')
ORDER BY Username, CategoryName

--9.	Users per Employee 
SELECT
	CONCAT(FirstName, ' ', LastName) AS FullName,
	COUNT (r.UserId) AS UsersCount
FROM Employees AS e
LEFT JOIN Reports AS r ON r.EmployeeId = e.Id
LEFT JOIN Users AS u ON u.Id = r.UserId
GROUP BY CONCAT(FirstName, ' ', LastName)
ORDER BY UsersCount DESC, FullName

--10.	Full Info
SELECT
	ISNULL((FirstName + ' ' + LastName), 'None') AS Employee,
	ISNULL(d.[Name], 'None') AS Department,
	ISNULL(c.[Name], 'None') AS Category,
	ISNULL(r.[Description], 'None') AS [Description],
	ISNULL(FORMAT(r.OpenDate, 'dd.MM.yyyy'), 'None') AS OpenDate,
	ISNULL(s.[Label], 'None') AS [Status],
	ISNULL(u.[Name], 'None') AS [User]
FROM Reports AS r
LEFT JOIN Categories AS c ON c.Id = r.CategoryId
LEFT JOIN Users AS u ON u.Id = r.UserId
LEFT JOIN Employees AS e ON r.EmployeeId = e.Id
LEFT JOIN Departments AS d ON d.Id = e.DepartmentId
LEFT JOIN [Status] AS s ON s.Id = r.StatusId
ORDER BY FirstName DESC,
		 LastName DESC,
		 Department,
		 Category,
		 [Description],
		 OpenDate,
		 [Status],
		 [User]

--Section 4. Programmability (20 pts)
--11.	Hours to Complete
GO
CREATE FUNCTION udf_HoursToComplete(@StartDate DATETIME, @EndDate DATETIME)
RETURNS INT
AS
BEGIN
	IF @StartDate IS NULL OR @EndDate IS NULL
	BEGIN
		RETURN 0
	END
	RETURN DATEDIFF(HOUR, @StartDate, @EndDate)
END
GO

SELECT dbo.udf_HoursToComplete(OpenDate, CloseDate) AS TotalHours
   FROM Reports

--12.	Assign Employee

GO
CREATE OR ALTER PROC usp_AssignEmployeeToReport(@EmployeeId INT, @ReportId INT)
AS
BEGIN
	DECLARE @DepartmentOfTheEmployee INT = (
		SELECT DepartmentId
		FROM Employees AS e
		WHERE e.Id = @EmployeeId                 
	)
	--DECLARE @CategoryIdOfTheReport INT = (
	--	SELECT r.CategoryId 
	--	FROM Reports AS r 
	--	WHERE r.Id = @ReportId               
	--)
	--DECLARE @DepartmentOfReportsCategory INT = (
	--	SELECT c.DepartmentId
	--	FROM Categories AS c
	--	WHERE c.Id = @CategoryIdOfTheReport
	--)

	DECLARE @DepartmentOfReportsCategory INT = (
		SELECT c.DepartmentId
		FROM Reports AS r
		LEFT JOIN Categories AS c
		ON r.CategoryId = c.Id
		WHERE r.Id = @ReportId
	)

	IF @DepartmentOfTheEmployee <> @DepartmentOfReportsCategory
		THROW 50001, 'Employee doesn''t belong to the appropriate department!', 1;
	ELSE
	BEGIN
		UPDATE Reports
		SET EmployeeId = @EmployeeId
		WHERE Id = @ReportId
	END
END
GO

EXEC usp_AssignEmployeeToReport 30, 1
GO
EXEC usp_AssignEmployeeToReport 17, 2
EXEC usp_AssignEmployeeToReport 13, 4

SELECT DepartmentId FROM Categories WHERE Id = (
SELECT CategoryId FROM REPORTS
WHERE Id = 4 )

SELECT * FROM Employees
WHERE DepartmentId = 4

SELECT Id, EmployeeId FROM REPORTS
WHERE Id = 4

