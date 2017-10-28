Create Procedure cfpSolomonAppDefrag

AS

--Script to automatically reindex all tables in a database 

--USE SolomonApp --Enter the name of the database you want to reindex 

DECLARE @TableName varchar(255) 

Set @TableName='SolomonApp'

DECLARE TableCursor CURSOR FOR 
SELECT table_name FROM information_schema.tables 
WHERE table_type = 'base table' 

OPEN TableCursor 

FETCH NEXT FROM TableCursor INTO @TableName 
WHILE @@FETCH_STATUS = 0 
BEGIN 
PRINT 'Reindexing ' + @TableName 
DBCC DBREINDEX(@TableName,' ',90) 
FETCH NEXT FROM TableCursor INTO @TableName 
END 

CLOSE TableCursor 

DEALLOCATE TableCursor


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpSolomonAppDefrag] TO [MSDSL]
    AS [dbo];

