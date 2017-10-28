














create PROCEDURE [dbo].[cfp_PIG_GROUP_SOURCE_FARMS]
	@LOG char(1)='Y'

AS
BEGIN TRY

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
SET @ProcessName        = 'cfp_PIG_GROUP_SOURCE_FARMS'
SET @ProcessStatus      = 0
SET @StartDate          = GETDATE()
SET @RecordsProcessed   = 0
SET @Comments           = 'Started Successfully'
SET @Error              = 0
SET @Criteria           = 
		'@LOG= ' + CAST(@LOG AS VARCHAR) 
		
		
DECLARE @LogID bigint
DECLARE @PigGroupID				varchar(10)
DECLARE	@PigprodphaseID			char(3)
DECLARE	@itcnt					int
set @itcnt = 0

EXEC cfp_PROCESS_LOG_INSERT 'cfp_PIG_GROUP_SOURCE_FARMS', 'refresh  dbo.cft_PIG_FLOW_SOURCE_FARMS', 'SP', @ProcessLogID = @LogID OUTPUT
--empty table for new processing
TRUNCATE TABLE  dbo.cft_PIG_FLOW_SOURCE_FARMS

CREATE TABLE #SourceTable
	(     PigGroupID varchar(10)
	,     SourcePigGroupID varchar(10)
	,     TranDate datetime
	,     SourceProject varchar(16))

DECLARE Rollup_Cursor CURSOR FOR
--SELECT RIGHT(RTRIM(PigGroupID),5) FROM  dbo.cft_PIG_GROUP_BASE_SOURCE		-- 2012/03 smr replaced with a join to cftpiggroup, to get pigprodphaseid
SELECT distinct
RIGHT(RTRIM(bs.PigGroupID),5), pg.PigProdPhaseID 
FROM  dbo.cft_PIG_GROUP_BASE_SOURCE bs
  inner join [$(SolomonApp)].dbo.cftPigGroup pg
	on pg.PigGroupID = bs.PigGroupID
--WHERE Phase IN ('FIN','NUR')

OPEN Rollup_Cursor

FETCH NEXT FROM Rollup_Cursor INTO @PigGroupID, @PigProdPhaseID

WHILE @@FETCH_STATUS = 0
BEGIN

SET  @StepMsg = 'begin processing ' + @piggroupid
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;
--print 'begin processing '  + @piggroupid		-- T201304
set @itcnt = 0		-- 201304  set iteration

	INSERT INTO #SourceTable (PigGroupID, SourcePigGroupID, TranDate, SourceProject)
	SELECT distinct @PigGroupID, SourcePigGroupID, TranDate, SourceProject
	FROM  [$(SolomonApp)].dbo.cftPGInvTran cftPGInvTran (NOLOCK)
	WHERE cftPGInvTran.PigGroupID = @PigGroupID
	--AND   cftPGInvTran.TranTypeID IN ('TI','PP') --ignoring move ins (MI), per Adam
	AND   cftPGInvTran.TranTypeID IN ('TI','PP','MI') -- 201402 adding it back in to get better accuracy, was originally removed because of looping, changes in 2013 stopped looping
	AND cftPGInvTran.Reversal <> '1'
	WHILE (1=1)
	BEGIN

--print 'begin processing '  + @piggroupid + ' itcnt = ' + @itcnt		-- TEST201304

	      INSERT INTO #SourceTable (PigGroupID, SourcePigGroupID, TranDate, SourceProject)
	      SELECT DISTINCT cftPGInvTran.PigGroupID, cftPGInvTran.SourcePigGroupID, cftPGInvTran.TranDate, cftPGInvTran.SourceProject
	      FROM  [$(SolomonApp)].dbo.cftPGInvTran cftPGInvTran (NOLOCK)
	      INNER JOIN (select distinct sourcepiggroupid from #SourceTable where sourcepiggroupid > '') SourceTable		-- 2012/03 smr changed to help perf.  #SourceTable SourceTable
		    ON SourceTable.SourcePigGroupID = cftPGInvTran.PigGroupID
		-- 2012/03 smr added not exists to help with perform, don't reprocess a piggroupid
		--WHERE cftPGInvTran.TranTypeID IN ('TI','PP')		-- 201304  to eliminate assignment to "Other"
		where   cftPGInvTran.TranTypeID IN ('TI','PP','MI') -- 201402 adding it back in to get better accuracy, was originally removed because of looping, changes in 2013 stopped looping
		and Not exists 
		(select * from #SourceTable x 
		where x.PigGroupID = cftPGInvTran.PigGroupID and x.SourcePigGroupID = cftPGInvTran.SourcePigGroupID and x.SourceProject = cftPGInvTran.SourceProject
		and x.TranDate = cftPGInvTran.TranDate)
		and cftPGInvTran.Reversal <> '1'

--print 'insert into temp '  + @piggroupid + ' phase ' + @pigprodphaseid + ' loopcnt is ' + @itcnt 	-- TEST201304


		if (@itcnt > 15)    -- limit to 15 iterations, on a few piggroups it can go on for a MANY iterations.  Accounted for 40 minutes for 1.
			break
		else
		  begin
		    set @itcnt = @itcnt + 1
--			print 'loop cnt ' + @itcnt
			IF (SELECT COUNT(*) RecCt FROM #SourceTable A WHERE A.SourcePigGroupID <> '' AND NOT EXISTS (SELECT * FROM #SourceTable B WHERE B.PigGroupID = A.SourcePigGroupID)) = 0
				BREAK
			ELSE
				CONTINUE
		  end
--	      IF (SELECT COUNT(*) RecCt FROM #SourceTable A WHERE RTRIM(A.SourcePigGroupID) <> '' AND NOT EXISTS (SELECT * FROM #SourceTable B WHERE B.PigGroupID = A.SourcePigGroupID)) = 0
--		    BREAK
--	      ELSE
--		    CONTINUE
--print 'end processing ' + @piggroupid		-- TEST201304

	END


SET  @StepMsg = 'insert into table PG' + @piggroupid
--EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;
--print 'insert into table PG' + @piggroupid		-- TEST201304
	--insert the sources found for current piggroupid
	INSERT INTO  dbo.cft_PIG_FLOW_SOURCE_FARMS
	SELECT 'PG' + @piggroupid, convert(varchar,MIN(SourceTable.TranDate),101), CAST(cftSite.ContactID AS INT), NULL
	FROM #SourceTable SourceTable
	LEFT JOIN [$(SolomonApp)].dbo.PJProj PJProj (NOLOCK)
		ON PJProj.Project = SourceTable.SourceProject
	LEFT JOIN [$(SolomonApp)].dbo.cftSite cftSite (NOLOCK)
		ON cftSite.SolomonProjectID = PJProj.Project
	where SourceTable.SourcePigGroupID = ''
	and SourceTable.SourceProject <> ''
	group by cftSite.ContactID

	--clear temp table
--print 'Truncate temp table'		-- TEST201304
	TRUNCATE TABLE #SourceTable

FETCH NEXT FROM Rollup_Cursor INTO @PigGroupID,@pigprodphaseid
--print 'get next piggroupid ' + @piggroupid		-- TEST201304
END
CLOSE Rollup_Cursor
DEALLOCATE Rollup_Cursor

--cleanup
DROP TABLE #SourceTable

EXEC cfp_PROCESS_LOG_UPDATE @LogID


END TRY

BEGIN CATCH
    -- Execute error retrieval routine.
    EXECUTE [$(SolomonApp)].dbo.cfp_GetErrorInfo;
END CATCH; 
















GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_SOURCE_FARMS] TO [db_sp_exec]
    AS [dbo];

