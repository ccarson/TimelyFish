CREATE PROCEDURE [dbo].[cfp_trigger_list] 
AS

/***************************************************************************************
This procedure will return insert statements for the Index Audit process.
The output is return as table				  
****************************************************************************************/

DECLARE	
	@sqlcmd	NVARCHAR (3072),
	@SQLString nvarchar (2000),
	@dbid	smallint,
	@name		sysname,
	@text		varchar(200),
	@schemaname sysname,
	@tablename sysname,
	@tableid sysname ,
	@dbname sysname ,
	@cTemp	char(10),
	@errDetail		varchar(200),
	@errNo		int,
	@errMsg		varchar(150),
	@errcount   smallint,
	@prevcnt bigint,
	@rowcnt bigint



			
-- ****************************************************************************************
-- ***						SECTION:	BUILD database LIST								***
-- ****************************************************************************************

CREATE TABLE #db_list		([name]					sysname,  
                               [dbid]				smallint) 
                               


set @sqlcmd = N'select name, dbid
from sysdatabases
where dbid > 4
order by dbid'
-- , mode, status, crdate, cmptlevel, filename

--insert into @db_list exec sp_executesql @sqlcmd
      SET @SQLString = N'USE master ' + @sqlcmd
      INSERT #db_list
      EXECUTE(@SQLString)
      --


LoopStart:

BEGIN

CREATE TABLE #trigger_list		(dbname varchar(40),name varchar(40),type varchar(2) ,[spcmd] varchar(8000))

WHILE EXISTS (SELECT * FROM #db_list) 
BEGIN
	
SELECT TOP 1 @name = name, @dbid = dbid FROM #db_list
Print '--Processing DB : ' + @name


 SET @SQLString = N'USE ' +@name + N'; SELECT db_name() as dbname, name, type, object_definition(object_id) from sys.objects where type = ''Tr'' and is_ms_shipped = 0'        
 --print @sqlstring

      INSERT #trigger_list
		EXECUTE(@SQLString)


DELETE FROM #db_list WHERE [dbid] = @dbid

End	

select * from #trigger_list

drop table #trigger_list




END