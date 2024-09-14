--DROP DATABASE Minions

-- 1 --
CREATE DATABASE [Minions]

USE [Minions]

-- 2 --
-- Minions (Id, Name, Age)
CREATE TABLE Minions
(
	[Id] INT PRIMARY KEY,
	[Name] VARCHAR(100),
	[Age] INT
)
-- Towns (Id, Name)
CREATE TABLE Towns
(
	[Id] INT PRIMARY KEY,
	[Name] VARCHAR(100)
)

-- 3 --
ALTER TABLE Minions
ADD [TownId] INT FOREIGN KEY REFERENCES Towns(Id);

-- 4 --
INSERT INTO Towns
VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna')

INSERT INTO Minions
VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2)

-- 5 --
TRUNCATE TABLE Minions

SELECT * FROM Minions

-- 6 --
DROP TABLE Minions
DROP TABLE [Minions].[dbo].[Towns]

-- 7 --
CREATE TABLE People
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(200) NOT NULL,
	Picture VARBINARY(MAX),
	Height FLOAT,
	[Weight] FLOAT,
	Gender CHAR(1) NOT NULL,
	Birthdate DATE NOT NULL,
	Biography NVARCHAR(MAX)
)

INSERT INTO People
([Name], Gender, Birthdate)
VALUES 
('Viktor', 'm', '1990-02-12'),
('Raya', 'f', '1988-05-25'),
('Simeon', 'm', '2020-03-06'),
('Viktoria', 'f', '2022-03-04'),
('Neli', 'f', '1959-12-06');

SELECT * FROM People

DROP TABLE People

-- 8 --
--•	Id – unique number for every user. There will be no more than 263-1 users (auto incremented).
--•	Username – unique identifier of the user. It will be no more than 30 characters (non Unicode)  (required).
--•	Password – password will be no longer than 26 characters (non Unicode) (required).
--•	ProfilePicture – image with size up to 900 KB. 
--•	LastLoginTime
--•	IsDeleted – shows if the user deleted his/her profile. Possible states are true or false.
CREATE TABLE Users
(
	Id BIGINT PRIMARY KEY IDENTITY,
	Username VARCHAR(30) NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(MAX) CHECK(LEN(ProfilePicture) >= 900000),
	LastLoginTime DATETIME2,
	IsDeleted BIT NOT NULL
)

INSERT INTO Users
(Username, [Password], IsDeleted)
VALUES
('Viktor', 'Vik90', 1),
('Raya', 'Raya88', 1),
('Neli', 'Neli59', 0),
('Moni', 'Moni20', 0),
('Viktoria', 'Vik22', 0);

SELECT * FROM Users

-- 9 --
ALTER TABLE Users 
DROP CONSTRAINT PK__Users__3214EC077A3C1A0C;

ALTER TABLE Users 
ADD CONSTRAINT PK_IdUsername PRIMARY KEY (Id, Username);

-- 10 --
ALTER TABLE Users
ADD CONSTRAINT CHK_PasswordLen CHECK (LEN(Password) >= 5);

-- 11 --
ALTER TABLE Users
ADD CONSTRAINT DF_LastLoginTime DEFAULT GETDATE() FOR [LastLoginTime];
INSERT INTO Users
(Username, [Password], IsDeleted)
VALUES
('Ivan3', '123453', 1);

SELECT * FROM Users;

-- 12 --
ALTER TABLE Users 
DROP CONSTRAINT PK_IdUsername;
ALTER TABLE Users
ADD CONSTRAINT PK_Id PRIMARY KEY (Id);
ALTER TABLE Users
ADD CONSTRAINT CHK_UsernameLen CHECK (LEN(Username) >= 3);
ALTER TABLE Users
ADD CONSTRAINT UQ_Username UNIQUE (Username);

SELECT * FROM Users;

-- 13 --
CREATE DATABASE Movies
USE Movies

--•	Directors (Id, DirectorName, Notes)
CREATE TABLE Directors
(
	Id INT PRIMARY KEY IDENTITY,
	DirectorName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(200)
)
--•	Genres (Id, GenreName, Notes)
CREATE TABLE Genres
(
	Id INT PRIMARY KEY IDENTITY,
	GenreName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(200)
)
--•	Categories (Id, CategoryName, Notes)
CREATE TABLE Categories
(
	Id INT PRIMARY KEY IDENTITY,
	CategoryName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(200)
)
--•	Movies (Id, Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes)
CREATE TABLE Movies
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) NOT NULL,
	DirectorId INT FOREIGN KEY REFERENCES Directors(Id) NOT NULL,
	CopyrightYear CHAR(4) NOT NULL, 
	[Length] SMALLINT NOT NULL,
	GenreId INT FOREIGN KEY REFERENCES Genres(Id) NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	Rating TINYINT,
	Notes NVARCHAR(200)
)

INSERT INTO Directors (DirectorName)
VALUES
('Виктор Величков'),
('Рая Величкова'),
('Нели Димитрова'),
('Симеон Величков'),
('Виктория Величкова')

INSERT INTO Genres (GenreName)
VALUES
('комедия'),
('драма'),
('екшън'),
('романтика'),
('фантастика')

INSERT INTO Categories (CategoryName)
VALUES
('документален'),
('късометражен'),
('игрален'),
('анимация'),
('театрален')

INSERT INTO Movies 
(Title, DirectorId, CopyrightYear, [Length], GenreId, CategoryId)
VALUES
('Безвремие', 4, '2018', 20, 5, 2),
('Човек на име Уве', 2, '2019', 140, 2, 3),
('Таралежите', 3, '2020', 100, 2, 1),
('Спящата красавица', 5, '2022', 110, 1, 4),
('Непобедимите', 1, '2016', 150, 3, 3)

SELECT * FROM Directors
SELECT * FROM Genres
SELECT * FROM Categories
SELECT * FROM Movies

DROP TABLE Movies


-- 15 --
CREATE DATABASE Hotel
USE Hotel

--•	Employees (Id, FirstName, LastName, Title, Notes)
CREATE TABLE Employees
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	Title NVARCHAR(50),
	Notes NVARCHAR(100)
)
INSERT INTO Employees (FirstName, LastName)
VALUES
('Рая', 'Величкова'),
('Виктор', 'Величков'),
('Нели', 'Димитрова')
--SELECT * FROM Employees

--•	Customers (AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes)
CREATE TABLE Customers
(
	AccountNumber VARCHAR(20) PRIMARY KEY NOT NULL,
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	PhoneNumber VARCHAR(20),
	EmergencyName NVARCHAR(20),
	EmergencyNumber VARCHAR(20),
	Notes NVARCHAR(100)
)
--DROP TABLE Customers
INSERT INTO Customers (AccountNumber, FirstName, LastName)
VALUES
('VIKI','Виктория', 'Величкова'),
('MONI', 'Симеон', 'Величков'),
('LORA', 'Лора', 'Славова')
--SELECT * FROM Customers

--•	RoomStatus (RoomStatus, Notes)
CREATE TABLE RoomStatus
(
	RoomStatus VARCHAR(10) PRIMARY KEY,
	Notes NVARCHAR(100)
)
INSERT INTO RoomStatus (RoomStatus)
VALUES
('RSV'),
('OCC'),
('AVL')
--SELECT * FROM RoomStatus

--•	RoomTypes (RoomType, Notes)
CREATE TABLE RoomTypes
(
	RoomType VARCHAR(10) PRIMARY KEY,
	Notes NVARCHAR(100)
)
INSERT INTO RoomTypes (RoomType)
VALUES
('DOUBLE'),
('STUDIO'),
('APP')
--SELECT * FROM RoomTypes

--•	BedTypes (BedType, Notes)
CREATE TABLE BedTypes
(
	BedType VARCHAR(10) PRIMARY KEY,
	Notes NVARCHAR(100)
)
INSERT INTO BedTypes (BedType)
VALUES
('QUEEN'),
('KING'),
('TWIN')
--SELECT * FROM BedTypes

--•	Rooms (RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes)
CREATE TABLE Rooms
(
	RoomNumber INT PRIMARY KEY IDENTITY,
	RoomType VARCHAR(10) FOREIGN KEY REFERENCES RoomTypes(RoomType) NOT NULL,
	BedType VARCHAR(10) FOREIGN KEY REFERENCES BedTypes(BedType) NOT NULL,
	Rate TINYINT,
	RoomStatus VARCHAR(10) FOREIGN KEY REFERENCES RoomStatus(RoomStatus) NOT NULL,
	Notes NVARCHAR(100)
)
INSERT INTO Rooms (RoomType, BedType, RoomStatus)
VALUES
('APP','KING', 'RSV'),
('STUDIO', 'QUEEN', 'OCC'),
('DOUBLE', 'TWIN', 'AVL')
--SELECT * FROM Rooms

--•	Payments (Id, EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes)
CREATE TABLE Payments
(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	PaymentDate DATETIME2 NOT NULL,
	AccountNumber VARCHAR(20) FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL,
	FirstDateOccupied DATE,
	LastDateOccupied DATE,
	TotalDays SMALLINT NOT NULL,
	AmountCharged MONEY,
	TaxRate TINYINT DEFAULT 20,
	TaxAmount MONEY,
	PaymentTotal MONEY,
	Notes NVARCHAR(100)
);
--DROP TABLE Payments;
INSERT INTO Payments (EmployeeId, PaymentDate, AccountNumber, TotalDays)
VALUES
(1, '2022-03-16','LORA', 1),
(2, '2020-03-06', 'MONI', 2),
(3, '2022-03-04', 'VIKI', 3);
--SELECT * FROM Payments;

--•	Occupancies (Id, EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes)
CREATE TABLE Occupancies
(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	DateOccupied DATE NOT NULL,
	AccountNumber VARCHAR(20) FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL,
	RoomNumber INT NOT NULL,
	RateApplied TINYINT,
	PhoneCharge MONEY,
	Notes NVARCHAR(100)
)
--DROP TABLE Occupancies
INSERT INTO Occupancies (EmployeeId, DateOccupied, AccountNumber, RoomNumber)
VALUES
(1, '2022-03-16','LORA', 1),
(2, '2020-03-06', 'MONI', 2),
(3, '2022-03-04', 'VIKI', 3);
--SELECT * FROM Occupancies;

-- 14 --
CREATE DATABASE CarRental
USE CarRental

--•	Categories (Id, CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
CREATE TABLE Categories
(
	Id INT PRIMARY KEY IDENTITY,
	CategoryName NVARCHAR(20) NOT NULL,
	DailyRate TINYINT,
	WeeklyRate TINYINT,
	MonthlyRate TINYINT,
	WeekendRate TINYINT
)
INSERT INTO Categories (CategoryName)
VALUES
('Лек автомобил'),
('Джип'),
('Ван');
--SELECT * FROM Categories;

--•	Cars (Id, PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)
CREATE TABLE Cars
(
	Id INT PRIMARY KEY IDENTITY,
	PlateNumber VARCHAR(10) NOT NULL,
	Manufacturer VARCHAR(20),
	Model VARCHAR(20),
	CarYear CHAR(4),
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	Doors CHAR(2),
	Picture VARBINARY(MAX),
	Condition NVARCHAR(20),
	Available BIT NOT NULL
)
INSERT INTO Cars 
(PlateNumber, CategoryId, Available)
VALUES
('123RA', 1, 0),
('456VI', 2, 1),
('789NE', 3, 0);
--SELECT * FROM Cars;

--•	Employees (Id, FirstName, LastName, Title, Notes)
CREATE TABLE Employees
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	Title NVARCHAR(20),
	Notes NVARCHAR(100)
)
INSERT INTO Employees 
(FirstName, LastName)
VALUES
('Рая', 'Величкова'),
('Виктор', 'Величков'),
('Нели', 'Димитрова')
--SELECT * FROM Employees;

--•	Customers (Id, DriverLicenceNumber, FullName, Address, City, ZIPCode, Notes)
CREATE TABLE Customers
(
	Id INT PRIMARY KEY IDENTITY,
	DriverLicenceNumber VARCHAR(10) NOT NULL,
	FullName NVARCHAR(40) NOT NULL,
	[Address] NVARCHAR(100),
	City NVARCHAR(20),
	Notes NVARCHAR(100)
)
INSERT INTO Customers (DriverLicenceNumber, FullName)
VALUES
('VIKI22','Виктория Величкова'),
('MONI20', 'Симеон Величков'),
('LORA22', 'Лора Славова')
--SELECT * FROM Customers

--•	RentalOrders (Id, EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes)
CREATE TABLE RentalOrders 
(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	CustomerId INT FOREIGN KEY REFERENCES Customers(Id) NOT NULL,
	CarId INT FOREIGN KEY REFERENCES Cars(Id) NOT NULL,
	TankLevel TINYINT,
	KilometrageStart INT,
	KilometrageEnd INT,
	TotalKilometrage INT NOT NULL,
	StartDate DATE,
	EndDate DATE,
	TotalDays TINYINT NOT NULL,
	RateApplied TINYINT,
	TaxRate TINYINT,
	OrderStatus VARCHAR(10),
	Notes NVARCHAR(100)
)
INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, TotalKilometrage, TotalDays)
VALUES
(1, 1, 1, 100, 1),
(2, 2, 2, 200, 2),
(3, 3, 3, 300, 3)
--SELECT * FROM RentalOrders;

-- 16 --
CREATE DATABASE SoftUni
USE SoftUni

--•	Towns (Id, Name)
CREATE TABLE Towns
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL
)

--•	Addresses (Id, AddressText, TownId)
CREATE TABLE Addresses
(
	Id INT PRIMARY KEY IDENTITY,
	AddressText NVARCHAR(100) NOT NULL,
	TownId INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL
)

--•	Departments (Id, Name)
CREATE TABLE Departments
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL
)

--•	Employees (Id, FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary, AddressId)
CREATE TABLE Employees
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(20) NOT NULL,
	MiddleName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	JobTitle NVARCHAR(50),
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id) NOT NULL,
	HireDate DATE,
	Salary MONEY NOT NULL,
	AddressId INT FOREIGN KEY REFERENCES Addresses(Id)
)
DROP TABLE Employees

-- 18 --
--•	Towns: Sofia, Plovdiv, Varna, Burgas
INSERT INTO Towns ([Name])
VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas')

--•	Departments: Engineering, Sales, Marketing, Software Development, Quality Assurance
INSERT INTO Departments ([Name])
VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance')

--Ivan Ivanov Ivanov	.NET Developer	Software Development	01/02/2013	3500.00
--Petar Petrov Petrov	Senior Engineer	Engineering				02/03/2004	4000.00
--Maria Petrova Ivanova	Intern			Quality Assurance		28/08/2016	525.25
--Georgi Teziev Ivanov	CEO				Sales					09/12/2007	3000.00
--Peter Pan Pan			Intern			Marketing				28/08/2016	599.88
INSERT INTO Employees
(FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary)
VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88)

-- 19 --
SELECT * FROM Towns
SELECT * FROM Departments
SELECT * FROM Employees

-- 20 --
SELECT * FROM Towns ORDER BY [Name]
SELECT * FROM Departments ORDER BY [Name]
SELECT * FROM Employees ORDER BY Salary DESC

-- 21 --
SELECT [Name] FROM Towns ORDER BY [Name]
SELECT [Name] FROM Departments ORDER BY [Name]
SELECT FirstName, LastName, JobTitle, Salary FROM Employees ORDER BY Salary DESC

-- 22 --
UPDATE Employees SET Salary = Salary * 1.1
SELECT Salary FROM Employees

-- 23 --
USE Hotel

-- 24 --
USE Hotel
DELETE FROM Occupancies
SELECT * FROM Occupancies