
CREATE PROCEDURE [dbo].[cfp_reload_cft_SowMart_WP_Genetic_Rollup] @LOG char(1)='Y' AS
BEGIN
/*
===============================================================================
Purpose: This procedure attempts to pull together all the wean information by sire genetics since January 1st, 2013.
	     Sire Genetics buckets created by Dan Marti October 2015
Inputs: Log - defaults to "Y"
Outputs:    

exec dbo.cfp_reload_cft_SowMart_WP_Genetic_Rollup  'Y'

Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2015-10-27 Brian Diehl	Created
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
	SET @ProcessName        = 'cfp_reload_cft_SowMart_WP_Genetic_Rollup'
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
	SET  @StepMsg = 'Truncate Table  dbo.cft_SowMart_WP_Genetic_Rollup'
	EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg
	
	truncate table  dbo.cft_SowMart_WP_Genetic_Rollup
	
	
	SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	SET @RecordsProcessed = @RowCount
	SET @Comments = 'Completed successfully - Truncate Table  dbo.cft_SowMart_WP_Genetic_Rollup, '
					+ CAST(@RecordsProcessed AS VARCHAR)
					+ ' records processed'
	IF @LOG='Y' or @Error!=0 BEGIN
		EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
							 @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
	SET  @StepMsg = @Comments
	EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

	--drop table  dbo.cft_SowMart_WP_Genetic_Rollup
		
		--Create table  dbo.cft_SowMart_WP_Genetic_Rollup (
		--	Farm			varchar(6)
		--   ,FARM_ContactID	int
		--   ,WeanPICYearWK	varchar(6)
		--   ,PigChampGeneticName varchar(30)
		--   ,WeanQty	int
		--) 

	-------------------------------------------------------------------------------
	-- Log the the Step
	-------------------------------------------------------------------------------
	SET  @StepMsg = 'Insert data into Table  dbo.cft_SowMart_WP_Genetic_Rollup'
	EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg
	
	insert into  dbo.cft_SowMart_WP_Genetic_Rollup (
		Farm
	   ,FARM_ContactID
	   ,WeanPICYearWK
	   ,PigChampGeneticName	
	   ,WeanQty	)
		select
			f.farm_name as Farm,
			cast(F.farm_number as INT) AS FARM_ContactID,
			smdd.final_wean_picyear_week as WeanPICYearWK,
			mg.longname as PigChampGeneticName,
			SUM( smdd.wean_qty ) as 'WeanQty'
		from [$(PigCHAMP)].caredata.bh_events me 
		left JOIN [$(PigCHAMP)].caredata.ev_matings em on em.identity_id = me.identity_id and em.event_id = me.event_id
		left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo d on d.DayDate = me.eventdate
		left join [$(PigCHAMP)].careglobal.FARMS f on f.site_id = me.site_id
		left join [$(PigCHAMP)].caredata.BH_IDENTITY_HISTORY ih on ih.identity_id = me.identity_id and ih.site_id = me.site_id
		left join [$(PigCHAMP)].caredata.EV_SEMEN_DELIVERIES sd on sd.identity_id = em.male_identity_id
		left join [$(PigCHAMP)].caredata.GENETICS mg on mg.genetics_id = sd.genetics_id
		Inner join  dbo.cft_SowMart_Detail_data smdd  -- This gets just the 1st mating events, otherwise the data from bh_events and event_type=270 give all mating events.
				on smdd.SowID = ih.primary_identity 
			   and smdd.FarmID = f.farm_name
			   and smdd.mating_date = me.eventdate
			   and smdd.final_wean_picyear_week is not null
		where me.event_type = 270 and me.deletion_date is null
		  and me.eventdate>='1/1/2013' 
		group by 
			f.farm_name,
			f.farm_number,
			mg.longname,
			smdd.final_wean_picyear_week		

	SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	SET @RecordsProcessed = @RowCount
	SET @Comments = 'Completed successfully - Insert data into Table  dbo.cft_SowMart_WP_Genetic_Rollup, '
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