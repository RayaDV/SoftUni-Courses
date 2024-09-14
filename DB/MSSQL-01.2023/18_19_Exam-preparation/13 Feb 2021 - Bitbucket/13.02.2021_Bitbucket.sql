CREATE DATABASE Bitbucket
GO
USE Bitbucket
GO

--Section 1. DDL (30 pts)
--1.	Database Design
CREATE TABLE Users (
	Id INT PRIMARY KEY IDENTITY,
	Username VARCHAR(30) NOT NULL,
	[Password] VARCHAR(30) NOT NULL,
	Email VARCHAR(50) NOT NULL
)
CREATE TABLE Repositories (
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL
)
CREATE TABLE RepositoriesContributors (
	RepositoryId INT NOT NULL FOREIGN KEY REFERENCES Repositories(Id),
	ContributorId INT NOT NULL FOREIGN KEY REFERENCES Users(Id),
	PRIMARY KEY (RepositoryId, ContributorId)
)
CREATE TABLE Issues (
	Id INT PRIMARY KEY IDENTITY,
	Title VARCHAR(255) NOT NULL,
	IssueStatus VARCHAR(6) NOT NULL,
	RepositoryId INT NOT NULL FOREIGN KEY REFERENCES Repositories(Id),
	AssigneeId INT NOT NULL FOREIGN KEY REFERENCES Users(Id),
)
CREATE TABLE Commits (
	Id INT PRIMARY KEY IDENTITY,
	[Message] VARCHAR(255) NOT NULL,
	IssueId INT FOREIGN KEY REFERENCES Issues(Id),
	RepositoryId INT NOT NULL FOREIGN KEY REFERENCES Repositories(Id),
	ContributorId INT NOT NULL FOREIGN KEY REFERENCES Users(Id)
)
CREATE TABLE Files (
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(100) NOT NULL,
	Size DECIMAL(18, 2) NOT NULL,
	ParentId INT FOREIGN KEY REFERENCES Files(Id),
	CommitId INT NOT NULL FOREIGN KEY REFERENCES Commits(Id)
)

--Section 2. DML (10 pts)
--2.	Insert
INSERT INTO Files
([Name], Size, ParentId, CommitId)
VALUES
('Trade.idk', 2598.0, 1, 1),
('menu.net', 9238.31, 2, 2),
('Administrate.soshy', 1246.93, 3, 3),
('Controller.php', 7353.15, 4, 4),
('Find.java', 9957.86, 5, 5),
('Controller.json', 14034.87, 3, 6),
('Operate.xix', 7662.92, 7, 7)

INSERT INTO Issues
(Title, IssueStatus, RepositoryId, AssigneeId)
VALUES
('Critical Problem with HomeController.cs file', 'open', 1, 4),
('Typo fix in Judge.html', 'open', 4, 3),
('Implement documentation for UsersService.cs', 'closed', 8, 2),
('Unreachable code in Index.cs', 'open', 9, 8)

--3.	Update
UPDATE Issues
SET IssueStatus = 'closed'
WHERE AssigneeId = 6 AND IssueStatus <> 'closed'

--4.	Delete
DELETE FROM RepositoriesContributors
WHERE RepositoryId = (SELECT Id FROM Repositories
					  WHERE [Name] = 'Softuni-Teamwork')
DELETE FROM Issues
WHERE RepositoryId = (SELECT Id FROM Repositories
					  WHERE [Name] = 'Softuni-Teamwork')

--Section 3. Querying (40 pts)
--5.	Commits
SELECT
	Id,
	[Message],
	RepositoryId,
	ContributorId
FROM Commits
ORDER BY
	Id,
	[Message],
	RepositoryId,
	ContributorId

--6.	Front-end
SELECT 
	Id,
	[Name],
	Size
FROM Files
WHERE Size > 1000
  AND [Name] LIKE '%html%'
ORDER BY Size DESC,
		 Id, [Name]

--7.	Issue Assignment
SELECT 
	i.Id,
	CONCAT(u.Username, ' : ', i.Title) AS IssueAssignee
FROM Issues AS i
JOIN Users AS u ON u.Id = i.AssigneeId
ORDER BY i.Id DESC,
		 IssueAssignee

--8.	Single Files
SELECT 
	Id,
	[Name],
	CONCAT(Size, 'KB') AS Size
FROM Files
WHERE Id NOT IN (SELECT ParentId FROM Files
				 WHERE ParentId IS NOT NULL)
ORDER BY Id, [Name], Size DESC

--9.	Commits in Repositories
SELECT TOP(5)
	r.Id,
	r.[Name],
	COUNT(c.Id) AS Commits
FROM Commits AS c
JOIN Repositories AS r ON c.RepositoryId = r.Id
JOIN RepositoriesContributors AS rc ON rc.RepositoryId = r.Id
GROUP BY r.Id, r.[Name]
ORDER BY COUNT(c.Id) DESC, r.Id, r.[Name]

SELECT *
FROM Commits AS c
JOIN Repositories AS r ON c.RepositoryId = r.Id
JOIN RepositoriesContributors AS rc ON rc.RepositoryId = r.Id


--10.	Average Size
SELECT
	Username,
	AVG(Size) AS Size
FROM Files AS f
LEFT JOIN Commits AS c ON f.CommitId = c.Id
LEFT JOIN Users AS u ON c.ContributorId = u.Id
GROUP BY Username
ORDER BY AVG(Size) DESC,
		 Username

--Section 4. Programmability (20 pts)
--11.	All User Commits
GO
CREATE FUNCTION udf_AllUserCommits(@username VARCHAR(30))
        RETURNS INT
             AS
             BEGIN
                   DECLARE @commitCount INT = 0
                       SET @commitCount =
                                           (SELECT COUNT(c.Id)
                                              FROM Users u
                                              LEFT JOIN Commits c ON u.Id = c.ContributorId
                                              WHERE u.Username = @username
                                              GROUP BY u.Username
                                            ) 
                    IF @commitCount IS NULL
                     SET @commitCount = 0
                    
                   RETURN @commitCount
               END 

SELECT dbo.udf_AllUserCommits('UnderSinduxrein')
GO

--12.	 Search for Files
CREATE PROC usp_SearchForFiles(@fileExtension VARCHAR(100))
AS
BEGIN
	SELECT 
		Id,
		[Name],
		CONCAT(Size, 'KB') AS Size
	FROM Files
	WHERE RIGHT([Name], LEN(@fileExtension)) = @fileExtension
	ORDER BY Id, [Name], Size DESC
END
GO

EXEC usp_SearchForFiles 'txt'
GO
