CREATE PROCEDURE [dbo].[sp_reindex] AS
DECLARE @ObjectName varchar(255)
DECLARE ObjectNames CURSOR
	FOR SELECT [name]
	FROM sysobjects
	WHERE Type = 'u'
OPEN ObjectNames
FETCH ObjectNames INTO @ObjectName
WHILE @@FETCH_STATUS = 0
	BEGIN
	PRINT @ObjectName 
	exec('DBCC DBREINDEX (''dbo.' + @ObjectName + ''','''',90)')
	FETCH ObjectNames INTO @ObjectName
END
CLOSE ObjectNames
DEALLOCATE ObjectNames

GO
GRANT CONTROL
    ON OBJECT::[dbo].[sp_reindex] TO [MSDSL]
    AS [dbo];

