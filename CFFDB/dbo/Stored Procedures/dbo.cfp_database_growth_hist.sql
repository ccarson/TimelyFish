









CREATE PROCEDURE [dbo].[cfp_database_growth_hist] 
AS

/***************************************************************************************
This procedure will 
The output is 				  
****************************************************************************************/
SET NOCOUNT ON
DECLARE	 @schemaname sysname,
	@dbName		sysname,
	@tablename sysname,
	@tableid sysname ,
	@database_name sysname ,
	@database_id	smallint,
	@sqlcmd	NVARCHAR (3072),
	@sqlcmd_use	NVARCHAR (200),
	@sqlcmd_go	NVARCHAR (10),
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

declare @db_list table (
	database_name sysname,
	database_id	smallint
)

set @sqlcmd = N'use master;
select name, database_id
from sys.databases
where name not like ''%-%''
and name not like ''% %''
and state = 0 and is_read_only = 0'

insert into @db_list exec sp_executesql @sqlcmd

--IF (OBJECT_ID ('tempdb..#dba_sysDatabase_Files')) IS NOT NULL
--	TRUNCATE TABLE #dba_sysDatabase_Files
--Else
--IF (OBJECT_ID ('tempdb..#dba_sysDatabase_Files')) IS NOT NULL
--	DROP TABLE #dba_sysDatabase_Files

--CREATE TABLE #cft_database_growth_hist (
--	crtd_ts		datetime not null,
--	[name]		sysname NOT NULL,
--	[file_id] [smallint] NOT NULL,
--	[physical_name] [nvarchar] (260),
--	[size_8k] [int],
--	[maxsize] [nvarchar] (15),
--	[growth] [nvarchar] (15)
--	)

LoopStart:

BEGIN TRY

WHILE EXISTS (SELECT * FROM @db_list) 
BEGIN
	
SELECT TOP 1 @database_name = database_name, @database_id = database_id FROM @db_list
	
-- query for list of triggers
set @sqlcmd = N'USE ' + db_name(cast(@database_id as varchar(3))) + 
N'; select getdate() as crtd_ts, name, file_id, physical_name, size * 8  as size_8k ' +
N', case max_size	 when -1 then ''unlimited'' when 0 then ''no growth'' else ''2TB'' end as maxsize ' +
N', case when is_percent_growth = 0 then cast(growth * 8 as varchar)  + '' KB'' when is_percent_growth = 1 then cast(growth as varchar) + ''%'' end as growth ' +
N' from sys.database_files'
--N'; select dbname, trigname, c.text from syscomments c ' +
--N' inner join ' +
--N'(select db_name() dbname, name trigname, object_id from sys.objects where type = ''TR'') o' +
--N' on o.object_id = c.id '


Print '--Processing DB : ' + @database_name + ' sys.database_files query>insert '
print ''
print @sqlcmd
print ''

select @prevcnt = str(isnull(count(*),0)) from CFFDB.dbo.cft_database_growth_hist

print ' select worked '

INSERT INTO CFFDB.dbo.cft_database_growth_hist exec sp_executesql @sqlcmd

print 'insert '

select @rowcnt = str(isnull(count(*),0)) from CFFDB.dbo.cft_database_growth_hist

Print '--Processing DB : CFFDB.dbo.cft_database_growth_hist ' + @database_name + '    cnt=' + cast(@rowcnt-@prevcnt as varchar(3))
set @prevcnt = @rowcnt
--  end of specific database loop

	DELETE FROM @db_list WHERE [database_id] = @database_id
End	

SELECT * FROM CFFDB.dbo.cft_database_growth_hist


END TRY
BEGIN CATCH
    SElecT @errNo= ERROR_NUMBER() ,@errMsg = error_message() ,@errDetail = 'Procedure:[cfp_dbloop]' 
													+ ' at line No:'+ cast(isnull(ERROR_LINE(),'') as char(4))
    Print '**Error while processing ' + Rtrim(cast(db_name() as char(30))) + '  Error No: '+ rtrim(cast(@errNo as char(10)))+' Message: '+@errMsg +' Details: ' +@errDetail

	goto AtEnd
END CATCH

OutputSection:
BEGIN TRY

	select @@servername

END TRY
BEGIN CATCH
    SELECT @errNo= ERROR_NUMBER() ,@errMsg = error_message() ,@errDetail = 'Procedure:[cfp_dbloop]:OutputSection' + ' at line No:'+ cast(isnull(ERROR_LINE(),'') as char(4))
    Print '**Error '+ 'Error No: '+ rtrim(cast(@errNo as char(10)))+' Message: '+@errMsg +' Details: ' +@errDetail
	Set @errDetail = @errDetail+' '+@errMsg
	Raiserror(@errDetail,10,1) with LOG
END CATCH

-- ****************************************************************************************
-- ***	SECTION:	DONE!								***
-- ****************************************************************************************

AtEnd:

Print 'End Processing of cfp_dbloop '










