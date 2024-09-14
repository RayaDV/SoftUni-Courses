CREATE DATABASE Relations

USE Relations
GO

-- 1.	One-To-One Relationship
CREATE TABLE Passports
(
	PassportID INT PRIMARY KEY IDENTITY(101, 1),
	PassportNumber VARCHAR(10) UNIQUE, NOT NULL
)

CREATE TABLE Persons 
(
	PersonID INT PRIMARY KEY IDENTITY, 
	FirstName VARCHAR(20) NOT NULL, 
	Salary DECIMAL(8, 2), -- общо 8 цифри, 2 от тях след запетаята; MONEY не е добре да се ползва;
	PassportID INT UNIQUE, 
	CONSTRAINT FK_Persons_Passports FOREIGN KEY (PassportID) REFERENCES Passports(PassportID)
)

--2.	One-To-Many Relationship
CREATE TABLE Manufacturers
(
	ManufacturerID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(20) NOT NULL, 
	EstablishedOn DATE
)

CREATE TABLE Models
(
	ModelID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(20) NOT NULL,
	ManufacturerID INT, 
	CONSTRAINT FK_Models_Manufacturers FOREIGN KEY (ManufacturerID) REFERENCES Manufacturers(ManufacturerID)
)

--3.	Many-To-Many Relationship
CREATE TABLE Students
(
	StudentID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(20) NOT NULL
)

CREATE TABLE Exams
(
	ExamID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50)
)

CREATE TABLE StudentsExams
(
	StudentID INT,
	ExamID INT,
	CONSTRAINT PK_StudentsExams PRIMARY KEY (StudentID, ExamID),
	CONSTRAINT FK_PK_StudentsExams_Students FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
	CONSTRAINT FK_StudentsExams_Exams FOREIGN KEY (ExamID) REFERENCES Exams(ExamID)
)

--4.	Self-Referencing 
CREATE TABLE Teachers
(
	TeacherID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	ManagerID INT,
	CONSTRAINT FK_Teachers FOREIGN KEY (ManagerID) REFERENCES Teachers(TeacherID)
)

--5.	Online Store Database
CREATE DATABASE OnlineStore
GO
USE OnlineStore
GO

CREATE TABLE Cities
(
	CityID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Customers
(
	CustomerID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	Birthday DATE,
	CityID INT,
	CONSTRAINT FK_Customers_Cities FOREIGN KEY (CityID) REFERENCES Cities(CityID)
)

CREATE TABLE Orders
(
	OrderID INT PRIMARY KEY IDENTITY,
	CustomerID INT,
	CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
)

CREATE TABLE ItemTypes
(
	ItemTypeID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50)
)

CREATE TABLE Items
(
	ItemID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50),
	ItemTypeID INT,
	CONSTRAINT FK_Items_ItemTypes FOREIGN KEY (ItemTypeID) REFERENCES ItemTypes(ItemTypeID)
)

CREATE TABLE OrderItems
(
	OrderID INT,
	ItemID INT,
	CONSTRAINT PK_OrderItems PRIMARY KEY (OrderID, ItemID),
	CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
	CONSTRAINT FK_OrderItems_Items FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
)

--6.	University Database
CREATE DATABASE University
GO
USE University
GO

CREATE TABLE Subjects
(
	SubjectID INT PRIMARY KEY IDENTITY,
	SubjectName VARCHAR(50)
)

CREATE TABLE Majors
(
	MajorID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50)
)

CREATE TABLE Students
(
	StudentID INT PRIMARY KEY IDENTITY,
	StudentNumber VARCHAR(50),
	StudentName VARCHAR(50),
	MajorID INT,
	CONSTRAINT FK_Students_Majors FOREIGN KEY (MajorID) REFERENCES Majors(MajorID)
)

CREATE TABLE Agenda
(
	StudentID INT,
	SubjectID INT, 
	CONSTRAINT PK_Agenda PRIMARY KEY (StudentID, SubjectID),
	CONSTRAINT FK_Agenda_Students FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
	CONSTRAINT FK_Agenda_Subjects FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
)

CREATE TABLE Payments
(
	PaymentID INT PRIMARY KEY IDENTITY, -- IN REAL PROJECTS WE WOULD USE GUID 
	PaymentDate DATE,					-- DATETIME2
	PaymentAmount MONEY,				-- DECIMAL(8, 2)
	StudentID INT,
	CONSTRAINT FK_Payments_Students FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
)

--7.	SoftUni Design
USE SoftUni
GO

--8.	Geography Design
USE Geography
GO

--9.	*Peaks in Rila
SELECT * FROM Peaks

SELECT m.MountainRange, p.PeakName, p.Elevation 
	FROM Mountains AS m
	JOIN Peaks AS p ON p.MountainId = m.Id AND m.MountainRange = 'Rila'
ORDER BY P.Elevation DESC