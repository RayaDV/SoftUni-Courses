-- 2 --
SELECT * FROM Departments

-- 3 --
SELECT [Name] FROM Departments

-- 4 --
SELECT FirstName, LastName, Salary FROM Employees

-- 5 --
SELECT FirstName, MiddleName, LastName FROM Employees

-- 6 --
SELECT FirstName + '.' + LastName + '@softuni.bg' AS [Full Email Address]
	FROM Employees

SELECT CONCAT(FirstName, '.', MiddleName, '.', LastName, '.', '@', 'softuni.bg')
	AS [Full Email Address]
	, MiddleName
	FROM Employees
-- където има нулева стойност, общият резултат е NULL, ако не се използва CONCAT()
SELECT FirstName + '.' + MiddleName + '.' + LastName + '.' + '@' + 'softuni.bg'
	AS [Full Email Address]
	, MiddleName
	FROM Employees
-- за да нямаме двуеточие, можем да направим:
SELECT CONCAT(FirstName, '.', MiddleName + '.', LastName, '.', '@', 'softuni.bg')
	AS [Full Email Address]
	, MiddleName
	FROM Employees

-- 7 --
SELECT DISTINCT Salary FROM Employees

-- 8 --
SELECT * FROM Employees WHERE JobTitle = 'Sales Representative'

-- 9 --
SELECT FirstName, LastName, JobTitle FROM Employees 
	WHERE Salary BETWEEN 20000 AND 30000

-- 10 --
SELECT FirstName + ' ' + MiddleName + ' ' + LastName AS [Full Name] FROM Employees
	WHERE Salary = 25000 OR Salary = 14000 OR Salary = 12500 OR Salary = 23600;

SELECT FirstName + ' ' + MiddleName + ' ' + LastName AS [Full Name] FROM Employees
	WHERE Salary IN (25000, 14000, 12500, 23600)

-- WITH CANCAT_WS - LIKE STRING.JOIN
SELECT CONCAT_WS(' ', FirstName, MiddleName, LastName) AS [Full Name] FROM Employees
	WHERE Salary IN (25000, 14000, 12500, 23600)

-- 11 --
SELECT FirstName, LastName FROM Employees
	WHERE ManagerID IS NULL;

-- 12 --
SELECT FirstName, LastName, Salary FROM Employees
	WHERE Salary > 50000 
	ORDER BY Salary DESC

-- 13 --
SELECT TOP(5) FirstName, LastName FROM Employees
	ORDER BY Salary DESC

-- 14 --
SELECT FirstName, LastName FROM Employees
	WHERE DepartmentID <> 4;

-- 15 --
SELECT * FROM Employees
	ORDER BY Salary DESC
			, FirstName
			, LastName DESC
			, MiddleName;

-- 16 --
--View store temporaly the SELECT query, not the resultset!!!
GO
CREATE VIEW V_EmployeesSalaries AS
SELECT FirstName, LastName, Salary 
	FROM Employees
GO
SELECT * FROM V_EmployeesSalaries;
GO

-- 17 --
--View store temporaly the SELECT query, not the resultset!!!
GO
CREATE VIEW V_EmployeeNameJobTitle AS 
SELECT CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS [Full Name]
		, JobTitle AS [Job Title]
		FROM Employees;
GO
SELECT * FROM V_EmployeeNameJobTitle;
GO

-- 18 --
SELECT DISTINCT JobTitle FROM Employees

-- 19 --
SELECT TOP(10) * FROM Projects
	ORDER BY StartDate, [Name];

-- 20 --
SELECT TOP(7) FirstName, LastName, HireDate FROM Employees
	ORDER BY HireDate DESC

-- 21 --
--HELPER QUERY
SELECT [DepartmentID] FROM Departments
	WHERE [Name] IN ('Engineering', 'Tool Design', 'Marketing', 'Information Services')

BEGIN TRANSACTION
GO
--MAIN QUERY
UPDATE Employees
SET Salary = 1.12 * Salary
WHERE DepartmentID = (1, 2, 4, 11);

SELECT Salary FROM Employees

ROLLBACK TRANSACTION
COMMIT TRANSACTION

--ADVANCED SOLUTION (SUBQUERIES)
UPDATE Employees
SET Salary = 1.12 * Salary
WHERE DepartmentID = (SELECT [DepartmentID] FROM Departments
	WHERE [Name] IN ('Engineering', 'Tool Design', 'Marketing', 'Information Services'));

-- 22 --
SELECT PeakName FROM Peaks ORDER BY PeakName

-- 23 --
SELECT TOP(30) CountryName, [Population] FROM Countries
	WHERE ContinentCode = 'EU'
	ORDER BY [Population] DESC, CountryName

-- 24 --
SELECT CountryName
	 , CountryCode
	 , CASE
		WHEN CurrencyCode = 'EUR' THEN 'Euro'
		ELSE 'Not Euro'
		END AS [Currency]
FROM Countries
ORDER BY CountryName;

-- 25 --
SELECT [Name] FROM Characters 
	ORDER BY [Name]
