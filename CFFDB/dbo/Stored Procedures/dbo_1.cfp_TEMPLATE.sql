








CREATE  PROCEDURE [dbo].[cfp_TEMPLATE]
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

exec CFFDB.dbo.cfp_PrintTs  'start 1'
exec 
exec CFFDB.dbo.cfp_PrintTs 'end 1'

Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-08-04  Dan Bryskin Put it in the template, performance optimizations

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
SET @ProcessName        = 'cfp_TEMPLATE'
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
	EXEC CFFDB.dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate,
					   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
-------------------------------------------------------------------------------
-- Truncate Data prior to load
-------------------------------------------------------------------------------
SET  @StepMsg = 'Truncate Data prior to load'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;
TRUNCATE TABLE SolomonApp_dw.dbo.cft_PACKER_DETAIL
	SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Insert daily info
-------------------------------------------------------------------------------
SET  @StepMsg = 'Insert daily info'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

INSERT INTO SolomonApp_dw.dbo.cft_PACKER_DETAIL
(	CarcassID
	,PMLoadID
	,SiteContactID
	,BarnNbr
	,PigGroupID
	,PkrContactID
	,TotalHead
	,HotWgt)

	Select
	PD.CarcassID,
	PSR.PMLoadID,
	PSR.SiteContactID,
	PSR.BarnNbr,
	PSR.PigGroupID,
	PSR.PkrContactID,
	PD.TotalHead,
	PD.HotWgt

	From (
	
	Select 
	RecordID as 'CarcassID',
	002936 as 'PlantID',
	KillDate as 'KillDate',
	TattooNbr as 'TattooNbr',
	1 as 'TotalHead',
	HotWgt as 'HotWgt'
	from Solomonapp.dbo.cftPSDetTriumph
	where KillDate >= GetDate() - 365

	union

	Select 
	RecordID as 'CarcassID',
	Case when PlantNbr = 48 then 000554 else 000555 end as 'PlantID',
	KillDate as 'KillDate',
	TattooNbr as 'TattooNbr',
	1 as 'TotalHead',
	HotWeight as 'HotWgt'
	from Solomonapp.dbo.cftPSDetSwift
	where KillDate >= GetDate() - 365
	and ExceptionCode not in ('N','C','X','D')

	union

	Select
	RecordID as 'CarcassID', 
	000823 as 'PlantID',
	KillDate as 'KillDate',
	Tattoo as 'TattooNbr',
	TotalHead as 'TotalHead',
	Case when TotalHead = 0 then 0 else HotCarcassWeight/TotalHead end as 'HotWgt'
	from Solomonapp.dbo.cftPSDetTyson
	where KillDate >= GetDate() - 365) PD
	
	left join (
	
	Select Distinct
	
	PMLoadID,
	SiteContactID,
	BarnNbr,
	PigGroupID,
	PkrContactID,
	KillDate,
	TattooNbr
	
	from Solomonapp.dbo.cfvPigSaleREV 
	
	where SaleTypeID = 'MS') PSR
	on PD.PlantID = PSR.PkrContactID
	and PD.KillDate = PSR.KillDate 
	and PD.TattooNbr = PSR.TattooNbr
	Where PD.KillDate >= GetDate() - 365
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
	EXEC CFFDB.dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
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