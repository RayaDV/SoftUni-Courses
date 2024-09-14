USE Gringotts
GO

-- 1. Records' Count
SELECT COUNT(*) AS Count
FROM WizzardDeposits

--2. Longest Magic Wand
SELECT MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits

--3. Longest Magic Wand Per Deposit Groups
SELECT DepositGroup, 
	   MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits
GROUP BY DepositGroup

--4. Smallest Deposit Group Per Magic Wand Size
SELECT TOP(2)
	DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)

--5. Deposits Sum
SELECT 
	DepositGroup,
	SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
GROUP BY DepositGroup

--6. Deposits Sum for Ollivander Family
SELECT
	DepositGroup,
	SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup

--7. Deposits Filter
SELECT
	DepositGroup,
	SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup
HAVING SUM(DepositAmount) < 150000
ORDER BY TotalSum DESC

--8.  Deposit Charge
SELECT
	DepositGroup,
	MagicWandCreator,
	MIN(DepositCharge) AS MinDepositCharge
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup

--9. Age Groups
SELECT
	AgeGroup,
	COUNT(*) AS WizardCount
FROM (
	SELECT
		CASE 
			WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
			WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
			WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
			WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
			WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
			WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
			ELSE '[61+]'
		END AS AgeGroup
	FROM WizzardDeposits
	 ) AS AgeGroupSubquery
GROUP BY AgeGroup 

--10. First Letter
SELECT
	LEFT(FirstName, 1) AS FirstLetter
FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
GROUP BY LEFT(FirstName, 1)
ORDER BY FirstLetter

--11. Average Interest 
SELECT
	DepositGroup,
	IsDepositExpired,
	AVG(DepositInterest) AS AverageInterest
FROM WizzardDeposits
WHERE DepositStartDate > '1985-01-01'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired

--12. *Rich Wizard, Poor Wizard
--METHOD 1 WITH JOIN
SELECT
	SUM([Difference]) AS SumDifference
FROM (
	SELECT
		h.FirstName AS [Host Wizard],
		h.DepositAmount AS [Host Wizard Deposit],
		g.FirstName AS [Guest Wizard],
		g.DepositAmount AS [Guest Wizard Deposit],
		h.DepositAmount - g.DepositAmount AS [Difference]
	FROM WizzardDeposits AS h
	JOIN WizzardDeposits AS g ON h.Id + 1 = g.Id
	 ) AS DifferencesSubquery

--METHOD 2 WITH LEAD()
SELECT
	SUM([Difference]) AS SumDifference
FROM (
	SELECT
		FirstName AS [Host Wizard],
		DepositAmount AS [Host Wizard Deposit],
		LEAD(FirstName) OVER(ORDER BY Id) AS [Guest Wizard],
		LEAD(DepositAmount) OVER(ORDER BY Id) AS [Guest Wizard Deposit],
		DepositAmount - LEAD(DepositAmount) OVER(ORDER BY Id) AS [Difference]
	FROM WizzardDeposits
	 ) AS DifferenceSubquery

USE SoftUni
GO

--13. Departments Total Salaries
SELECT
	DepartmentID,
	SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID

--14. Employees Minimum Salaries
SELECT
	DepartmentID,
	MIN(Salary) AS MinimumSalary
FROM Employees
WHERE DepartmentID IN (2, 5, 7) AND HireDate > 2000-01-01
GROUP BY DepartmentID
ORDER BY DepartmentID

--15. Employees Average Salaries

SELECT *
INTO EmployeesWithHigherSalaries
FROM Employees
WHERE Salary > 30000

DELETE FROM EmployeesWithHigherSalaries 
WHERE ManagerID = 42

UPDATE EmployeesWithHigherSalaries
SET Salary += 5000
WHERE DepartmentID = 1

SELECT
	DepartmentID,
	AVG(Salary) AS AverageSalary
FROM EmployeesWithHigherSalaries
GROUP BY DepartmentID

-------
--INSTEAD OF DELETE IN REAL WORLD
ALTER TABLE EmployeesWithHigherSalaries
        ADD IsDeleted BIT DEFAULT(0) NOT NULL

SELECT *
FROM EmployeesWithHigherSalaries

--DELETE ALL MANAGERID 3
UPDATE EmployeesWithHigherSalaries
SET IsDeleted = 1
WHERE ManagerID = 3

--SELECT ALL NON-DELETED EMPLOYEES
SELECT *
FROM EmployeesWithHigherSalaries
WHERE IsDeleted = 0
-------

--16. Employees Maximum Salaries
SELECT
	DepartmentID,
	MAX(Salary) AS MaxSalary
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

--17. Employees Count Salaries
SELECT
	COUNT(*) AS Count
FROM Employees
WHERE ManagerID IS NULL

--18. *3rd Highest Salary
SELECT DISTINCT
	DepartmentID,
	Salary AS ThirdHighestSalary
FROM (
	SELECT
		DepartmentID,
		Salary,
		DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS RankSalary
	FROM Employees
	 ) AS RankSubquery
WHERE RankSalary = 3
ORDER BY DepartmentID

--19. **Salary Challenge
SELECT TOP(10)
	FirstName,
	LastName,
	e.DepartmentId
FROM Employees AS e
JOIN (  SELECT 
			DepartmentID,
			AVG(Salary) AS AvgSalary
		FROM Employees
		GROUP BY DepartmentID
		       ) AS das
ON e.DepartmentID = das.DepartmentID
WHERE Salary > AvgSalary
ORDER BY e.DepartmentID

--SOLUTION WITHOUT JOIN
SELECT TOP(10)
	FirstName,
	LastName,
	e.DepartmentId
FROM Employees AS e
WHERE Salary > (
				 SELECT AVG(Salary) AS AvgSalary
				 FROM Employees AS eSub
				 WHERE eSub.DepartmentID = e.DepartmentID
				 GROUP BY DepartmentID
				)
ORDER BY e.DepartmentID

--METHOD 3
SELECT TOP(10)
	FirstName,
	LastName,
	DepartmentId
FROM (
		SELECT *,
			   AVG(Salary) OVER(PARTITION BY DepartmentID) AS AvgSalary
		FROM Employees
	 ) AS avs
WHERE avs.Salary > avs.AvgSalary
ORDER BY DepartmentID
