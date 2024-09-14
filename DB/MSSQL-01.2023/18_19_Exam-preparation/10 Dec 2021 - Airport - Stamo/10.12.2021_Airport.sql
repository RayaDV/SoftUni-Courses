CREATE DATABASE Airport
GO
USE Airport
GO

--Section 1. DDL (30 pts)
--1.	Database design
CREATE TABLE Passengers (
	Id INT PRIMARY KEY IDENTITY,
	FullName VARCHAR(100) NOT NULL,
	Email VARCHAR(50) NOT NULL
)
CREATE TABLE Pilots (
	Id INT PRIMARY KEY IDENTITY,
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	Age TINYINT NOT NULL CHECK (Age BETWEEN 21 AND 62),
	Rating FLOAT CHECK (Rating BETWEEN 0.0 AND 10.0)
)
CREATE TABLE AircraftTypes (
	Id INT PRIMARY KEY IDENTITY,
	TypeName VARCHAR(30) NOT NULL
)
CREATE TABLE Aircraft (
	Id INT PRIMARY KEY IDENTITY,
	Manufacturer VARCHAR(25) NOT NULL,
	Model VARCHAR(30) NOT NULL,
	[Year] INT NOT NULL,
	FlightHours INT,
	Condition CHAR NOT NULL,
	TypeId INT NOT NULL FOREIGN KEY REFERENCES AircraftTypes(Id)
)
CREATE TABLE PilotsAircraft (
	AircraftId INT FOREIGN KEY REFERENCES Aircraft(Id),
	PilotId INT FOREIGN KEY REFERENCES Pilots(Id),
	CONSTRAINT PK_PilotsAircraft PRIMARY KEY (AircraftId, PilotId)
)
CREATE TABLE Airports (
	Id INT PRIMARY KEY IDENTITY,
	AirportName VARCHAR(70) NOT NULL,
	Country VARCHAR(100) NOT NULL
)
CREATE TABLE FlightDestinations (
	Id INT PRIMARY KEY IDENTITY,
	AirportId INT NOT NULL FOREIGN KEY REFERENCES Airports(Id),
	[Start] DATETIME NOT NULL,
	AircraftId INT NOT NULL FOREIGN KEY REFERENCES Aircraft(Id),
	PassengerId INT NOT NULL FOREIGN KEY REFERENCES Passengers(Id),
	TicketPrice DECIMAL(18, 2) NOT NULL DEFAULT 15
)

--Section 2. DML (10 pts)
--2.	Insert
SELECT * FROM Passengers
SELECT * FROM Pilots

INSERT INTO Passengers
(FullName, Email)
SELECT
		CONCAT(FirstName, ' ', LastName) AS FullName,
		CONCAT(FirstName, LastName, '@gmail.com') AS Email 
	FROM Pilots
	WHERE Id BETWEEN 5 AND 15

--3.	Update
UPDATE Aircraft
SET Condition = 'A'
WHERE (Condition = 'C' OR Condition = 'B')
  AND (FlightHours IS NULL OR FlightHours <= 100)
  AND [Year] >= 2013

--4.	Delete
DELETE FROM FlightDestinations
WHERE PassengerId IN ( SELECT Id
					  FROM Passengers
					  WHERE LEN(FullName) <= 10
					)

DELETE FROM Passengers
WHERE LEN(FullName) <= 10

--Section 3. Querying (40 pts)
--5.	Aircraft
SELECT 
	Manufacturer,
	Model,
	FlightHours,
	Condition
FROM Aircraft
ORDER BY FlightHours DESC

--6.	Pilots and Aircraft
SELECT * FROM Aircraft
SELECT * FROM Pilots
SELECT 
	FirstName,
	LastName,
	Manufacturer,
	Model,
	FlightHours
FROM Pilots AS p
JOIN PilotsAircraft AS pa ON p.Id = pa.PilotId
JOIN Aircraft AS a ON pa.AircraftId = a.Id
WHERE FlightHours <= 304
ORDER BY FlightHours DESC, FirstName

--7.	Top 20 Flight Destinations
SELECT TOP(20)
	fd.Id AS DestinationId,
	fd.[Start],
	p.FullName,
	a.AirportName,
	fd.TicketPrice
FROM Passengers AS p
JOIN FlightDestinations AS fd ON fd.PassengerId = p.Id
JOIN Airports AS a ON fd.AirportId = a.Id
WHERE DAY([Start]) % 2 = 0
ORDER BY TicketPrice DESC, AirportName

--8.	Number of Flights for Each Aircraft
SELECT
	a.Id AS AircraftId,
	a.Manufacturer,
	a.FlightHours,
	COUNT(a.Id) AS FlightDestinationsCount,
	ROUND(AVG(fd.TicketPrice), 2) AS AvgPrice
FROM Aircraft AS a
JOIN FlightDestinations AS fd ON a.Id = fd.AircraftId
GROUP BY a.Id, a.Manufacturer, a.FlightHours
HAVING COUNT(a.Id) >= 2
ORDER BY FlightDestinationsCount DESC, AircraftId

--9.	Regular Passengers
SELECT
	FullName,
	COUNT(fd.AircraftId) AS CountOfAircraft,
	SUM(fd.TicketPrice) AS TotalPayed
FROM Passengers AS p
LEFT JOIN FlightDestinations AS fd ON p.Id = fd.PassengerId
WHERE FullName LIKE '_a%'
GROUP BY FullName
HAVING COUNT(fd.AircraftId) > 1
ORDER BY FullName

--10.	Full Info for Flight Destinations
--METHOD 1 FOR TIME
SELECT
	ap.AirportName,
	f.[Start] AS DayTime,
	f.TicketPrice,
	p.FullName,
	a.Manufacturer,
	a.Model
FROM FlightDestinations AS f
JOIN Airports AS ap ON f.AirportId = ap.Id
JOIN Passengers AS p ON f.PassengerId = p.Id
JOIN Aircraft AS a ON f.AircraftId = a.Id
WHERE (DATEPART(HOUR, [Start]) BETWEEN '6' AND '19')
   OR (DATEPART(HOUR, [Start]) = 20 AND DATEPART(MINUTE, [Start]) = 0 AND DATEPART(SECOND, [Start]) = 0)
  AND TicketPrice > 2500
ORDER BY a.Model

--METHOD 2 FOR TIME
SELECT
	ap.AirportName,
	f.[Start] AS DayTime,
	f.TicketPrice,
	p.FullName,
	a.Manufacturer,
	a.Model
FROM FlightDestinations AS f
JOIN Airports AS ap ON f.AirportId = ap.Id
JOIN Passengers AS p ON f.PassengerId = p.Id
JOIN Aircraft AS a ON f.AircraftId = a.Id
WHERE CAST(f.[Start] AS TIME) BETWEEN '06:00' AND '20:00'
  AND TicketPrice > 2500
ORDER BY a.Model

SELECT CAST(CONCAT(DATEPART(HOUR, [Start]), ':', DATEPART(MINUTE, [Start])) AS TIME)
FROM FlightDestinations

--Section 4. Programmability (20 pts)
--11.	Find all Destinations by Email Address
GO
CREATE FUNCTION udf_FlightDestinationsByEmail(@email VARCHAR(50)) 
RETURNS INT
AS
BEGIN
	RETURN ( SELECT COUNT(f.AircraftId)
			 FROM Passengers AS p
			 LEFT JOIN FlightDestinations AS f ON p.Id = f.PassengerId
			 WHERE Email = @email
			 GROUP BY Email
		   )
END
GO

SELECT dbo.udf_FlightDestinationsByEmail ('PierretteDunmuir@gmail.com')
SELECT dbo.udf_FlightDestinationsByEmail('Montacute@gmail.com')
SELECT dbo.udf_FlightDestinationsByEmail('MerisShale@gmail.com')
GO

--12.	Full Info for Airports
CREATE PROC usp_SearchByAirportName (@airportName VARCHAR(70))
AS
BEGIN
	SELECT
		ap.AirportName,
		p.FullName,
		CASE 
			WHEN TicketPrice <= 400 THEN 'Low'
			WHEN TicketPrice BETWEEN 401 AND 1500 THEN 'Medium'
			WHEN TicketPrice > 1500 THEN 'High'
		END AS LevelOfTickerPrice,
		a.Manufacturer,
		a.Condition,
		at.TypeName
	FROM Airports AS ap
	LEFT JOIN FlightDestinations AS f ON f.AirportId = ap.Id
	LEFT JOIN Passengers AS p ON p.Id = f.PassengerId
	LEFT JOIN Aircraft AS a ON a.Id = f.AircraftId
	LEFT JOIN AircraftTypes AS at ON at.Id = a.TypeId
	WHERE AirportName = @airportName
	ORDER BY Manufacturer, FullName
END
GO

EXEC usp_SearchByAirportName 'Sir Seretse Khama International Airport'
GO
