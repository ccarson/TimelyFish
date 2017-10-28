









CREATE PROCEDURE [dbo].[cfp_potential_idxs] 
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
	@cTemp	char(10),
	@errDetail		varchar(200),
	@errNo		int,
	@errMsg		varchar(150),
	@errcount   smallint,
	@prevcnt bigint,
	@rowcnt bigint


BEGIN TRY

set @sqlcmd = N'USE ' + db_name() +
N'; select @@SERVERNAME as servername, getdate() as crtd_datetime,' +
N'db_name(mid.database_id) as dbname, unique_compiles, user_seeks, user_scans, last_user_seek, last_user_scan, avg_total_user_cost, avg_user_impact, ' +
N'	equality_columns, inequality_columns, included_columns, statement ' +
N'FROM sys.dm_db_missing_index_group_stats AS migs ' +
N'INNER JOIN sys.dm_db_missing_index_groups AS mig ' +
N'    ON (migs.group_handle = mig.index_group_handle) ' +
N'INNER JOIN sys.dm_db_missing_index_details AS mid ' +
N'    ON (mig.index_handle = mid.index_handle) ' +
N'ORDER BY avg_total_user_cost * avg_user_impact * (user_seeks + user_scans)DESC ' 


Print 'Potentially missing indexes '
--print '		--Processing DB : ' + @database_name

print @sqlcmd

select @prevcnt = str(isnull(count(*),0)) from cffdb.dbo.cft_potential_index_list

Print '		--Processing DB : cft_potential_index_list.    row count before insert, cnt=' + cast(@prevcnt as varchar(3))

INSERT INTO cffdb.dbo.cft_potential_index_list exec sp_executesql @sqlcmd

select @rowcnt = str(isnull(count(*),0)) from cffdb.dbo.cft_potential_index_list

Print '		--Processing DB : cft_potential_index_list.    row count after insert, cnt=' + cast(@rowcnt as varchar(3)) + ' change is ' + cast(@rowcnt-@prevcnt as varchar(3))
set @prevcnt = @rowcnt

print ''





END TRY
BEGIN CATCH
    SElecT @errNo= ERROR_NUMBER() ,@errMsg = error_message() ,@errDetail = 'Procedure:[cfp_dbloop_potential_idxs]' 
													+ ' at line No:'+ cast(isnull(ERROR_LINE(),'') as char(4))
    Print '**Error while processing ' + Rtrim(cast(db_name() as char(30))) + '  Error No: '+ rtrim(cast(@errNo as char(10)))+' Message: '+@errMsg +' Details: ' +@errDetail

	goto AtEnd
END CATCH

OutputSection:
BEGIN TRY

	select @@servername

END TRY
BEGIN CATCH
    SELECT @errNo= ERROR_NUMBER() ,@errMsg = error_message() ,@errDetail = 'Procedure:[cfp_dbloop_potential_idxs]:OutputSection' + ' at line No:'+ cast(isnull(ERROR_LINE(),'') as char(4))
    Print '**Error '+ 'Error No: '+ rtrim(cast(@errNo as char(10)))+' Message: '+@errMsg +' Details: ' +@errDetail
	Set @errDetail = @errDetail+' '+@errMsg
	Raiserror(@errDetail,10,1) with LOG
END CATCH

-- ****************************************************************************************
-- ***	SECTION:	DONE!								***
-- ****************************************************************************************

AtEnd:

Print 'End Processing of cfp_potential_idxs '










