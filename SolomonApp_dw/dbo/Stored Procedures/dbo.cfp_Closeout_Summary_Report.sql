










CREATE  PROCEDURE [dbo].[cfp_Closeout_Summary_Report]
					@LOG char(1)='Y'
AS
BEGIN
/*
===============================================================================
Purpose: 

Inputs:
Outputs:    
Returns:    0 for success, 1 for failure
Enviroment:    Test, Production 

DEBUG:

exec [$(CFFDB)].dbo.cfp_PrintTs  'start 1'
exec 
exec [$(CFFDB)].dbo.cfp_PrintTs 'end 1'

Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-11-16	S Ripley	 initial release


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
SET @ProcessName        = 'cfp_Closeout_Summary_Report'
SET @ProcessStatus      = 0
SET @StartDate          = GETDATE()
SET @RecordsProcessed   = 0
SET @Comments           = 'Started Successfully'
SET @Error              = 0
SET @Criteria           = 
		'@LOG= ' + CAST(@LOG AS VARCHAR) 
-------------------------------------------------------------------------------
-- Log the start of the procedure
-------------------------------------------------------------------------------
IF @LOG='Y' 
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate,
					   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
-------------------------------------------------------------------------------
-- Truncate Data prior to load
-------------------------------------------------------------------------------
SET  @StepMsg = 'Truncate Data prior to load'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;
TRUNCATE TABLE  dbo.cft_Closeout_Summary_Report
	SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Insert daily info
-------------------------------------------------------------------------------
SET  @StepMsg = 'Insert daily info'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

INSERT INTO  dbo.cft_Closeout_Summary_Report
Select gr.TaskID, gr.Description, bs.BaseSource SowSource, pf.PigFlowDescription PigFlow, PigStartDate, PigEndDate, wk.PicYear_Week, 
right(wk.FiscalYear,2)+'Per'+ Case when wk.FiscalPeriod<10 then '0'+Cast(wk.FiscalPeriod as varchar) else Cast(wk.FiscalPeriod as varchar) end Period,
gr.PGStatusID, gr.PigGenderTypeID, Phase, PhaseDesc, SvcManager, SrSvcManager, c.ContactName,
LivePigDays, DeadPigDays, TotalPigDays, Feed_Qty, TransferIn_Qty, MoveIn_Qty, MoveOut_Qty, PigDeath_Qty, TransferOut_Qty, 
TransferToTailender_Qty, HeadSold, TotalHeadProduced, Prim_Qty, Cull_Qty, DeadPigsToPacker_Qty, TransportDeath_Qty, InventoryAdjustment_Qty, 
Top_Qty, TransferIn_Wt, MoveIn_Wt, MoveOut_Wt, TransferOut_Wt, TransferToTailender_Wt, Prim_Wt, Cull_Wt, DeadPigsToPacker_Wt, TransportDeath_Wt, 
Top_Wt, AverageMarket_Wt, WeightGained, HeadStarted, AverageDailyGain, FeedToGain, AdjFeedToGain, Mortality,  
AveragePurchase_Wt, AverageOut_Wt, AverageDailyFeedIntake, Tailender_Pct, DeadPigsToPacker_Pct, Cull_Pct, NoValue_Pct, MedicationCost, 
MedicationCostPerHead, MedicationCostPerHeadSold, VaccinationCost, VaccinationCostPerHeadSold, FeedCost, HeadCapacity, DaysInGroup, 
PigCapacityDays, EmptyDays, EmptyCapacityDays, CapacityDays, TotalCapacityDays, AverageDaysInGroup, AverageEmptyDays, Utilization, 
FeedCostPerHundredGain, TotalHeadProduced+MoveOut_Qty HeadForAdjFG, 
(TotalHeadProduced+MoveOut_Qty)*AdjFeedToGain ForAdjFGCalc
from dbo.cft_Pig_Group_Rollup gr
left join dbo.cft_PIG_GROUP_BASE_SOURCE bs on right(rtrim(gr.TaskId),5)=bs.PigGroupId
join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo wk on gr.pigenddate=wk.daydate
left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW pf on gr.PigFlowID=pf.PigFlowID
left join [$(SolomonApp)].dbo.cftPigGroup pg on gr.TaskID=pg.TaskID
left join [$(SolomonApp)].dbo.cftContact c on pg.FeedMillContactID=c.ContactID
where wk.DayDate > GETDATE()-730
and Phase in ('NUR', 'FIN', 'WTF')    -- requested by user 2011-12 smr 'It only needs to pull in phases Nur, FIN, and WTF and can exclude all of the others.'
order by wk.DayDate

		SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
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
IF @LOG='Y' or @Error!=0
	BEGIN
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
