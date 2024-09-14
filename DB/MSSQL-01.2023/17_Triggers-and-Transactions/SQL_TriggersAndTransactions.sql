USE Bank
GO

--1.	Create Table Logs
CREATE TABLE Logs (
	LogId INT PRIMARY KEY IDENTITY,
	AccountId INT,
	OldSum MONEY,
	NewSum MONEY
				  )
GO

CREATE TRIGGER tr_AddToLogsOnAccountsUpdate
ON Accounts FOR UPDATE
AS
INSERT INTO Logs(AccountId, OldSum, NewSum)
SELECT
	i.AccountHolderId,
	d.Balance,
	i.Balance
FROM inserted AS i
JOIN deleted AS d ON i.Id = d.Id
WHERE i.Balance <> d.Balance
GO

SELECT * FROM Accounts

BEGIN TRANSACTION

UPDATE Accounts
SET Balance = 114.12
WHERE Id = 1

SELECT * FROM Logs
SELECT * FROM NotificationEmails

ROLLBACK

--2.	Create Table Emails
CREATE TABLE NotificationEmails (
	Id INT PRIMARY KEY IDENTITY,
	Recipient INT,
	[Subject] VARCHAR(50),
	Body VARCHAR(100)
	)
GO
CREATE TRIGGER tr_AddToEmailsOnLogsInsert
ON Logs FOR INSERT
AS 
INSERT INTO NotificationEmails(Recipient, [Subject], Body)
SELECT
	AccountId,
	CONCAT('Balance change for account: ', AccountId),
	CONCAT('On ', GETDATE(), ' your balance was changed from ', OldSum, ' to ', NewSum)
FROM Logs

GO

--3.	Deposit Money
CREATE PROC usp_DepositMoney(@accountId INT, @moneyAmount MONEY) 
AS
IF @moneyAmount <= 0
BEGIN
	RETURN
END
BEGIN TRANSACTION
UPDATE Accounts
SET Balance += ROUND(@moneyAmount,4)
WHERE Id = @accountId
COMMIT
GO

EXEC usp_DepositMoney 1, 10.123456
GO
SELECT * FROM Accounts AS a
WHERE Id = 1
GO

--4.	Withdraw Money Procedure
CREATE PROC usp_WithdrawMoney (@accountId INT, @moneyAmount MONEY) 
AS
IF @moneyAmount <= 0
BEGIN
	RETURN
END
BEGIN TRANSACTION
UPDATE Accounts
SET Balance -= ROUND(@moneyAmount, 4)
WHERE Id = @accountId
COMMIT 
GO

EXEC usp_WithdrawMoney 5, 25
GO
SELECT * FROM Accounts
WHERE Id = 5
GO

--5.	Money Transfer
CREATE PROC usp_TransferMoney(@senderId INT, @receiverId INT, @amount MONEY)
AS
BEGIN TRANSACTION
EXEC dbo.usp_DepositMoney @receiverId, @amount
EXEC dbo.usp_WithdrawMoney @senderId, @amount
COMMIT

EXEC usp_TransferMoney 5, 1, 5000
GO
SELECT * FROM Accounts
WHERE Id = 5 OR Id = 1
GO

USE Diablo
GO
--6.	Trigger

--7.	*Massive Shopping
DECLARE @userID INT = (SELECT Id FROM Users WHERE Username = 'Stamat');
DECLARE @gameID INT = (SELECT Id FROM Games WHERE [Name] = 'Safflower');
DECLARE @userGameID INT = (SELECT Id FROM UsersGames WHERE UserId = @userID AND GameId = @gameID);
DECLARE @userCash MONEY = (SELECT Cash FROM UsersGames WHERE Id = @userGameID AND UserId = @userID AND GameId = @gameID);
DECLARE @itemCashTotal MONEY;
 
BEGIN TRANSACTION
    SET @itemCashTotal = (SELECT SUM(Price) FROM Items WHERE MinLevel BETWEEN 11 AND 12);
    
    IF(@userCash - @itemCashTotal >= 0)
    BEGIN
        INSERT INTO UserGameItems(ItemId, UserGameId)
        SELECT Id, @userGameID
            FROM Items
            WHERE MinLevel BETWEEN 11 AND 12
 
            UPDATE UsersGames
            SET Cash -= @itemCashTotal
            WHERE Id = @userGameID;
 
            COMMIT
    END
    --ELSE
    --BEGIN
    --  ROLLBACK
    --END
 
SET @userCash = (SELECT Cash FROM UsersGames WHERE Id = @userGameID);
 
BEGIN TRANSACTION
    SET @itemCashTotal = (SELECT SUM(Price) FROM Items WHERE MinLevel BETWEEN 19 AND 21);
    
    IF(@userCash - @itemCashTotal >= 0)
    BEGIN
        INSERT INTO UserGameItems(ItemId, UserGameId)
        SELECT Id, @userGameID
            FROM Items
            WHERE MinLevel BETWEEN 19 AND 21
 
            UPDATE UsersGames
            SET Cash -= @itemCashTotal
            WHERE Id = @userGameID;
 
            COMMIT
    END
    --ELSE
    --BEGIN
    --  ROLLBACK
    --END
 
SELECT [Name] AS [Item Name]
FROM Items
WHERE Id IN (SELECT ItemId FROM UserGameItems WHERE UserGameId = @userGameID)
ORDER BY [Name]

USE SoftUni
GO

--8.	Employees with Three Projects
CREATE PROC usp_AssignProject(@emloyeeId INT, @projectID INT)
AS
BEGIN
	BEGIN TRANSACTION
	IF @emloyeeId NOT IN (SELECT EmployeeID FROM Employees)
	BEGIN
		ROLLBACK
		RAISERROR ('EmloyeeId not exist!', 16, 1)
		RETURN
	END
	IF @projectID NOT IN (SELECT ProjectID FROM Projects)
	BEGIN
		ROLLBACK
		RAISERROR ('ProjectId not exist!', 16, 1)
		RETURN
	END

	DECLARE @employeeIdProjectsCount INT = ( SELECT COUNT(ProjectId)
											 FROM EmployeesProjects
											 WHERE EmployeeID = @emloyeeId
											 GROUP BY EmployeeID 
										   )
	IF @employeeIdProjectsCount > 3
	BEGIN
		ROLLBACK
		RAISERROR ('The employee has too many projects!', 16, 1)
		RETURN
	END

	IF @projectID IN (SELECT ProjectID FROM EmployeesProjects WHERE EmployeeID = @emloyeeId)
	BEGIN
		ROLLBACK
		RAISERROR ('The employee has already been assigned to this project!', 16, 1)
		RETURN
	END

	INSERT INTO EmployeesProjects
	VALUES
	(@emloyeeId, @projectID)
	COMMIT
END
GO

SELECT 
EmployeeID,
COUNT(ProjectId)
FROM EmployeesProjects
GROUP BY EmployeeID 

SELECT 
EmployeeID,
ProjectId
FROM EmployeesProjects
WHERE EmployeeID = 227

EXEC usp_AssignProject 1, 38

