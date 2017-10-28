

CREATE  PROCEDURE [dbo].[cfp_cube_KILLDBFinal2]
                              @LOG char(1)='Y'
AS
BEGIN
/*
===============================================================================
Purpose: Prepare data for loading into a cube

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
SET @ProcessName        = 'cpf_cube_KILLDBFinal2'
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
-- Load table cftKillDBfinal2_stg
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cftKillDBfinal2_stg'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg   ; 


TRUNCATE TABLE 
    [$(CFFDB)].dbo.cftKillDBfinal2_stg ; 

WITH 
    cteData AS( 
        SELECT
            dd.PICYear_Week
          , CASE
	            WHEN ltrim(rtrim(ps.ContrNbr)) = '000016'  THEN ltrim(rtrim(cp.contactname))+' Cargill'
	            WHEN ltrim(rtrim(ps.ContrNbr)) = '000023'  THEN ltrim(rtrim(cp.contactname))+' Clarkfield'
	            WHEN ord.PSOrdTYpe = 'O' and ord.Descr not like 'SBF%' THEN ltrim(rtrim(cp.contactname))+' Open'
	            WHEN ord.PSOrdTYpe = 'O' and ord.Descr like 'SBF%' THEN ltrim(rtrim(cp.contactname))+' Open SBF'      
	            WHEN ord.PSOrdTYpe <> 'O' and ord.Descr like 'SBF%' then ltrim(rtrim(cp.contactname))+' SBF'  
	            WHEN ltrim(rtrim(ps.ContrNbr)) = '000023' and ord.Descr like 'SBF%' THEN ltrim(rtrim(cp.contactname))+' Clarkfield SBF'                 
	            ELSE ltrim(rtrim(cp.contactname)) 
            END AS [Packer]
          , CASE 
                WHEN ltrim(rtrim(pst.Descr)) = 'Butcher' Then 'Butcher Sale'
                WHEN ltrim(rtrim(pst.SalesTypeId)) = 'MS' Then ltrim(rtrim(pst.Descr))+ ' ' + ltrim(rtrim(ps.SaleBasis))
                else ltrim(rtrim(pst.Descr)) 
            END AS [Sales Type]	
          , CASE 
                WHEN mktManager.ContactName IS NULL     THEN  'No Market Manager' 
                WHEN mktManager.ContactID = '004795'    THEN  'No Market Manager' 
                ELSE mktManager.ContactName 
            END as [MarketManager]
          , isnull(gt.Description,'No Gender') as [Gender]
          , CASE 
                WHEN pm.marketsaletypeid = '10' Then 'Top Load'
	            WHEN pm.marketsaletypeid = '20' Then 'Second Top'
	            WHEN pm.marketsaletypeid = '25' Then 'Third Top'
	            WHEN pm.marketsaletypeid = '30' Then 'Market Load'
	            else 'No LoadType'                      
	        end as [LoadType]
          , ps.CpnyID
          , ps.HCTot
          , ps.DelvLiveWgt as [LiveWt]
          , ps.DelvCarcWgt
          , ps.AmtCheck
          , ps.AmtBaseSale AS [Base Dollars]
          , ps.AmtGradePrem AS PL
          , ps.AmtNPPC AS NPPC
          , ps.AmtInsect AS Insect
          , ps.AmtOther AS Other
          , ps.AmtScale AS Scale
          , ps.AmtSortLoss AS SortLoss
          , ps.AmtTruck AS Trucking
          , ps.AmtTruckAllow AS TruckAllow
          , ps.AmtDefer AS [Deferred]
        FROM 
            [$(SolomonApp)].dbo.cfvPIGSALEREV ps
        LEFT JOIN 
            [$(SolomonApp)].dbo.cftPigGroup pg 
                ON ps.PigGroupID = pg.PigGroupID
        LEFT JOIN 
            [$(SolomonApp)].dbo.cftPigGenderType gt 
                ON pg.PigGenderTypeID = gt.PigGenderTypeID
        LEFT JOIN 
            [$(SolomonApp)].dbo.cftContact cp 
                on cp.ContactID=ps.PkrContactId
        LEFT JOIN 
            [$(SolomonApp)].dbo.cftPSOrdHdr ord 
                ON ps.OrdNbr = ord.OrdNbr
        LEFT JOIN (
            select distinct pmid, marketsaletypeid from [$(SolomonApp)].dbo.cftPM) pm
                on pm.PMID = ps.PMLoadId
        LEFT JOIN 
            [$(SolomonApp)].dbo.cftPSType pst 
                ON ps.SaleTypeId=pst.SalesTypeId
        LEFT JOIN 
            [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dd 
                ON ps.SaleDate=dd.DayDate
        OUTER APPLY
            [$(SolomonApp)].dbo.cff_tvf_GetMarketServiceManager( ps.SiteContactID, ps.SaleDate ) AS mktManager
        WHERE
            ps.SaleDate >= '1/3/2010' AND ps.OrdNbr<>'005605' ) 
INSERT INTO 
    [$(CFFDB)].dbo.cftKillDBfinal2_stg
SELECT 
    PICYear_Week
  , Packer
  , [Sales Type]	
  , [MarketManager]
  , [Gender]
  , [LoadType]
  , CpnyID
  , SUM(HCTot)
  , SUM(LiveWt)
  , SUM(DelvCarcWgt)
  , SUM(AmtCheck)
  , SUM([Base Dollars])
  , SUM(PL)
  , SUM(NPPC)
  , SUM(Insect)
  , SUM(Other)
  , SUM(Scale)
  , SUM(SortLoss)
  , SUM(Trucking)
  , SUM(TruckAllow)
  , SUM(Deferred)
FROM 
    cteData
GROUP BY 
    PICYear_Week
  , Packer
  , [Sales Type]	
  , [MarketManager]
  , [Gender]
  , [LoadType]
  , CpnyID ; 


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded #KillDB_final2, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
      BEGIN
      EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
      END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

----------- end of process
               
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

