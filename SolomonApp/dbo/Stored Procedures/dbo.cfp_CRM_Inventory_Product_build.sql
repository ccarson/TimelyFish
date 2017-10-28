

CREATE  PROCEDURE [dbo].[cfp_CRM_Inventory_Product_build]
					@LOG char(1)='Y'
AS
BEGIN
/*
===============================================================================
Purpose: Build a delta file of changes to inventory product for the CRM upload

Inputs:	solomonapp.dbo.inventory and itemsite
Outputs:    updated solomonapp.dbo.cft_CRM_inventory_product_delta, current, prior
Returns:    0 for success, 1 for failure
Enviroment:    Test, Production 

DEBUG:

exec CFFDB.dbo.cfp_PrintTs  'start 1'
exec 
exec CFFDB.dbo.cfp_PrintTs 'end 1'

Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2015-01-09  SRipley	    Initial 

===============================================================================
*/

-------------------------------------------------------------------------------
-- Standard proc settings
-------------------------------------------------------------------------------
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
set xact_abort on;	-- auto rollback current transaction when statement raises a run-time error
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
SET @ProcessName        = 'cfp_CRM_Inventory_Product_build'
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
-- Truncate Data [SolomonApp].[dbo].[cft_CRM_product_inventory_delta]  prior to load
-------------------------------------------------------------------------------
SET  @StepMsg = 'Truncate Data [SolomonApp].[dbo].[cft_CRM_product_inventory_delta] prior to load'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;
TRUNCATE TABLE [SolomonApp].[dbo].[cft_CRM_product_inventory_delta]
	SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Truncate Data [SolomonApp].[dbo].[cft_CRM_product_inventory_prior]  prior to load
-------------------------------------------------------------------------------
SET  @StepMsg = 'Truncate Data [SolomonApp].[dbo].[cft_CRM_product_inventory_prior] prior to load'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;
TRUNCATE TABLE [SolomonApp].[dbo].[cft_CRM_product_inventory_prior]
	SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Move current data to prior 
-------------------------------------------------------------------------------
SET  @StepMsg = 'move current to prior'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

INSERT INTO [SolomonApp].[dbo].[cft_CRM_product_inventory_prior]
(	[invtid]
	  , lupd_datetime
      ,[descr]
      ,[invtype]
      ,[transtatuscode]
      ,[dfltsounit]
      ,[cost])
Select [invtid]
	  , lupd_datetime
      ,[descr]
      ,[invtype]
      ,[transtatuscode]
      ,[dfltsounit]
      ,[cost]
from [SolomonApp].[dbo].[cft_CRM_product_inventory_current]
	
		SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

-------------------------------------------------------------------------------
-- Truncate Data [SolomonApp].[dbo].[cft_CRM_product_inventory_current]  prior to load
-------------------------------------------------------------------------------
SET  @StepMsg = 'Truncate Data [SolomonApp].[dbo].[cft_CRM_product_inventory_current] prior to load'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;
TRUNCATE TABLE [SolomonApp].[dbo].[cft_CRM_product_inventory_current]
	SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load current 
-------------------------------------------------------------------------------
SET  @StepMsg = 'Insert current data'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

INSERT INTO [SolomonApp].[dbo].[cft_CRM_product_inventory_current]
(	[invtid]
	  , lupd_datetime
      ,[descr]
      ,[invtype]
      ,[transtatuscode]
      ,[dfltsounit]
      ,[cost])
select invtid, lupd_datetime, descr, invtype, transtatuscode, dfltsounit
, case when sum_qoh <> 0 then costqty/sum_qoh
       when sum_qoh = 0 and cost <> 0 then  cost
       when sum_qoh = 0 and cost = 0 and valmthd <> 'A' then stdcost
       when sum_qoh = 0 and cost = 0 and valmthd = 'A' then lastcost
       else 0
  end cost
from 
(
SELECT 
       i.InvtID, i.classid
      ,LUpd_DateTime
       ,Descr
       ,CASE WHEN InvtType IN('f','r','O','S') THEN 'Inventory'
              WHEN InvtType IN('L','D') THEN 'Service'
              ELSE 'Non-Inventory'
              END AS InvType
       ,TranStatusCode
       ,DfltSOUnit
       , case when (InvtType IN ('L','d','o') or classid = 'ex')  then stdcost else lastcost end cost
       , isite.costqty, isite.sum_qoh, i.valmthd, i.stdcost, i.lastcost
FROM solomonapp.dbo.Inventory (NOLOCK) I
join (select invtid, sum(avgcost*qtyonhand) costqty, sum(qtyonhand) sum_qoh
            from solomonapp.dbo.itemsite (nolock)
            group by invtid ) isite
                  on isite.invtid = i.invtid
WHERE TranStatusCode IN ('AC','IN')
and i.invtid not like '0%'
and i.invtid not like ' 0%'  

)xx
	
		SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

-------------------------------------------------------------------------------
-- Load delta 
-------------------------------------------------------------------------------
SET  @StepMsg = 'Insert delta data'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

insert into [SolomonApp].[dbo].[cft_CRM_product_inventory_delta]
select [invtid]
	  , getdate()
      ,[descr]
      ,[invtype]
      ,[transtatuscode]
      ,[dfltsounit]
      ,[cost]
From
(SELECT [invtid]
      ,[descr]
      ,[invtype]
      ,[transtatuscode]
      ,[dfltsounit]
      ,[cost]
  FROM [SolomonApp].[dbo].[cft_CRM_product_inventory_current]
except
SELECT [invtid]
      ,[descr]
      ,[invtype]
      ,[transtatuscode]
      ,[dfltsounit]
      ,[cost]
  FROM [SolomonApp].[dbo].[cft_CRM_product_inventory_prior]
) xx

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

	  







