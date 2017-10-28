
CREATE PROCEDURE [dbo].cfp_reload_cft_Pig_Group_Genetics @LOG char(1)='Y' AS
BEGIN
/*
===============================================================================
Purpose: This procedure attempts to pull together sire genetics for 'Nur', 'WTF', and 'Fin' pig groups since January 1st, 2014.
Inputs: Log - defaults to "Y"
Outputs:    

exec dbo.cfp_reload_cft_Pig_Group_Genetics 'Y'

Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2015-11-17 Brian Diehl	Created
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
	SET @ProcessName        = 'cfp_reload_cft_Pig_Group_Genetics'
	SET @ProcessStatus      = 0
	SET @StartDate          = GETDATE()
	SET @RecordsProcessed   = 0
	SET @Comments           = 'Started Successfully'
	SET @Error              = 0
	SET @Criteria           = '@LOG= ' + CAST(@LOG AS VARCHAR) 
	
	-------------------------------------------------------------------------------
	-- Log the start of the procedure
	-------------------------------------------------------------------------------
	IF @LOG='Y' 
	BEGIN
		EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate,
						@EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
	
	-------------------------------------------------------------------------------
	-- Log the the Step
	-------------------------------------------------------------------------------
	SET  @StepMsg = 'Truncate Table  dbo.cft_Pig_Group_Genetics'
	EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg




	--CREATE Table  dbo.cft_Pig_Group_Genetics (
	--	  PigGroupID varchar(10)
	--	, TaskID varchar(12)
	--	, PigFlowID int
	--	, PigFlowDescription varchar(100)
	--	, ReportingGroupID int
	--	, SowTotalWeanedOnPicWeek int
	--	, PigChampGeneticName varchar(30)
	--	, EstWeanPicYear_Wk varchar(6)
	--	, [% Genetics] decimal (5,2)
	--	, GeneticsPercentageOrder int
	--)
	--GO

	--Create Index cft_pig_group_genetics_PigGroupID on  dbo.cft_Pig_Group_Genetics (PigGroupID)
	--GO

	Truncate Table  dbo.cft_Pig_Group_Genetics

	SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	SET @RecordsProcessed = @RowCount
	SET @Comments = 'Completed successfully - Truncate Table  dbo. dbo.cft_Pig_Group_Genetics, '
					+ CAST(@RecordsProcessed AS VARCHAR)
					+ ' records processed'
	IF @LOG='Y' or @Error!=0 BEGIN
		EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
							 @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
	SET  @StepMsg = @Comments
	EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg
	
	-------------------------------------------------------------------------------
	-- Log the the Step
	-------------------------------------------------------------------------------
	SET  @StepMsg = 'Insert data into Table  dbo.cft_Pig_Group_Genetics'
	EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

	-- This query will create a lookup table for all pig groups with a wean date 01/01/2014 and later.
	-- This query excludes pig groups with phases not in NUR, FIN, WTF as figuring out when those pigs weaned is not included in this logic.
	-- This query will not figure out genetics for pig groups not assigned to a flow.  The most likely reason a pig group is not in the cft_Pig_Group_Genetics table if the 
	--    phase and starting date are in the included pig groups is because it has no pig flow assigned.  This is found in [$(SolomonApp)].dbo.cftpiggroup.cf08.  If this value is 0,
	--    then the pig group is in an unknown flow and can't be matched back to a sow farm source based upon the below logic.

	INSERT INTO  dbo.cft_Pig_Group_Genetics (
		  PigGroupID 
		, TaskID 
		, PigFlowID 
		, PigFlowDescription 
		, ReportingGroupID 
		, SowTotalWeanedOnPicWeek 
		, PigChampGeneticName
		, EstWeanPicYear_Wk 
		, [% Genetics] 
		, GeneticsPercentageOrder)
	select RIGHT(rtrim(st.PigGroupID),LEN(rtrim(st.PigGroupID))-2) as PigGroupID
		 , st.PigGroupID as TaskID
		 , st.pigflowid
		 , st.PigFlowDescription
		 , st.ReportingGroupID
		 , st.SowTotalWeanedOnPicWeek
		 , gt.PigChampGeneticName
		 , st.EstWeanPicYear_Wk
		 , case when st.SowTotalWeanedOnPicWeek <= 0 then 0.0 else cast(round(cast(gt.WeanQty as decimal)/cast(st.SowTotalWeanedOnPicWeek as decimal), 4)*100 as decimal(5,2)) end as '% Genetics'
		 , ROW_NUMBER () OVER (PARTITION BY st.PigGroupID
								ORDER BY st.PigGroupID,
			case when st.SowTotalWeanedOnPicWeek <= 0 then 0.0 else cast(round(cast(gt.WeanQty as decimal)/cast(st.SowTotalWeanedOnPicWeek as decimal), 4)*100 as decimal(5,2)) end DESC) AS [GeneticsPercentageOrder]
	from ( -- (st)
			-- Get total pigs weaned on estimated PicWeek for source farm of pigs
			select rd.PigGroupID
				 , rd.PigFlowDescription
				 , rd.PigFlowID
				 , rd.ReportingGroupID
				 , rd.EstWeanPicYear_Wk
				 , sum(rd.WeanQty) as SowTotalWeanedOnPicWeek
			from ( -- (rd)
					-- Get Genetics and Wean counts by genetic and associate to pig group based upon estimated wean date for the pig group
					select cpg.TaskID as PigGroupID 
							, cpf.PigFlowDescription, cpf.ReportingGroupID, cpg.cf08 as PigFlowID
							, d.PICYear_Week as EstWeanPicYear_Wk
						   , weaninfo.PigChampGeneticName
						   , SUM(WeanInfo.WeanQty) as WeanQty
						  from [$(SolomonApp)].dbo.cftPigGroup cpg
						  Left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW cpf on cpg.CF08=cpf.PigFlowID and cpf.PigFlowID <> 0
						  Left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW_FARM ff on ff.PigFlowID=cpf.PigFlowID and cpg.CF08=ff.PigFlowID and cpf.PigFlowID <> 0
						  left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo d with (nolock) 
									on d.DayDate = case when cpg.PigProdPhaseID = 'FIN' then (dateadd(d, -(6.5*7), cpg.ActStartDate)) else cpg.ActStartDate end
						  Left Join  dbo.cft_SowMart_WP_Genetic_Rollup as WeanInfo on WeanInfo.WeanPICYearWK = d.PICYear_Week and 
															WeanInfo.FARM_ContactID=ff.ContactID
						 Where cpg.ActStartDate > '20140101'
						   and ((cpg.CF08=0 and cpg.PigProdPhaseID not in ( 'ISO', 'HIN', 'TEF'))
							   or cpg.CF08 <> 0)
						   and WeanInfo.WeanPICYearWK is not null
						   and cpg.PigProdPhaseID in ('WTF','FIN','NUR')
						   --and cpg.TaskID in ('PG55246','PG55248','PG55250')
					group by cpg.TaskID, cpg.SiteContactID, cpg.ActStartDate, cpg.ActCloseDate, cpg.PigProdPhaseID
							, cpf.PigFlowDescription, cpf.PigFlowID, cpf.ReportingGroupID, cpg.CF08
							, d.PICYear_Week
							, WeanInfo.PigChampGeneticName
					Having PigChampGeneticName is not null) rd
			group by PigGroupID
				 , PigFlowDescription
				 , PigFlowID
				 , ReportingGroupID
				 , rd.EstWeanPicYear_Wk) st
	INNER JOIN (	-- Get Genetics and Wean counts by genetic and associate to pig group based upon estimated wean date for the pig group
					select cpg.TaskID as PigGroupID 
						   , weaninfo.PigChampGeneticName
						   , SUM(WeanInfo.WeanQty) as WeanQty
						  from [$(SolomonApp)].dbo.cftPigGroup cpg
						  Left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW cpf on cpg.cf08=cpf.PigFlowID and cpf.PigFlowID <> 0
						  Left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW_FARM ff on ff.PigFlowID=cpf.PigFlowID and cpg.CF08=ff.PigFlowID and cpf.PigFlowID <> 0
						  left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo d with (nolock) 
									on d.DayDate = case when cpg.PigProdPhaseID = 'FIN' then (dateadd(d, -(6.5*7), cpg.ActStartDate)) else cpg.ActStartDate end
						  Left Join  dbo.cft_SowMart_WP_Genetic_Rollup as WeanInfo on WeanInfo.WeanPICYearWK = d.PICYear_Week and 
															WeanInfo.FARM_ContactID=ff.ContactID
						 Where cpg.ActStartDate > '20140101'
						   and ((cpg.CF08=0 and cpg.PigProdPhaseID not in ( 'ISO', 'HIN', 'TEF'))
							   or cpg.CF08 <> 0)
						   and WeanInfo.WeanPICYearWK is not null
						   and cpg.PigProdPhaseID in ('WTF','FIN', 'NUR')
						   --and cpg.TaskID in ('PG55246','PG55248','PG55250')
					group by cpg.TaskID, cpg.SiteContactID, cpg.ActStartDate, cpg.ActCloseDate, cpg.PigProdPhaseID
							, cpf.PigFlowDescription, cpf.ReportingGroupID, cpg.CF08
							, d.PICYear_Week
							, WeanInfo.PigChampGeneticName
					Having PigChampGeneticName is not null) gt on gt.PigGroupID=st.PigGroupID

	SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	SET @RecordsProcessed = @RowCount
	SET @Comments = 'Completed successfully - Insert data into Table  dbo.cft_Pig_Group_Genetics, '
					+ CAST(@RecordsProcessed AS VARCHAR)
					+ ' records processed'
	IF @LOG='Y' or @Error!=0 BEGIN
		EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
							 @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
	SET  @StepMsg = @Comments
	EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg
	
END
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
IF @LOG='Y' or @Error!=0 BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
END

EXEC [$(CFFDB)].dbo.cfp_PrintTs 'End'

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