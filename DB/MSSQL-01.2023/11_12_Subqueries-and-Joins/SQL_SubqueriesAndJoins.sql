USE SoftUni
GO
--GROUPING DEMO
SELECT 
	  JobTitle
	, AVG(Salary) AS AverageSalary
	, COUNT(EmployeeID) AS WorkersCount
 FROM Employees
GROUP BY JobTitle
HAVING AVG(Salary) > 20000

--1.	Employee Address
SELECT TOP(5)
	   e.EmployeeID
	 , e.JobTitle 
	 , e.AddressID
	 , a.AddressText
FROM Employees AS e 
INNER JOIN Addresses AS a --може и left join, защото може да не се въведе нищо на адрес на служител (nullable) и тогава тези стойности ще ги изпуснем
	ON e.AddressID = a.AddressID
ORDER BY e.AddressID

--2.	Addresses with Towns
SELECT TOP(50)
	e.FirstName
  , e.LastName
  , t.[Name] AS [Town]
  , a.AddressText
FROM Employees AS e 
INNER JOIN Addresses AS a 
	ON e.AddressID = a.AddressID
INNER JOIN Towns AS t 
	ON a.TownID = T.TownID
ORDER BY FirstName, LastName

--3.	Sales Employee
SELECT
	e.EmployeeID
  , e.FirstName
  , e.LastName
  , d.[Name] AS DepartmentName
FROM Employees AS e
JOIN Departments AS d 
	ON e.DepartmentID = d.DepartmentID
WHERE d.[Name] = 'Sales'
ORDER BY e.EmployeeID

--4.	Employee Departments
SELECT TOP(5)
	e.EmployeeID
  , e.FirstName
  , e.Salary
  , d.[Name] AS DepartmentName
FROM Employees AS e
JOIN Departments AS d 
	ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 15000
ORDER BY e.DepartmentID

--5.	Employees Without Project
SELECT TOP(3)
	e.EmployeeID
  , e.FirstName
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep      --ANTY LEFT JOIN
	ON e.EmployeeID = ep.EmployeeID
WHERE ep.ProjectID IS NULL
ORDER BY e.EmployeeID

--6.	Employees Hired After
SELECT
	  e.FirstName
    , e.LastName
    , e.HireDate
    , d.[Name] AS DeptName
 FROM Employees AS e
 JOIN Departments AS d 
   ON e.DepartmentID = d.DepartmentID
WHERE e.HireDate > '1999-01-01'
  AND d.[Name] IN ('Sales', 'Finance')
ORDER BY e.HireDate

--7.	Employees with Project
SELECT TOP(5)
	  e.EmployeeID
	, e.FirstName
	, p.[Name] AS ProjectName
 FROM Employees AS e
 JOIN EmployeesProjects AS ep 
   ON e.EmployeeID = ep.EmployeeID
 JOIN Projects AS p
   ON ep.ProjectID = p.ProjectID
WHERE p.StartDate > '2002-08-13'
  AND p.EndDate IS NULL
ORDER BY e.EmployeeID

--8.	Employee 24
SELECT
	  e.EmployeeID
	, e.FirstName
	, CASE
	  WHEN YEAR(p.StartDate) >= 2005 THEN NULL
	  ELSE p.[Name]
	  END AS ProjectName
 FROM Employees AS e
 JOIN EmployeesProjects AS ep 
   ON e.EmployeeID = ep.EmployeeID
 JOIN Projects AS p
   ON ep.ProjectID = p.ProjectID
WHERE e.EmployeeID = 24

--09. Employee Manager
SELECT
	  e.EmployeeID
	, e.FirstName
	, e.ManagerID
	, m.FirstName AS ManagerName
FROM Employees AS e
JOIN Employees AS m ON e.ManagerID = m.EmployeeID
WHERE e.ManagerID IN (3, 7)
ORDER BY EmployeeID

--10.	Employees Summary
SELECT TOP(50)
	  e.EmployeeID
	, CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName
	, CONCAT(m.FirstName, ' ', m.LastName) AS ManagerName
	, d.[Name] AS DepartmentName
 FROM Employees AS e
 JOIN Employees AS m ON e.ManagerID = m.EmployeeID
 JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
ORDER BY e.EmployeeID

--11.	Min Average Salary
SELECT 
	MIN(a.AverageSalary) AS MinAverageSalary 
 FROM 
(SELECT 
	  e.DepartmentID
	, AVG(e.Salary) AS AverageSalary
 FROM Employees AS e
GROUP BY e.DepartmentID
) AS a

USE Geography
GO

--12.	Highest Peaks in Bulgaria
SELECT 
	  mc.CountryCode
	, m.MountainRange
	, p.PeakName
	, p.Elevation
 FROM Peaks AS p
 JOIN Mountains AS m ON p.MountainId = m.Id
 JOIN MountainsCountries AS mc ON m.Id = mc.MountainId
WHERE p.Elevation > 2835 AND mc.CountryCode = 'BG'
ORDER BY p.Elevation DESC

--13.	Count Mountain Ranges
SELECT 
	a.CountryCode 
	, COUNT(a.MountainRange) AS MountainRanges
FROM 
(SELECT 
	  mc.CountryCode
	, m.MountainRange
 FROM Mountains AS m
 JOIN MountainsCountries AS mc ON m.Id = mc.MountainId
WHERE mc.CountryCode IN ('BG', 'RU', 'US')
) AS a
GROUP BY a.CountryCode

--Method 2
SELECT CountryCode,
	   COUNT(MountainId) AS MountainRanges
  FROM MountainsCountries
 WHERE CountryCode IN (
	SELECT CountryCode
	  FROM Countries
	 WHERE CountryName IN ('United States', 'Russia', 'Bulgaria')
	)
 GROUP BY CountryCode

--14.	Countries With or Without Rivers
SELECT TOP(5)
	  c.CountryName
	, r.RiverName
FROM Countries AS c
LEFT OUTER JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
LEFT OUTER JOIN Rivers AS r ON cr.RiverId = r.Id
WHERE c.ContinentCode IN
	(SELECT ContinentCode
	   FROM Continents
	  WHERE ContinentName = 'Africa')
ORDER BY c.CountryName 

--15.	*Continents and Currencies
SELECT
	ContinentCode,
	CurrencyCode,
	CurrencyUsage
FROM (
	SELECT *,
		DENSE_RANK() OVER (PARTITION BY ContinentCode ORDER BY CurrencyUsage DESC) AS CurrencyRank	
	FROM (
		SELECT 
			ContinentCode,
			CurrencyCode,
			COUNT(*) AS CurrencyUsage
		FROM Countries
		GROUP BY ContinentCode, CurrencyCode
		HAVING COUNT(*) > 1
		 ) AS CuurencyUsageSubquery
	 ) AS CuurencyRankSubquery
WHERE CurrencyRank = 1

--16.	Countries Without Any Mountains
SELECT COUNT(*) AS Count
FROM (
	SELECT 
		c.CountryName,
		m.MountainRange
	FROM Countries AS c
	LEFT OUTER JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
	LEFT OUTER JOIN Mountains AS m ON mc.MountainId = m.Id
	WHERE m.MountainRange IS NULL
	 ) AS CountryMountainSubquery
GROUP BY MountainRange

--17.	Highest Peak and Longest River by Country
--METHOD 1 WITH RANK
SELECT TOP(5)
	CountryName,
	Elevation AS HighestPeakElevation,
	[Length] AS LongestRiverLength
FROM (
	SELECT *,
		   DENSE_RANK() OVER (PARTITION BY CountryName ORDER BY Elevation DESC) AS PeaksRank,
		   DENSE_RANK() OVER (PARTITION BY CountryName ORDER BY [Length] DESC) AS RiversRank
	FROM (
		SELECT
			c.CountryName, 
			p.PeakName,
			p.Elevation,
			r.RiverName,
			r.[Length]
		FROM Countries AS c
		LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
		LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
		LEFT JOIN Peaks AS p ON m.Id = p.MountainId
		LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
		LEFT JOIN Rivers AS r ON cr.RiverId = r.Id
		 ) AS CountriesPeaksRiversSubquery
     ) AS SecondSubquery
WHERE PeaksRank = 1 AND RiversRank = 1
ORDER BY Elevation DESC, [Length] DESC, CountryName

--METHOD 2 WIHT AGGREGATE FUNCTION
SELECT TOP(5)
	CountryName,
	MAX(Elevation) AS HighestPeakElevation,
	MAX([Length]) AS LongestRiverLength
FROM (
		SELECT
			c.CountryName, 
			p.PeakName,
			p.Elevation,
			r.RiverName,
			r.[Length]
		FROM Countries AS c
		LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
		LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
		LEFT JOIN Peaks AS p ON m.Id = p.MountainId
		LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
		LEFT JOIN Rivers AS r ON cr.RiverId = r.Id
		 ) AS CountriesPeaksRiversSubquery
GROUP BY CountryName
ORDER BY HighestPeakElevation DESC, 
		 LongestRiverLength DESC, 
		 CountryName

--METHOD 3 -	WE CAN MISS THE SUBQUERY IN METHOD 2
SELECT TOP(5)
	CountryName,
	MAX(Elevation) AS HighestPeakElevation,
	MAX([Length]) AS LongestRiverLength
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
LEFT JOIN Peaks AS p ON m.Id = p.MountainId
LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers AS r ON cr.RiverId = r.Id
GROUP BY CountryName
ORDER BY HighestPeakElevation DESC, 
		 LongestRiverLength DESC, 
		 CountryName

--18.	Highest Peak Name and Elevation by Country
SELECT TOP(5)
	CountryName AS Country,
	ISNULL(PeakName, '(no highest peak)') AS [Highest Peak Name],
	ISNULL(Elevation, 0) AS [Highest Peak Elevation],
	CASE
		WHEN MountainRange IS NULL THEN '(no mountain)'
		ELSE MountainRange
	END AS Mountain
FROM (
	SELECT *,
	       DENSE_RANK() OVER (PARTITION BY CountryName ORDER BY Elevation DESC) AS PeaksRank	
	FROM (
		SELECT
			c.CountryName,
			p.PeakName,
			p.Elevation,
			m.MountainRange
		FROM Countries AS c
		LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
		LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
		LEFT JOIN Peaks AS p ON m.Id = p.MountainId
		 ) AS CountriesPeaksSubquery
	 ) AS SecondSubquery
WHERE PeaksRank = 1
ORDER BY CountryName,
		 [Highest Peak Name]
