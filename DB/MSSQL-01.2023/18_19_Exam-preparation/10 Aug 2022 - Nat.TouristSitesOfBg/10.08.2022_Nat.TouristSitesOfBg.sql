CREATE DATABASE NationalTouristSitesOfBulgaria
GO
USE NationalTouristSitesOfBulgaria
GO

--Section 1. DDL (30 pts)
--1.	Database design
CREATE TABLE Categories (
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL
)
CREATE TABLE Locations (
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	Municipality VARCHAR(50),
	Province VARCHAR(50)
)
CREATE TABLE Sites (
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(100) NOT NULL,
	LocationId INT NOT NULL FOREIGN KEY REFERENCES Locations(Id),
	CategoryId INT NOT NULL FOREIGN KEY REFERENCES Categories(Id),
	Establishment VARCHAR(15)
)
CREATE TABLE Tourists (
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	Age INT NOT NULL CHECK (Age BETWEEN 0 AND 120),
	PhoneNumber VARCHAR(20) NOT NULL,
	Nationality VARCHAR(30) NOT NULL,
	Reward VARCHAR(20)
)
CREATE TABLE SitesTourists (
	TouristId INT NOT NULL FOREIGN KEY REFERENCES Tourists(Id),
	SiteId INT NOT NULL FOREIGN KEY REFERENCES Sites(Id),
	PRIMARY KEY (TouristId, SiteId)
)
CREATE TABLE BonusPrizes (
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL
)
CREATE TABLE TouristsBonusPrizes (
	TouristId INT NOT NULL FOREIGN KEY REFERENCES Tourists(Id),
	BonusPrizeId INT NOT NULL FOREIGN KEY REFERENCES BonusPrizes(Id),
	PRIMARY KEY (TouristId, BonusPrizeId)
)

--Section 2. DML (10 pts)
--2.	Insert
INSERT INTO Tourists
([Name], Age, PhoneNumber, Nationality, Reward)
VALUES
('Borislava Kazakova', 52, '+359896354244', 'Bulgaria', NULL),
('Peter Bosh', 48, '+447911844141', 'UK', NULL),
('Martin Smith', 29, '+353863818592', 'Ireland', 'Bronze badge'),
('Svilen Dobrev', 49, '+359986584786', 'Bulgaria', 'Silver badge'),
('Kremena Popova', 38, '+359893298604', 'Bulgaria', NULL)

INSERT INTO Sites
([Name], LocationId, CategoryId, Establishment)
VALUES
('Ustra fortress', 90, 7, 'X'),
('Karlanovo Pyramids', 65, 7, NULL),
('The Tomb of Tsar Sevt', 63, 8, 'V BC'),
('Sinite Kamani Natural Park', 17, 1, NULL),
('St. Petka of Bulgaria – Rupite', 92, 6, '1994')

--3.	Update
UPDATE Sites
SET Establishment = '(not defined)'
WHERE Establishment IS NULL

--4.	Delete
DELETE FROM TouristsBonusPrizes
WHERE BonusPrizeId = 5

DELETE FROM BonusPrizes
WHERE [Name] = 'Sleeping bag'


--Section 3. Querying (40 pts)
--5.	Tourists
SELECT
	[Name],
	Age,
	PhoneNumber,
	Nationality
FROM Tourists
ORDER BY Nationality,
		 Age DESC,
		 [Name]

--6.	Sites with Their Location and Category
SELECT
	s.[Name] AS [Site],
	l.[Name] AS [Location],
	s.Establishment,
	c.[Name] AS [Category]
FROM Sites AS s
JOIN Locations AS l ON s.LocationId = l.Id
JOIN Categories AS c ON s.CategoryId = c.Id
ORDER BY [Category] DESC,
		 [Location],
		 [Site]

--7.	Count of Sites in Sofia Province
SELECT
	l.Province,
	l.Municipality,
	l.[Name] AS [Location],
	COUNT(*) AS CountOfSites
FROM Locations AS l
JOIN Sites AS s ON l.Id = s.LocationId
WHERE Province = 'Sofia'
GROUP BY l.Province, l.Municipality, l.[Name]
ORDER BY CountOfSites DESC, [Location]

--8.	Tourist Sites established BC
SELECT
	s.[Name] AS [Site],
	l.[Name] AS [Location],
	l.Municipality,
	l.Province,
	s.Establishment
FROM Sites AS s
JOIN Locations AS l ON s.LocationId = l.Id
WHERE Establishment LIKE '%BC'
  AND SUBSTRING(l.[Name], 1, 1) NOT IN ('B', 'M', 'D')
ORDER BY [Site]

--9.	Tourists with their Bonus Prizes
SELECT
	t.[Name],
	Age,
	PhoneNumber,
	Nationality,
	ISNULL(b.[Name], '(no bonus prize)')  AS [Reward]
FROM Tourists AS t
LEFT JOIN TouristsBonusPrizes AS tb ON t.Id = tb.TouristId
LEFT JOIN BonusPrizes AS b ON tb.BonusPrizeId = b.Id
ORDER BY t.[Name]

--10.	Tourists visiting History and Archaeology sites
SELECT
	SUBSTRING(t.[Name], CHARINDEX(' ', t.[Name]) + 1, 50) AS LastName,
	Nationality,
	Age,
	PhoneNumber
FROM Tourists AS t
JOIN SitesTourists AS st ON st.TouristId = t.Id
JOIN Sites AS s ON st.SiteId = s.Id
JOIN Categories AS c ON c.Id = s.CategoryId
WHERE c.[Name] = 'History and archaeology'
GROUP BY t.[Name], Nationality, Age, PhoneNumber
ORDER BY LastName

--Section 4. Programmability (20 pts)
--11.	Tourists Count on a Tourist Site
GO
CREATE FUNCTION udf_GetTouristsCountOnATouristSite (@Site VARCHAR(100))
RETURNS INT
AS
BEGIN
	RETURN ( SELECT COUNT(t.Id)
			 FROM Sites AS s
			 LEFT JOIN SitesTourists AS st ON st.SiteId = s.Id
			 LEFT JOIN Tourists AS t ON st.TouristId = t.Id
			 WHERE s.[Name] = @Site
			 GROUP BY s.[Name]
		   )
END
GO

SELECT dbo.udf_GetTouristsCountOnATouristSite ('Regional History Museum – Vratsa')
SELECT dbo.udf_GetTouristsCountOnATouristSite ('Samuil’s Fortress')
SELECT dbo.udf_GetTouristsCountOnATouristSite ('Gorge of Erma River')
GO

--12.	Annual Reward Lottery
CREATE PROC usp_AnnualRewardLottery(@TouristName VARCHAR(50))
AS
BEGIN
	SELECT
		t.[Name],
		CASE
			WHEN COUNT(s.Id) >= 100 THEN 'Gold badge'
			WHEN COUNT(s.Id) >= 50 THEN 'Silver badge'
			WHEN COUNT(s.Id) >= 25 THEN 'Bronze badge'
			ELSE NULL
		END AS Reward
	FROM Tourists AS t
	LEFT JOIN SitesTourists AS st ON st.TouristId = t.Id
	LEFT JOIN Sites AS s ON s.Id = st.SiteId
	WHERE t.[Name] = @TouristName
	GROUP BY t.[Name]
END
GO

EXEC usp_AnnualRewardLottery 'Gerhild Lutgard'
EXEC usp_AnnualRewardLottery 'Teodor Petrov'
EXEC usp_AnnualRewardLottery 'Zac Walsh'
EXEC usp_AnnualRewardLottery 'Brus Brown'
GO