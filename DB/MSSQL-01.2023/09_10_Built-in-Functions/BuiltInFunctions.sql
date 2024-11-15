CREATE DATABASE Functions
GO
USE Functions
GO

USE SoftUni
GO

--1.	Find Names of All Employees by First Name
SELECT FirstName, LastName FROM Employees
	WHERE FirstName LIKE 'Sa%'

SELECT FirstName, LastName FROM Employees
	WHERE LEFT(FirstName, 2) = 'Sa'

--2.	Find Names of All Employees by Last Name 
SELECT FirstName, LastName FROM Employees
	WHERE LastName LIKE '%ei%'

SELECT FirstName, LastName FROM Employees
	WHERE CHARINDEX('ei', LastName) > 0

--3.	Find First Names of All Employees
SELECT FirstName FROM Employees
	WHERE DepartmentID IN (3, 10) 
	AND DATEPART(YEAR, HireDate) BETWEEN 1995 AND 2005

--4.	Find All Employees Except Engineers
SELECT FirstName, LastName FROM Employees
	WHERE JobTitle NOT LIKE '%engineer%'

SELECT FirstName, LastName FROM Employees
	WHERE CHARINDEX('engineer', JobTitle) = 0

--5.	Find Towns with Name Length
SELECT [Name] FROM Towns
	WHERE LEN([Name]) IN (5, 6)
	ORDER BY [Name]

--6.	Find Towns Starting With
SELECT * FROM Towns
	WHERE [Name] LIKE '[MKBE]%'
	ORDER BY [Name]

SELECT * FROM Towns
	WHERE LEFT([Name], 1) IN ('M', 'K', 'B', 'E')
	ORDER BY [Name]

--7.	Find Towns Not Starting With
SELECT * FROM Towns
	WHERE [Name] LIKE '[^R, B, D]%'
	ORDER BY [Name]

--8.	Create View Employees Hired After 2000 Year
GO
CREATE VIEW V_EmployeesHiredAfter2000 AS
	SELECT FirstName, LastName FROM Employees
	WHERE DATEPART(YEAR, HireDate) > 2000
GO
SELECT * FROM V_EmployeesHiredAfter2000
GO

--9.	Length of Last Name
SELECT FirstName, LastName FROM Employees
	WHERE LEN(LastName) = 5

--10. Rank Employees by Salary
SELECT EmployeeID
	 , FirstName
	 , LastName
	 , Salary
	 , DENSE_RANK() OVER 
	 (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
FROM Employees
WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC

--11.	Find All Employees with Rank 2 ?????
SELECT * FROM 
(
SELECT EmployeeID
	 , FirstName
	 , LastName
	 , Salary
	 , DENSE_RANK() OVER 
	 (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
FROM Employees
WHERE Salary BETWEEN 10000 AND 50000 
) AS [RankingSubquery] 
WHERE [Rank] = 2
ORDER BY Salary DESC

USE Geography
GO
--12.	Countries Holding 'A' 3 or More Times
SELECT CountryName
	 , IsoCode  
	FROM Countries
WHERE LEN(CountryName) - LEN(REPLACE(LOWER(CountryName), 'a', '')) >= 3
ORDER BY IsoCode

SELECT CountryName
	 , IsoCode  
	FROM Countries
WHERE LOWER(CountryName) LIKE '%a%a%a%'
ORDER BY IsoCode

--13.	 Mix of Peak and River Names
-- JOIN -> PK and FK (Relation);
-- Multiple Selection -> Combine data from two non-related tables
-- in this problem we do not have relation that's why it's better to use Multiple Selection

-- with JOIN
SELECT p.PeakName, 
	   r.RiverName,
	   LOWER(CONCAT(p.PeakName, SUBSTRING(r.RiverName, 2, LEN(r.RiverName) - 1))) AS [Mix]
	FROM Peaks AS p
JOIN Rivers AS r ON RIGHT(p.PeakName, 1) = LEFT(r.RiverName, 1)
ORDER BY Mix

-- with Multiple Selection
SELECT COUNT(*) FROM Peaks
SELECT COUNT(*) FROM Rivers

SELECT p.PeakName
	 , r.RiverName 
	 , LOWER(CONCAT(SUBSTRING(p.PeakName, 1, LEN(p.PeakName) - 1), r.RiverName)) AS [Mix]
	FROM Peaks AS p,
	     Rivers AS r
WHERE RIGHT(LOWER(p.PeakName), 1) = LEFT(LOWER(r.RiverName), 1)
ORDER BY Mix

USE Diablo
GO
--14. Games From 2011 and 2012 Year
SELECT TOP(50) [Name]
			 , FORMAT([Start], 'yyyy-MM-dd') AS [Start] 
	FROM Games
WHERE YEAR(Start) IN (2011, 2012)
ORDER BY [Start], [Name]

--15.	 User Email Providers
SELECT Username
	 , SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email) - CHARINDEX('@', Email)) AS [Email Provider]
	FROM Users
ORDER BY [Email Provider], Username

--16.	 Get Users with IP Address Like Pattern
SELECT Username
	 , IpAddress 
	FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username

--17.	 Show All Games with Duration and Part of the Day
SELECT [Name] AS [Game]
	 , CASE WHEN DATEPART(HOUR, [Start]) < 12 THEN 'Morning'
			WHEN DATEPART(HOUR, [Start]) < 18 THEN 'Afternoon'
			ELSE 'Evening' 
	   END AS [Part of the Day]
	 , CASE WHEN Duration <= 3 THEN 'Extra Short'
			WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
			WHEN Duration > 6 THEN 'Long'
			ELSE 'Extra Long'
	   END AS [Duration]
	FROM Games
ORDER BY [Name], [Duration], [Part of the Day]


--18. Orders Table
USE Orders
GO
SELECT ProductName
	 , OrderDate
	 , DATEADD(DAY, 3, OrderDate) AS [Pay Due]
	 , DATEADD(MONTH, 1, OrderDate) AS [Deliver Due]
	FROM Orders

--19.	 People Table
USE Orders
GO
CREATE TABLE People
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50),
	Birthdate DATETIME2
)
INSERT People 
([Name], Birthdate)
VALUES
('Viktor', '2000-12-07'),
('Steven', '1992-09-10'),
('Stephen', '1910-09-19'),
('John', '2010-01-06')

SELECT [Name]
	 , DATEDIFF(YEAR, Birthdate, GETDATE()) AS [Age in Years]
	 , DATEDIFF(MONTH, Birthdate, GETDATE()) AS [Age in Months]
	 , DATEDIFF(DAY, Birthdate, GETDATE()) AS [Age in Days]
	 , DATEDIFF(MINUTE, Birthdate, GETDATE()) AS [Age in Minutes]
	FROM People


