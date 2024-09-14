CREATE DATABASE Zoo
GO

USE Zoo
GO

--Section 1. DDL (30 pts)
--1.	Database design
CREATE TABLE Owners
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	PhoneNumber VARCHAR(15) NOT NULL,
	[Address] VARCHAR(50)
)
CREATE TABLE AnimalTypes
(
	Id INT PRIMARY KEY IDENTITY,
	AnimalType VARCHAR(30) NOT NULL
)
CREATE TABLE Cages
(
	Id INT PRIMARY KEY IDENTITY,
	AnimalTypeId INT NOT NULL,
	CONSTRAINT FK_Cages_AnimalTypes FOREIGN KEY (AnimalTypeId) REFERENCES AnimalTypes(Id)
)
CREATE TABLE Animals
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(30) NOT NULL,
	BirthDate DATE NOT NULL,
	OwnerId INT, 
	CONSTRAINT FK_Animals_Owners FOREIGN KEY (OwnerId) REFERENCES Owners(Id),
	AnimalTypeId INT NOT NULL,
	CONSTRAINT FK_Animals_AnimalTypes FOREIGN KEY (AnimalTypeId) REFERENCES AnimalTypes(Id)
)
CREATE TABLE AnimalsCages
(
	CageId INT, 
	AnimalId INT,
	CONSTRAINT PK_AnimalsCages PRIMARY KEY (CageId, AnimalId),
	CONSTRAINT FK_PK_AnimalsCages_Cages FOREIGN KEY (CageId) REFERENCES Cages(Id),
	CONSTRAINT FK_PK_AnimalsCages_Animals FOREIGN KEY (AnimalId) REFERENCES Animals(Id)
)
CREATE TABLE VolunteersDepartments
(
	Id INT PRIMARY KEY IDENTITY,
	DepartmentName VARCHAR(30) NOT NULL
)
CREATE TABLE Volunteers
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	PhoneNumber VARCHAR(15) NOT NULL,
	[Address] VARCHAR(50),
	AnimalId INT, 
	CONSTRAINT FK_Volunteers_Animals FOREIGN KEY (AnimalId) REFERENCES Animals(Id),
	DepartmentId INT NOT NULL,
	CONSTRAINT FK_Volunteers_VolunteersDepartments FOREIGN KEY (DepartmentId) REFERENCES VolunteersDepartments(Id)
)

--Section 2. DML (10 pts)
--2.	Insert
INSERT INTO Volunteers
([Name], PhoneNumber, [Address], AnimalId, DepartmentId)
VALUES
('Anita Kostova', '0896365412', 'Sofia, 5 Rosa str.', 15, 1),
('Dimitur Stoev', '0877564223', NULL, 42, 4),
('Kalina Evtimova', '0896321112', 'Silistra, 21 Breza str.', 9, 7),
('Stoyan Tomov', '0898564100', 'Montana, 1 Bor str.', 18, 8),
('Boryana Mileva', '0888112233', NULL, 31, 5)

INSERT INTO Animals
([Name], BirthDate, OwnerId, AnimalTypeId)
VALUES
('Giraffe', '2018-09-21', 21, 1),
('Harpy Eagle', '2015-04-17', 15, 3),
('Hamadryas Baboon', '2017-11-02', NULL, 1),
('Tuatara', '2021-06-30', 2, 4)

--3.	Update

SELECT * 
FROM Animals
WHERE OwnerId IS NULL

UPDATE Animals
SET OwnerId = (SELECT Id
			   FROM Owners
			   WHERE [Name] = 'Kaloqn Stoqnov'
			  )
WHERE  OwnerId IS NULL

--4.	Delete 
DELETE FROM Volunteers
WHERE DepartmentId = (
		SELECT Id
		FROM VolunteersDepartments
		WHERE DepartmentName = 'Education program assistant'
					 )

DELETE FROM VolunteersDepartments
WHERE DepartmentName = 'Education program assistant'

--Section 3. Querying (40 pts)
--5.	Volunteers
SELECT
	[Name],
	PhoneNumber,
	[Address],
	AnimalId,
	DepartmentId
FROM Volunteers
ORDER BY [Name], AnimalId, DepartmentId
					
--6.	Animals data
SELECT
	a.[Name],
	atp.AnimalType,
	FORMAT(a.BirthDate, 'dd.MM.yyyy')
FROM Animals AS a
JOIN AnimalTypes AS atp ON a.AnimalTypeId = atp.Id
ORDER BY a.[Name]

--7.	Owners and Their Animals
SELECT
	o.[Name] AS [Owner],
	COUNT(*) AS CountOfAnimals
FROM Animals AS a
JOIN Owners AS o ON a.OwnerId = o.Id
GROUP BY o.[Name]
ORDER BY CountOfAnimals DESC, [Owner]

--DIFFERENCE BETWEEEN LEFT JOIN - THIS IS CORRECT!!! BECAUSE WE LOSE OWNERS WITH NO ANIMALS IN PREVIOUS SOLUTION
SELECT TOP(5)
	o.[Name] AS [Owner],
	COUNT(a.Id) AS CountOfAnimals
FROM Owners AS o 
LEFT JOIN Animals AS a ON a.OwnerId = o.Id
GROUP BY o.[Name]
ORDER BY CountOfAnimals DESC, [Owner]


--8.	Owners, Animals and Cages
SELECT
	CONCAT(o.[Name], '-', a.[Name]) AS OwnersAnimals,
	o.PhoneNumber,
	ac.CageId
FROM Owners AS o
JOIN Animals AS a ON a.OwnerId = o.Id
JOIN AnimalTypes AS atp ON a.AnimalTypeId = atp.Id
JOIN AnimalsCages AS ac ON a.Id = ac.AnimalId
WHERE atp.AnimalType = 'Mammals'
ORDER BY o.[Name], a.[Name] DESC

--9.	Volunteers in Sofia
--METHOD 1 WITH SUBQUERY
SELECT
	[Name],
	PhoneNumber,
	TRIM(SUBSTRING(LTRIM(SUBSTRING(LTRIM([Address]), 6, 50)), 2, 50)) AS [Address]
FROM Volunteers
WHERE DepartmentId = (SELECT Id
					  FROM VolunteersDepartments
					  WHERE DepartmentName = 'Education program assistant'
					 )
  AND LEFT(LTRIM([Address]), 5) = 'Sofia'
ORDER BY [Name]

--METHOD 2 WITH JOIN
SELECT
	v.[Name],
	v.PhoneNumber,
	TRIM(REPLACE(REPLACE(v.[Address], 'Sofia', ''), ',', '')) AS [Address]
FROM Volunteers AS v
LEFT JOIN VolunteersDepartments AS vd ON v.DepartmentId = vd.Id
WHERE vd.DepartmentName = 'Education program assistant'
  AND v.[Address] LIKE '%Sofia%'
ORDER BY v.[Name]

--METHOD 3
SELECT
	v.[Name],
	v.PhoneNumber,
	SUBSTRING(Address, CHARINDEX(',', Address) + 2, LEN(v.Address)) AS Address
FROM Volunteers AS v
LEFT JOIN VolunteersDepartments AS vd ON v.DepartmentId = vd.Id
WHERE vd.DepartmentName = 'Education program assistant'
  AND v.[Address] LIKE '%Sofia%'
ORDER BY v.[Name]

--10. Animals for Adoption
SELECT
	a.[Name],
	YEAR(a.BirthDate) AS BirthYear,
	AnimalType
FROM Animals AS a
JOIN AnimalTypes AS atp ON a.AnimalTypeId = atp.Id
WHERE OwnerId IS NULL
  AND DATEDIFF(YEAR, a.BirthDate, '2022-01-01') < 5 
  AND atp.AnimalType <> 'Birds'
ORDER BY a.[Name]

--Section 4. Programmability (20 pts)
--11.	All Volunteers in a Department
GO
CREATE FUNCTION udf_GetVolunteersCountFromADepartment (@VolunteersDepartment VARCHAR(30))
RETURNS INT
AS
BEGIN
	DECLARE @count INT = (
							SELECT
								COUNT(*)
							FROM Volunteers AS v
							JOIN VolunteersDepartments AS vd ON v.DepartmentId = vd.Id
							WHERE vd.DepartmentName = @VolunteersDepartment
							GROUP BY DepartmentId 
						  )
	RETURN @count;
END
GO

SELECT dbo.udf_GetVolunteersCountFromADepartment ('Education program assistant')
SELECT dbo.udf_GetVolunteersCountFromADepartment ('Guest engagement')
SELECT dbo.udf_GetVolunteersCountFromADepartment ('Zoo events')
GO

--12.	Animals with Owner or Not
CREATE PROC usp_AnimalsWithOwnersOrNot(@AnimalName VARCHAR(30))
AS
SELECT
	a.[Name],
	ISNULL(o.[Name], 'For adoption') AS OwnersName
FROM Animals AS a
LEFT JOIN Owners AS o ON a.OwnerId = o.Id
WHERE a.[Name] = @AnimalName

GO
EXEC usp_AnimalsWithOwnersOrNot 'Pumpkinseed Sunfish'
EXEC usp_AnimalsWithOwnersOrNot 'Hippo'
EXEC usp_AnimalsWithOwnersOrNot 'Brown bear'
GO
