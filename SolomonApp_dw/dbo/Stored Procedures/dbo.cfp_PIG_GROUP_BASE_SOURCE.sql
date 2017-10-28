














CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_BASE_SOURCE]
	@LOG char(1)='Y'
AS

BEGIN
/*
===============================================================================
Purpose: Prepare data for Master Pig group processing

Inputs:  Logging Flag
Outputs:    Refresh of the  dbo.cft_PIG_GROUP_BASE_SOURCE table
Returns:    0 for success, 1 for failure
Enviroment:    Test, Production 

DEBUG:

exec [$(CFFDB)].dbo.cfp_PrintTs  'start 1'
exec 
exec [$(CFFDB)].dbo.cfp_PrintTs 'end 1'

Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-03-11	SRipley		revamp of proc  

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

SET @DatabaseName       = db_name()
SET @ProcessName        = 'cfp_PIG_GROUP_BASE_SOURCE'
SET @ProcessStatus      = 0
SET @StartDate          = GETDATE()
SET @RecordsProcessed   = 0
SET @Comments           = 'Started Successfully'
SET @Error              = 0
SET @Criteria           = 
		'@LOG= ' + CAST(@LOG AS VARCHAR) 

-------------------------------------------------------------------------------
-- declare and set proc specific variables
-------------------------------------------------------------------------------
	
DECLARE	@PigGroupID				varchar(10)
DECLARE	@PigprodphaseID			char(3)
DECLARE	@itcnt					int
set @itcnt = 0


-------------------------------------------------------------------------------
-- Log the start of the procedure
-------------------------------------------------------------------------------
IF @LOG='Y' 
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate,
					   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
-------------------------------------------------------------------------------
-- Delete from cft_pig_group_base_source
-------------------------------------------------------------------------------
SET  @StepMsg = 'Delete from cft_pig_group_base_source, piggroups that closed in the last 90 days and all open group'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;

select @RowCount = count(*) from  dbo.cft_PIG_GROUP_BASE_SOURCE

--Print '--Processing: starting Rowcnt is ' + cast(@RowCount as varchar)
SET @RecordsProcessed = @RowCount
SET @Comments = '--Processing: starting Rowcnt, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' rows exist'                

IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg






--This is the start of the new code JohnMaas 10/1/2010
DELETE FROM  dbo.cft_PIG_GROUP_BASE_SOURCE
WHERE EXISTS
      (select pg.PigGroupID
      from [$(SolomonApp)].dbo.cftPigGroup pg (NOLOCK)
      where
      pg.PigGroupID =  dbo.cft_PIG_GROUP_BASE_SOURCE.PigGroupID
--Deletes out PigGroups that closed in the last 90 days and all Open groups
      and (pg.ActCloseDate >= (GETDATE()-100) or pg.ActCloseDate = '1/1/1900')
      and pg.PGStatusID <> 'X'
      and pg.PigSystemID = '00')
      
      
      
      
      

--Print '--Processing: Ending Rowcnt is ' + cast(@RowCount AS VARCHAR)
SET @RecordsProcessed = @RowCount
SET @Comments = '--Processing: Ending Rowcnt, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' rows remain'                

IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- create temp table #piggroupid_list
-------------------------------------------------------------------------------
SET  @StepMsg = 'create temp table #piggroupid_list'
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;

--new code 2012-03-11 smr
IF (OBJECT_ID ('tempdb..#piggroupid_list')) IS NOT NULL
	TRUNCATE TABLE #piggroupid_list
Else
IF (OBJECT_ID ('tempdb..#piggroupid_list')) IS NOT NULL
	DROP TABLE #piggroupid_list
		
create table #piggroupid_list (piggroupid varchar (10), pigprodphaseid char(3)) 

select @RowCount = count(*) from #piggroupid_list

--Print '--Processing: #piggroupid_list' + cast(@RowCount AS VARCHAR)
SET @RecordsProcessed = @RowCount
SET @Comments = '--Processing: verifiy zero Rowcnt, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' rows exist'                

IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- create temp table #SourceTable
-------------------------------------------------------------------------------
SET  @StepMsg = 'create temp table #SourceTable'
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;

IF (OBJECT_ID ('tempdb..#SourceTable')) IS NOT NULL
	TRUNCATE TABLE #SourceTable
Else
IF (OBJECT_ID ('tempdb..#SourceTable')) IS NOT NULL
	DROP TABLE #SourceTable
	
create table #SourceTable 
(     PigGroupID varchar(10)
,     SourcePigGroupID varchar(10)
,     SourceProject varchar(16))

select @RowCount = count(*) from #SourceTable

--Print '--Processing: #SourceTable' + cast(@RowCount AS VARCHAR)
SET @RecordsProcessed = @RowCount
SET @Comments = '--Processing: verifiy zero Rowcnt, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' rows exist'                

IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg
-------------------------------------------------------------------------------
-- insert into table #piggroupid_list
-------------------------------------------------------------------------------
SET  @StepMsg = 'insert into temp table #piggroupid_list'
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;

INSERT INTO #piggroupid_list
SELECT distinct 
rtrim(pg.PigGroupID), PigProdPhaseID
FROM [$(SolomonApp)].dbo.cftPigGroup pg (NOLOCK)
WHERE
--Inserts PigGroups that closed in the last 90 days and all Open groups
      (pg.ActCloseDate >= (GETDATE()-100) or pg.ActCloseDate = '1/1/1900')
      and pg.PGStatusID <> 'X'
      and pg.PigSystemID = '00'    
--end code 2012-03-11 smr

select @RowCount = count(*) from #piggroupid_list

--Print '--Processing: #piggroupid_list' + cast(@RowCount AS VARCHAR)
SET @RecordsProcessed = @RowCount
SET @Comments = '--Processing: #piggroupid_list, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' rows inserted'                

IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--modified code 2012-03-11 smr eliminate the use of the called function, loop through the list of piggroupids
--INSERT INTO  dbo.cft_PIG_GROUP_BASE_SOURCE
--SELECT pg.PigGroupID, [$(SolomonApp)].dbo.PGGetBaseSource(pg.PigGroupID)

-------------------------------------------------------------------------------
-- loop through table #piggroupid_list
-------------------------------------------------------------------------------
SET  @StepMsg = 'Outer loop: #piggroupid_list'
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;

WHILE EXISTS (SELECT * FROM #piggroupid_list) 
BEGIN
	
SELECT TOP 1 @piggroupid = PigGroupID, @pigprodphaseid = pigprodphaseid  FROM #piggroupid_list


--Print '--Outer Loop:  Processing: #piggroupid_list ' + @piggroupid
SET @Comments = '--Processing: #piggroupid_list, ' + @piggroupid                

IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg
-------------------------------------------------------------------------------
-- trunc temp table #SourceTable
-------------------------------------------------------------------------------
SET  @StepMsg = 'truncate temp table #SourceTable'
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;

	TRUNCATE TABLE #SourceTable
	

-------------------------------------------------------------------------------
-- insert into temp table #SourceTable
-------------------------------------------------------------------------------
SET  @StepMsg = 'insert into temp table #SourceTable using ' +  @piggroupid
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;

INSERT INTO #SourceTable (PigGroupID, SourcePigGroupID, SourceProject)
SELECT distinct cftPGInvTran.PigGroupID, cftPGInvTran.SourcePigGroupID, cftPGInvTran.SourceProject
FROM  [$(SolomonApp)].dbo.cftPGInvTran cftPGInvTran (NOLOCK)
WHERE cftPGInvTran.piggroupid = @PigGroupID
and cftPGInvTran.TranTypeID IN ('TI','MI','PP')
AND cftPGInvTran.Reversal <> '1'

select @RowCount = count(*) from #SourceTable

--Print '--Processing: #SourceTable initialize with ' + cast(@RowCount AS VARCHAR)
SET @RecordsProcessed = @RowCount
SET @Comments = '--Processing: #SourceTable, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' rows inserted'                

IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- loop through piggroupid processing
-------------------------------------------------------------------------------
SET  @StepMsg = 'Start looping through piggroupid processing'
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;

set @itcnt = 0
WHILE (1=1)
BEGIN

	select @RowCount = count(*) from #SourceTable
--	Print '-- within loop, processing PigGroupID ' +@piggroupid + ' PigProdPhaseID is ' + @pigprodphaseid + ' initial # rows in #SourceTable ' + cast(@RowCount AS VARCHAR)

	set @itcnt =@itcnt + 1
	
      INSERT INTO #SourceTable (PigGroupID, SourcePigGroupID, SourceProject)
      SELECT DISTINCT cftPGInvTran.PigGroupID, cftPGInvTran.SourcePigGroupID, cftPGInvTran.SourceProject
      FROM  [$(SolomonApp)].dbo.cftPGInvTran cftPGInvTran (NOLOCK)
      INNER JOIN (select distinct sourcepiggroupid from #SourceTable) SourceTable
            ON SourceTable.SourcePigGroupID = cftPGInvTran.PigGroupID
	  WHERE Not exists 
	  (select * from #SourceTable x 
	   where x.PigGroupID = cftPGInvTran.PigGroupID and x.SourcePigGroupID = cftPGInvTran.SourcePigGroupID and x.SourceProject = cftPGInvTran.SourceProject)
	  and cftPGInvTran.Reversal <> '1'
	  
		select @RowCount = count(*) from #SourceTable
--		Print '-- within loop, inserted this number of rows into #SourceTable' + cast(@RowCount AS VARCHAR)

SET @RecordsProcessed = @RowCount
SET @Comments = '--Processing: #SourceTable, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' rows inserted'                

IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg


--print '-- within loop, itcnt is ' + cast(@itcnt AS VARCHAR)

          
     if (@itcnt > 15 and @PigprodphaseID = 'TEF')    -- limit to 15 iterations, on a few piggroups it can go on for a MANY iterations.  Accounted for 40 minutes for 1.
			break
	 else
		IF (SELECT COUNT(*) RecCt FROM #SourceTable A WHERE A.SourcePigGroupID <> '' AND NOT EXISTS (SELECT * FROM #SourceTable B WHERE B.PigGroupID = A.SourcePigGroupID)) = 0
			BREAK
		ELSE
			CONTINUE

END

-------------------------------------------------------------------------------
-- loop through piggroupid processing
-------------------------------------------------------------------------------
SET  @StepMsg = 'Looping done for PigGroupID, get the list of sites for the piggroup'
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;

-- CONCATENATE
DECLARE @Concat as varchar(8000)

SELECT @Concat = isnull(@Concat + ', ', '') + ltrim(rtrim(PJProj.project_desc))
from (select distinct sourceproject from #SourceTable where SourcePigGroupID = '') SourceTable
inner JOIN [$(SolomonApp)].dbo.PJProj PJProj (NOLOCK)
ON PJProj.Project = SourceTable.SourceProject
group by PJProj.project_desc
order by PJProj.project_desc


-------------------------------------------------------------------------------
-- insert into  dbo.cft_PIG_GROUP_BASE_SOURCE
-------------------------------------------------------------------------------
SET  @StepMsg = 'insert into  dbo.cft_PIG_GROUP_BASE_SOURCE'
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;

insert into  dbo.cft_PIG_GROUP_BASE_SOURCE (piggroupid, BaseSource)
values (@PigGroupID, @Concat)
 --     and (pg.ActCloseDate >= (GETDATE()-100) or pg.ActCloseDate = '1/1/1900')
 --     and pg.PGStatusID <> 'X'
 --     and pg.PigSystemID = '00')


--Print '--Processing: insert into  dbo.cft_PIG_GROUP_BASE_SOURCE ' + @PigGroupID + ' ' + @Concat
SET @RecordsProcessed = @RowCount
SET @Comments = '--Processing: insert into base_source table ' + @PigGroupID + @Concat  

       

IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- remove piggoupid from list and continue loop
-------------------------------------------------------------------------------
SET  @StepMsg = 'remove piggoupid from list and continue loop'
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;

DELETE FROM #piggroupid_list WHERE piggroupid  = @PigGroupID

		select @RowCount = count(*) from #piggroupid_list
--		Print '-- PigGroups that remain to be processed ' + cast(@RowCount AS VARCHAR)
		
SET  @StepMsg = '-- PigGroups that remain to be processed ' + cast(@RowCount AS VARCHAR)
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;

set @Concat = NULL  

End	-- end of piggroup id processing

end -- end of proc














