
----- Задание 1.1 -----

EXECUTE AS LOGIN = N'PC3810\Aleksey';

USE [master];
GO

RESTORE DATABASE [test] FROM DISK = N'C:\Test\test.bak' WITH
	MOVE N'test' TO N'C:\Test\task1.mdf',
	MOVE N'test_log' TO N'C:\Test\task1.ldf',
	REPLACE;
GO

USE [test];
GO

----- Задание 1.2 -----

EXEC sp_configure N'Show Advanced Options', 1;
RECONFIGURE WITH OVERRIDE;
GO
EXEC sp_configure N'Ad Hoc Distributed Queries', 1;
RECONFIGURE WITH OVERRIDE;
GO

EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1;
GO
EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1;
GO

MERGE [Users] AS [t]
USING (
SELECT
	PARSENAME(REPLACE(Name, ' ', '.'), 3) AS [LastName],
	PARSENAME(REPLACE(Name, ' ', '.'), 2) AS [FirstName],
	PARSENAME(REPLACE(Name, ' ', '.'), 1) AS [MiddleName],
	Login AS [Login]
FROM
	OPENROWSET(N'Microsoft.ACE.OLEDB.12.0', 
	N'Excel 12.0 Xml;Database=C:\Test\Users.xlsx;', [Лист1$])
) AS [s]
ON ([t].[Login] = [s].[Login])
WHEN MATCHED THEN
	UPDATE SET
		[LastName] = [s].[LastName],
		[FirstName] = [s].[FirstName],
		[MiddleName] = [s].[MiddleName]
WHEN NOT MATCHED THEN
	INSERT VALUES(
		NEWID(),
		[s].[LastName],
		[s].[FirstName],
		[s].[MiddleName],
		[s].[Login]);
GO

----- Задание 1.3 -----

CREATE TABLE [Depts]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Code] NVARCHAR(32) NOT NULL,
	[Name] NVARCHAR(256) NULL,
	[ParentID] INT NULL,
	CONSTRAINT [PK_Depts] PRIMARY KEY CLUSTERED ([ID]),
	CONSTRAINT [FK_ParentID] FOREIGN KEY ([ParentID])
		REFERENCES [Depts]([ID])
		ON DELETE NO ACTION /* Del_Depts trigger */
		ON UPDATE NO ACTION /* Upd_Depts trigger */
);
GO

ALTER TABLE [Users]
	ADD [DeptID] INT NULL,
	CONSTRAINT [FK_DeptID] FOREIGN KEY([DeptID])
		REFERENCES [Depts]([ID])
		ON DELETE SET NULL
		ON UPDATE CASCADE;
GO

BACKUP DATABASE [test] TO DISK = N'C:\Test\task1.bak';
GO

/*
-- Триггеры если требуется обеспечить целостность данных на уровне БД

CREATE TRIGGER [Del_Depts] ON [Depts]
INSTEAD OF DELETE AS
    SET NOCOUNT ON
	UPDATE [Depts] SET [ParentID] = NULL WHERE [ParentID] IN (SELECT [ID] FROM [deleted])
    DELETE FROM [Depts] WHERE [ID] IN (SELECT [ID] FROM [deleted]);
GO

CREATE TRIGGER [Upd_Depts] ON [Depts]
FOR UPDATE, INSERT AS
	SET NOCOUNT ON
    SELECT [ID], [ParentID] FROM [inserted] WHERE [ID] = [ParentID]
	IF @@ROWCOUNT > 0
	BEGIN
		RAISERROR(N'Reference on self', 11, 1)
		ROLLBACK
	END;
GO
*/
/*
-- Для COMPATIBILITY_LEVEL >= 130 (SQL Server 2016) в 1.2 в качестве источника

SELECT
  max(case when col = 1 then item else null end) as LastName,
  max(case when col = 2 then item else null end) as FirstName,
  max(case when col = 3 then item else null end) as MiddleName,
  Login
FROM (
  select t1.Login as Login, name.value as item,
         row_number() over (partition by t1.Login order by (select null)) as col
  from OPENROWSET('Microsoft.ACE.OLEDB.12.0',
  'Excel 12.0 Xml;Database=C:\Test\Users.xlsx;', [Лист1$]) as t1
  cross apply string_split(t1.Name, ' ') as name
) t
GROUP BY Login;
*/
