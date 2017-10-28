
CREATE PROCEDURE [dbo].[cfp_cube_KILLDBFinal2_Trucking]
                              @LOG char(1)='Y'
AS
BEGIN


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
SET @ProcessName        = 'cpf_cube_KILLDBFinal2_Trucking'
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
-- Load temp table #potrk
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load [$(CFFDB)].dbo.cftKillDBfinal2_Trucking_detail'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;


TRUNCATE TABLE 
    [$(CFFDB)].dbo.cftKillDBfinal2_Trucking_detail ; 

      
-------------------------------------------------------------------------------
-- Load temp table
-------------------------------------------------------------------------------
INSERT INTO
    [$(CFFDB)].dbo.cftKillDBfinal2_Trucking_detail
SELECT 
	pod.InvtID
  , pod.PONbr
  , pod.PurSub
  , pod.PurAcct
  , pod.TaskID
  , ap.PerPost
  , ap.VendId
  , ap.FiscYr
  , ap.TranAmt
  , ps.PMLoadId
  , pm.MovementDate
  , ps.SaleDate
  , ps.SiteContactID
  , ps.ContrNbr
  , cs.ContactName as [SiteName]
  , ps.PkrContactId,ps.SaleTypeId
  , cp.contactname as [PackerName]
  , dd.PICYear_Week as [Time]
  ,	CASE
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
--	Old expression for MarketManager, using scalar function
--	,isnull([$(SolomonApp)].dbo.GetMktManagerNm(ps.SiteContactID,ps.SaleDate,'1/1/1900'),'No Market Manager') as [MarketManager]	  

--	new expression for MarketManager, using table-valued function
  , CASE 
        WHEN mktManager.ContactName IS NULL     THEN  'No Market Manager' 
        WHEN mktManager.ContactID = '004795'    THEN  'No Market Manager' 
        ELSE mktManager.ContactName 
    END as [MarketManager]

  , ISNULL(rtrim(gt.Description),'No Gender') as [Gender]
  , CASE 
		WHEN pm2.marketsaletypeid = '10' Then 'Top Load'
        WHEN pm2.marketsaletypeid = '20' Then 'Second Top'
        WHEN pm2.marketsaletypeid = '25' Then 'Third Top'
        WHEN pm2.marketsaletypeid = '30' Then 'Market Load'
        ELSE 'No LoadType'                      
	END AS [LoadType]
  , ps.CpnyID as [Company]
  , ap.TranAmt  AS [Trucking]
FROM 
	[$(SolomonApp)].dbo.PurOrdDet AS pod
INNER JOIN 
	[$(SolomonApp)].dbo.PurchOrd AS po 
		ON po.PONbr=pod.PONbr
LEFT JOIN 
	[$(SolomonApp)].dbo.cftPM pm 
		on pm.PMID=pod.User5
INNER JOIN 
	[$(SolomonApp)].dbo.APTran AS ap 
		ON ap.PONbr=pod.PONbr and ap.POLineRef=pod.LineRef
INNER JOIN(
	SELECT 
		PkrContactID,SaleDate,PMLoadID,SiteContactID,PigGroupID,OrdNbr,ContrNbr,CpnyID,MIN(SaleBasis) as [SaleBasis],MIN(SaleTypeId) as [SaleTypeID]
	FROM 
		[$(SolomonApp)].dbo.cfvPIGSALEREV
	GROUP BY PkrContactID,SaleDate,PMLoadID,SiteContactID,PigGroupID,OrdNbr,ContrNbr,CpnyID
	) AS ps
		ON ps.PMLoadId=pm.PMLoadID
LEFT JOIN 
	[$(SolomonApp)].dbo.cftContact AS cs 
		on cs.ContactID=pm.SourceContactID
LEFT JOIN 
	[$(SolomonApp)].dbo.cftPigGroup AS pg 
		ON ps.PigGroupID = pg.PigGroupID
LEFT JOIN 
	[$(SolomonApp)].dbo.cftPigGenderType AS gt 
		ON pg.PigGenderTypeID = gt.PigGenderTypeID
LEFT JOIN 
	[$(SolomonApp)].dbo.cftPSOrdHdr AS ord 
		ON ps.OrdNbr = ord.OrdNbr
LEFT JOIN(
	select distinct pmid, marketsaletypeid from [$(SolomonApp)].dbo.cftPM) AS pm2 
		on pm2.PMID = ps.PMLoadId
LEFT JOIN 
	[$(SolomonApp)].dbo.cftContact AS cp 
		on cp.ContactID=ps.PkrContactId
LEFT JOIN 
	[$(SolomonApp)].dbo.cftPSType AS pst 
		ON ps.SaleTypeId=pst.SalesTypeId
LEFT JOIN 
	[$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo AS dd 
		ON ps.SaleDate=dd.DayDate
--	invoking table-valued function to return market manager data 
OUTER APPLY
    [$(SolomonApp)].dbo.cff_tvf_GetMarketServiceManager( ps.SiteContactID, ps.SaleDate ) AS mktManager

WHERE
	pod.PurAcct='40150' ;

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;

SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
      BEGIN
      EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
      END
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg
      
-------------------------------------------------------------------------------
-- Load table cftKillDBfinal2_Trucking
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load cftKillDBfinal2_Trucking'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

TRUNCATE TABLE 
    [$(CFFDB)].dbo.cftKillDBfinal2_Trucking ;

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;

INSERT INTO 
	[$(CFFDB)].dbo.cftKillDBfinal2_Trucking
SELECT 
	Time
  , Packer
  , [Sales Type]
  , [MarketManager]
  , Gender
  , LoadType
  , Company
  , SUM(Trucking) 
FROM 
	[$(CFFDB)].dbo.cftKillDBfinal2_Trucking_detail
GROUP BY
	Time
  , Packer
  , [Sales Type]
  , [MarketManager]
  , Gender
  , LoadType
  , Company ;
  
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

