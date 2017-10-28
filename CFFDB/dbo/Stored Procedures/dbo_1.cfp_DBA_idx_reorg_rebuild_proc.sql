



CREATE  PROCEDURE [dbo].[cfp_DBA_idx_reorg_rebuild_proc]
					@LOG char(1)='Y'
AS

/*
===============================================================================
Purpose: 

Inputs:
Outputs:    
Returns:    0 for success, 1 for failure
Enviroment:    Test, Production 

Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-01-13  SRipley		DBA index reorg/rebuild script

===============================================================================
*/

-------------------------------------------------------------------------------
-- Standard proc settings
-------------------------------------------------------------------------------
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-------------------------------------------------------------------------------
-- Declare standard variables
-------------------------------------------------------------------------------
DECLARE @RowCount               INT
DECLARE @StepMsg                VARCHAR(255)
DECLARE @DatabaseName           NVARCHAR(128)
DECLARE @DB_COMPAT	            SMALLINT
DECLARE @ProcessName            VARCHAR(50)
DECLARE @ProcessStatus          INT
DECLARE @StartDate              DATETIME
DECLARE @EndDate                DATETIME
DECLARE @RecordsProcessed       BIGINT
DECLARE @Comments               VARCHAR(2000)
DECLARE @Error                  INT
DECLARE @Criteria               VARCHAR(2000)
DECLARE	@sqlcmd					NVARCHAR (3072)


-------------------------------------------------------------------------------
-- Set standard variables
-------------------------------------------------------------------------------
SET @DatabaseName       = db_name()
Set @DB_COMPAT			= (select compatibility_level from sys.databases where name = DB_NAME())
SET @ProcessName        = 'cfp_DBA_idx_reorg_rebuild_proc'
SET @ProcessStatus      = 0
SET @StartDate          = GETDATE()
SET @RecordsProcessed   = 0
SET @Comments           = 'Started Successfully'
SET @Error              = 0
SET @Criteria           = 
		'@LOG= ' + CAST(@LOG AS VARCHAR) 
-------------------------------------------------------------------------------
-- Declare Proc variables
-------------------------------------------------------------------------------		
DECLARE @reorg_frag_thresh   float		SET @reorg_frag_thresh   = 10.0
DECLARE @rebuild_frag_thresh float		SET @rebuild_frag_thresh = 30.0
DECLARE @fill_factor         tinyint	SET @fill_factor         = 80
DECLARE @report_only         bit		SET @report_only         = 1

-- added (DS) : page_count_thresh is used to check how many pages the current table uses
DECLARE @page_count_thresh	 smallint	SET @page_count_thresh   = 100
 
-- Variables required for processing.
DECLARE @objectid       int
DECLARE @indexid        int
DECLARE @partitioncount bigint
DECLARE @schemaname     nvarchar(130) 
DECLARE @objectname     nvarchar(130) 
DECLARE @indexname      nvarchar(130) 
DECLARE @partitionnum   bigint
DECLARE @partitions     bigint
DECLARE @frag           float
DECLARE @page_count     int
DECLARE @command        nvarchar(4000)
DECLARE @intentions     nvarchar(4000)
DECLARE	@database_name	sysname
DECLARE	@database_id	smallint
DECLARE	@dbName		sysname,
	@tablename sysname,
	@tableid sysname ,
	@cTemp	char(10),
	@errDetail		varchar(200),
	@errNo		int,
	@errMsg		varchar(150),
	@errcount   smallint,
	@prevcnt bigint,
	@rowcnt bigint

-------------------------------------------------------------------------------
-- Log the start of the procedure
-------------------------------------------------------------------------------
IF @LOG='Y' 
	BEGIN
	EXEC CFFDB.dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate,
					   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END

-- ****************************************************************************************
-- ***						SECTION:	BUILD database LIST								***
-- ****************************************************************************************
SET  @StepMsg = 'build db list'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;

declare @db_list table (
	database_name sysname,
	database_id	smallint
)

set @sqlcmd = N'use master;
select name, database_id
from sys.databases
where database_id > 4
and state = 0 and is_read_only = 0'

insert into @db_list exec sp_executesql @sqlcmd

SET  @StepMsg = 'start loop to get index data'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;

LoopStart:

BEGIN TRY

WHILE EXISTS (SELECT * FROM @db_list) 
BEGIN
	
SELECT TOP 1 @database_name = database_name, @database_id = database_id FROM @db_list

set @sqlcmd = N'USE ' + db_name(cast(@database_id as varchar(3))) + 
N'; select ''' + db_name(cast(@database_id as varchar(3))) +
N''' as database_name, GETDATE() as crtd_date, o.name tabname, o.create_date, o.modify_date' +
N', idx.name as idxname, idx.type_desc, idx.is_unique, idx.is_primary_key, idx.fill_factor' +
N', dm.database_id, dm.object_id as objectid, dm.index_id as indexid, dm.partition_number as partitionnum, dm.index_type_desc, dm.alloc_unit_type_desc' +
N', dm.index_depth, dm.index_level, dm.avg_fragmentation_in_percent as frag, dm.fragment_count, dm.avg_fragment_size_in_pages' +
N', dm.page_count, dm.avg_page_space_used_in_percent, dm.record_count, dm.ghost_record_count, dm.version_ghost_record_count' +
N', dm.min_record_size_in_bytes, dm.max_record_size_in_bytes, dm.avg_record_size_in_bytes, dm.forwarded_record_count, dm.compressed_page_count' +
-- for 2005 N', dm.min_record_size_in_bytes, dm.max_record_size_in_bytes, dm.avg_record_size_in_bytes, dm.forwarded_record_count, NULL' +
N' from sys.objects o (nolock) ' +
N' inner join sys.dm_db_index_physical_stats(' + cast(@database_id as varchar(3)) + N',null,null,null,''DETAILED'') dm' +
N'	on dm.object_id = o.object_id and o.type = ''U'' ' +
N' inner join SYS.INDEXES idx (nolock) ' +
N' 	on idx.object_id = dm.object_id and idx.index_id = dm.index_id and idx.index_id > 0 ' +
N' where [avg_fragmentation_in_percent] > ' + cast(@reorg_frag_thresh as varchar(3)) + 
N' 	AND	page_count > ' + cast(@page_count_thresh as varchar(3)) 

Print '--Processing DB : ' + @database_name + ' sys.database_files query>insert '
print ''
print @sqlcmd
print ''

select @prevcnt = str(isnull(count(*),0)) from CFFDB.dbo.cft_dm_db_index_physical_stats

print ' select worked ' + cast( @prevcnt as varchar(15))

INSERT INTO CFFDB.dbo.cft_dm_db_index_physical_stats exec sp_executesql @sqlcmd

print 'insert '

select @rowcnt = str(isnull(count(*),0)) from CFFDB.dbo.cft_dm_db_index_physical_stats where crtd_date = getdate()

Print '--Processing DB : CFFDB.dbo.cft_dm_db_index_physical_stats ' + @database_name + '    cnt=' + cast(@rowcnt-@prevcnt as varchar(3))
set @prevcnt = @rowcnt
--  end of specific database loop

	DELETE FROM @db_list WHERE [database_id] = @database_id
End	

SELECT * FROM CFFDB.dbo.cft_dm_db_index_physical_stats

Print 'End Processing of cfp_DBA_idx_reorg_rebuild_proc '

END TRY


BEGIN CATCH
    SElecT @errNo= ERROR_NUMBER() ,@errMsg = error_message() ,@errDetail = 'Procedure:[cfp_DBA_idx_reorg_rebuild_proc]' 
													+ ' at line No:'+ cast(isnull(ERROR_LINE(),'') as char(4))
    Print '**Error while processing ' + Rtrim(cast(db_name() as char(30))) + 
    '  Error No: '+ rtrim(cast(@errNo as char(10)))+' Message: '+@errMsg +' Details: ' +@errDetail

	goto AtEnd
END CATCH

OutputSection:
BEGIN TRY

	select @@servername

END TRY
BEGIN CATCH
    SELECT @errNo= ERROR_NUMBER() ,@errMsg = error_message() 
    ,@errDetail = 'Procedure:[cfp_DBA_idx_reorg_rebuild_proc]:OutputSection' + ' at line No:'+ cast(isnull(ERROR_LINE(),'') as char(4))
    Print '**Error '+ 'Error No: '+ rtrim(cast(@errNo as char(10)))+' Message: '+@errMsg +' Details: ' +@errDetail
	Set @errDetail = @errDetail+' '+@errMsg
	Raiserror(@errDetail,10,1) with LOG
END CATCH

-- ****************************************************************************************
-- ***	SECTION:	DONE!								***
-- ****************************************************************************************

AtEnd:

Print 'End Processing of cfp_dbloop '