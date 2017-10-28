















CREATE PROCEDURE [dbo].[cfp_db_index_maintenance]
					@LOG char(1)='N' 
					,@report_only int = 1
					,@reorg_frag_thresh	float	= 10.0
					,@rebuild_frag_thresh float = 30.0
					,@fill_factor tinyint       = 80
					,@page_count_thresh smallint  = 1000
					,@dbname sysname = 'Pigchamp'
AS
BEGIN		-- procedure begin

/*
===============================================================================
Purpose: Report on Sowdata index status, then either rebuild or reorg indexes

Inputs:
Outputs:    
Returns:    0 for success, 1 for failure
Enviroment:    Test, Production 

DEBUG:

exec CFFDB.dbo.cfp_PrintTs  'start 1'
exec 
exec CFFDB.dbo.cfp_PrintTs 'end 1'

Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-04-09  SRipley index status report, rebuild or reindex indexes

===============================================================================
*/

-------------------------------------------------------------------------------
-- Standard proc settings
-------------------------------------------------------------------------------

SET NOCOUNT on;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-------------------------------------------------------------------------------
-- Declare standard variables
-------------------------------------------------------------------------------
DECLARE @RowCount               INT
DECLARE @StepMsg                VARCHAR(255)
--DECLARE @DatabaseName           NVARCHAR(128)
DECLARE @ProcessName            VARCHAR(50)
DECLARE @ProcessStatus          INT
DECLARE @StartDate              DATETIME
DECLARE @EndDate                DATETIME
DECLARE @RecordsProcessed       BIGINT
DECLARE @Comments               VARCHAR(2000)
DECLARE @Error                  INT
DECLARE @Criteria               VARCHAR(2000)


-------------------------------------------------------------------------------
-- Set standard variables
-------------------------------------------------------------------------------
--SET @DatabaseName       = @dbname
SET @ProcessName        = 'cfp_db_index_maintenance'
SET @ProcessStatus      = 0
SET @StartDate          = GETDATE()
SET @RecordsProcessed   = 0
SET @Comments           = 'Started Successfully'
SET @Error              = 0
SET @Criteria           = 
		'@LOG= ' + CAST(@LOG AS VARCHAR) 
		
-- =======================================================
-- || Configuration variables:
-- || - 10 is an arbitrary decision point at which to
-- || reorganize indexes.
-- || - 30 is an arbitrary decision point at which to
-- || switch from reorganizing, to rebuilding.
-- || - 0 is the default fill factor. Set this to a
-- || a value from 1 to 99, if needed.
-- =======================================================
--DECLARE @reorg_frag_thresh   float		SET @reorg_frag_thresh   = 10.0
--DECLARE @rebuild_frag_thresh float		SET @rebuild_frag_thresh = 30.0
--DECLARE @fill_factor         tinyint	SET @fill_factor         = 80
--DECLARE @report_only         bit			SET @report_only         = 1

-- added (DS) : page_count_thresh is used to check how many pages the current table uses
--DECLARE @page_count_thresh	 smallint	SET @page_count_thresh   = 1000
 
-- Variables required for processing.

DECLARE @objectid       int
DECLARE @indexid        int
DECLARE @partitioncount bigint
DECLARE @crtd_date     datetime
DECLARE @database_name     nvarchar(130) 
DECLARE @schemaname     nvarchar(130) 
DECLARE @tablename     nvarchar(130) 
DECLARE @idxname      nvarchar(130) 
DECLARE @partitionnum   bigint
DECLARE @partitions     bigint
DECLARE @frag           float
DECLARE @after_frag           float
DECLARE @page_count     int
DECLARE @after_page_count     int
declare @dbid			int
SET		@dbid       = db_id(@dbname)
DECLARE @command        nvarchar(4000)
DECLARE @intentions     nvarchar(4000)
DECLARE	@sqlcmd					NVARCHAR (3072)

-------------------------------------------------------------------------------
-- Log the start of the procedure
-------------------------------------------------------------------------------
IF @LOG='Y' 
	BEGIN
	EXEC CFFDB.dbo.cfp_ProcessLog @dbName,@ProcessName, @ProcessStatus, @StartDate,
					   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
	
-------------------------------------------------------------------------------
-- reorg script
-------------------------------------------------------------------------------
SET  @StepMsg = 'Reorg script'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

-- http://www.sqlmusings.com
-- Ensure a USE <databasename> statement has been executed first.
SET NOCOUNT ON

-- adapted from "Rebuild or reorganize indexes (with configuration)" from MSDN Books Online 
-- (http://msdn.microsoft.com/en-us/library/ms188917.aspx)
 
set @sqlcmd = N'use ' + @dbname +
N';SELECT
	db_name()				as database_name, getdate() as crtd_date,
    pstat.[object_id]                    AS tableid,
    QUOTENAME(o.[name])			as tablename,
    QUOTENAME(s.[name])			as schemaname,
    x.index_id					as index_id, 
    QUOTENAME(x.[name])			as idxname,
    [partition_number]             AS partitionnum,
    [avg_fragmentation_in_percent] AS frag,
	[page_count]				   AS page_count,
	null,null,null
FROM
    sys.dm_db_index_physical_stats (' + cast(DB_ID(@dbname) as nvarchar(124)) + 
N', NULL, NULL , NULL, ''LIMITED'') as pstat
 join ' + @dbname +
 N'.sys.objects AS o WITH (NOLOCK)
	on o.object_id = pstat.object_id
 join ' + @dbname +
 N'.sys.schemas as s WITH (NOLOCK)
	on s.schema_id = o.schema_id
 join ' + @dbname +
 N'.sys.indexes as x (nolock)
	on x.object_id = pstat.object_id and x.index_id = pstat.index_id
WHERE
    [avg_fragmentation_in_percent] > ' + cast(@reorg_frag_thresh as varchar(30)) +
N'	AND	page_count > ' + cast(@page_count_thresh as varchar(10)) +
N'	AND pstat.index_id > 0'


if @report_only = 1 begin
insert into cffdb.dbo.cft_index_reorg_rebuild_list exec sp_executesql @sqlcmd
print 'Rows inserted into list ' + cast(@@rowcount as varchar(30))
end

SET  @StepMsg = 'start loop to get index data'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;
     


	

-- Declare the cursor for the list of partitions to be processed.
DECLARE partitions CURSOR FOR
    SELECT * FROM cffdb.dbo.cft_index_reorg_rebuild_list
    where CONVERT(nvarchar(30), crtd_date, 110) = CONVERT(nvarchar(25),@StartDate, 110)
    and database_name = @dbname
 
-- Open the cursor.
OPEN partitions
 
-- Loop through the partitions.
WHILE (1=1) BEGIN
    FETCH NEXT
        FROM partitions
        INTO @database_name, @crtd_date, @objectid, @tablename, @schemaname, @indexid, @idxname, @partitionnum, @frag, @page_count, @command, @after_frag, @after_page_count
	 
    IF @@FETCH_STATUS < 0 BREAK
 
    -- Build the required statement dynamically based on options and index stats.
    SET @intentions =
        @schemaname + N'.' +
        @tablename + N'.' +
        @idxname + N':' + CHAR(13) + CHAR(10)
    SET @intentions =
        REPLACE(SPACE(LEN(@intentions)), ' ', '=') + CHAR(13) + CHAR(10) +
        @intentions
    SET @intentions = @intentions +
        N' FRAGMENTATION: ' + CAST(@frag AS nvarchar) + N'%' + CHAR(13) + CHAR(10) +
        N' PAGE COUNT: '    + CAST(@page_count AS nvarchar) + CHAR(13) + CHAR(10)
 
    IF @frag < @rebuild_frag_thresh BEGIN
        SET @intentions = @intentions +
            N' OPERATION: REORGANIZE' + CHAR(13) + CHAR(10)
        SET @command =
            N'use ' + @database_name + '; ALTER INDEX ' + @idxname +
            N' ON ' + @schemaname + N'.' + @tablename +
            N' REORGANIZE; ' + 
            N' UPDATE STATISTICS ' + @schemaname + N'.' + @tablename + 
            N' ' + @idxname + ';'

    END
    IF @frag >= @rebuild_frag_thresh BEGIN
        SET @intentions = @intentions +
            N' OPERATION: REBUILD' + CHAR(13) + CHAR(10)
        SET @command =
            N'use ' + @database_name + '; ALTER INDEX ' + @idxname +
            N' ON ' + @schemaname + N'.' +     @tablename +
            N' REBUILD'
    END
    IF @partitioncount > 1 BEGIN
        SET @intentions = @intentions +
            N' PARTITION: ' + CAST(@partitionnum AS nvarchar(10)) + CHAR(13) + CHAR(10)
        SET @command = @command +
            N' PARTITION=' + CAST(@partitionnum AS nvarchar(10))
    END
    IF @frag >= @rebuild_frag_thresh AND @fill_factor > 0 AND @fill_factor < 100 BEGIN
        SET @intentions = @intentions +
            N' FILL FACTOR: ' + CAST(@fill_factor AS nvarchar) + CHAR(13) + CHAR(10)
        SET @command = @command +
            N' WITH (FILLFACTOR = ' + CAST(@fill_factor AS nvarchar) + ')'
    END
 
    -- Execute determined operation, or report intentions
    IF @report_only = 0 BEGIN
        SET @intentions = @intentions + N' EXECUTING: ' + @command
        PRINT @intentions	    
        EXEC (@command)
        
        	-- update after the fact where after columns are null and date is today
		select @frag=avg_fragmentation_in_percent, @page_count=page_count
		FROM sys.dm_db_index_physical_stats (@dbid,@objectid,@indexid,@partitionnum, 'LIMITED')

		update cffdb.dbo.cft_index_reorg_rebuild_list
		set command = @command,
		after_frag = @frag,
		after_page_count = @page_count
		where database_name = DB_NAME(@dbid)
			and CONVERT(nvarchar(25), crtd_date, 110) = CONVERT(nvarchar(25),@StartDate, 110)
			and tableid = @objectid
			and index_id = @indexid
			and partitionnum = @partitionnum
			and command is null
		;

		print 'Rows updated in list '  +cast(@@rowcount as varchar(25))
	
	END ELSE BEGIN
		PRINT @intentions
    END
	PRINT @command
	


END
 
-- Close and deallocate the cursor.
CLOSE partitions
DEALLOCATE partitions


END		-- procedure end
-------------------------------------------------------------------------------
-- If the procedure gets to here, it is a successful run
-- NOTE: Make sure to capture @RecordsProcessed from your main query
-------------------------------------------------------------------------------
SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'

-------------------------------------------------------------------------------
-- Log the end of the procedure
-------------------------------------------------------------------------------
TheEnd:
SET @EndDate = GETDATE()
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC CFFDB.dbo.cfp_ProcessLog @DbName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
EXEC CFFDB.dbo.cfp_PrintTs 'End'
RAISERROR (@Comments, @ProcessStatus, 1)

RETURN @ProcessStatus

-------------------------------------------------------------------------------
-- Error handling
-------------------------------------------------------------------------------
ERR_Common:
    SET @Comments         = 'Error in step: ' + @StepMsg

    SET @ProcessStatus    = 16
    SET @RecordsProcessed = 0
    GOTO TheEnd					

	  












