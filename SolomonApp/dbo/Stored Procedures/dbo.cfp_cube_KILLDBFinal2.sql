








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
	EXEC CFFDB.dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate,
					   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
-------------------------------------------------------------------------------
-- create temp table #MktMgrEffDateTable
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table MktMgrEffDateTable'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('tempdb..#MktMgrEffDateTable')) IS NOT NULL
	TRUNCATE TABLE #MktMgrEffDateTable
Else
IF (OBJECT_ID ('tempdb..#MktMgrEffDateTable')) IS NOT NULL
	DROP TABLE #MktMgrEffDateTable

CREATE TABLE #MktMgrEffDateTable (
	[SiteContactID] [char](6) NOT NULL,
	[EffectiveDate] [smalldatetime] NOT NULL,
	[MktManger] [char](50) NOT NULL
	)
	


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load temp table
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load temp table #MktMgrEffDateTable'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

INSERT INTO #MktMgrEffDateTable
SELECT cftMktMgrAssign.SiteContactID
, cftMktMgrAssign.EffectiveDate
--, IIf(Trim$([MktMgrContactID])="","No Service Manager",[ContactName]) AS MktManger
, CASE When Rtrim(ltrim(cftMktMgrAssign.MktMgrContactID)) = '' then 'No Service Manager' else cftContact.ContactName end as MktManger
FROM cftMktMgrAssign 
LEFT JOIN cftContact ON cftMktMgrAssign.MktMgrContactID = cftContact.ContactID
UNION 
Select ContactID,'1/1/1900','No Service Manager' 
from cftSite
ORDER BY cftMktMgrAssign.SiteContactID, cftMktMgrAssign.EffectiveDate;

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;


SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
 IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC CFFDB.dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
SET  @StepMsg = @Comments
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- create temp table #MktMgrEffDateTable2
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table MktMgrEffDateTable2'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('tempdb..#MktMgrEffDateTable2')) IS NOT NULL
	TRUNCATE TABLE #MktMgrEffDateTable2
Else
IF (OBJECT_ID ('tempdb..#MktMgrEffDateTable2')) IS NOT NULL
	DROP TABLE #MktMgrEffDateTable2

CREATE TABLE #MktMgrEffDateTable2 (
	[SiteContactID] [char](6) NOT NULL,
	[EffectiveDate] [smalldatetime] NOT NULL,
	[MarketManager] [char](50) NOT NULL
	)
	


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load temp table
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load temp table #MktMgrEffDateTable2'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

INSERT INTO #MktMgrEffDateTable2
SELECT cftMktMgrAssign.SiteContactID
, cftMktMgrAssign.EffectiveDate
--, IIf(Trim$([MktMgrContactID])="","No Service Manager",[ContactName]) AS MktManger
, CASE When Rtrim(ltrim(cftMktMgrAssign.MktMgrContactID)) = '' then 'No Service Manager' else cftContact.ContactName end as MarketManger
FROM cftMktMgrAssign 
LEFT JOIN cftContact ON cftMktMgrAssign.MktMgrContactID = cftContact.ContactID
UNION 
Select ContactID,'1/1/1900','No Market Manager' 
from cftSite
ORDER BY cftMktMgrAssign.SiteContactID, cftMktMgrAssign.EffectiveDate;

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;


SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
 IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC CFFDB.dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
SET  @StepMsg = @Comments
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg


-------------------------------------------------------------------------------
-- create temp table #PigSaleALl
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table #PigSaleAll'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('tempdb..#PigSaleALl')) IS NOT NULL
	TRUNCATE TABLE #PigSaleAll
Else
IF (OBJECT_ID ('tempdb..#PigSaleAll')) IS NOT NULL
	DROP TABLE #PigSaleAll

CREATE TABLE #PigSaleAll (
	[SaleDate] [smalldatetime] NOT NULL,
	[KillDate] [smalldatetime] NOT NULL,
	[Tattoo] [char](6) NOT NULL,
	[PkrContactId] [char](6) NOT NULL,
	[SiteContactId] [char](6) NOT NULL,
	[PMLoadId] [char](6) NOT NULL,
	[Headcount] [int] NOT NULL,
	[LiveWt] [float] NOT NULL,
	[CarcassWt] [float] NOT NULL,
	[Amount] [float] NOT NULL,
	[Base Dollars] [float] NOT NULL,
	[PL] [float] NOT NULL,
	[NPPC] [float] NOT NULL,
	[Insect] [float] NOT NULL,
	[Other] [float] NOT NULL,
	[Scale] [float] NOT NULL,
	[SortLoss] [float] NOT NULL,
	[Trucking] [float] NOT NULL,
	[TruckAllow] [float] NOT NULL,
	[Deferred] [float] NOT NULL,
	[TaskId] [char] (32) NOT NULL,
	[ContrNbr] [char] (10) NOT NULL,
	[OrdNbr] [char] (10) NOT NULL,
	[SaleTypeId] [char] (2) NOT NULL,
	[SaleBasis] [char] (2) NOT NULL,
	[MasterGroup] [char] (12) NOT NULL
	)
	


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load temp table
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load temp table #PigSaleAll'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

INSERT INTO #PigSaleAll
SELECT cftPigSale.SaleDate, cftPigSale.KillDate, LTRIM(RTRIM(cftPigSale.TattooNbr)) AS Tattoo
, cftPigSale.PkrContactId, cftPigSale.SiteContactID, cftPigSale.PMLoadId
, Sum(cftPigSale.HCTot) AS Headcount
, Sum(cftPigSale.DelvLiveWgt) AS LiveWt
, Sum(cftPigSale.DelvCarcWgt) AS CarcassWt
, Sum(cftPigSale.AmtCheck) AS Amount
, Sum(cftPigSale.AmtBaseSale) AS [Base Dollars]
, Sum(cftPigSale.AmtGradePrem) AS PL
, Sum(cftPigSale.AmtNPPC) AS NPPC
, Sum(cftPigSale.AmtInsect) AS Insect
, Sum(cftPigSale.AmtOther) AS Other
, Sum(cftPigSale.AmtScale) AS Scale
, Sum(cftPigSale.AmtSortLoss) AS SortLoss
, Sum(cftPigSale.AmtTruck) AS Trucking
, Sum(cftPigSale.AmtTruckAllow) AS TruckAllow
, Sum(cftPigSale.AmtDefer) AS [Deferred]
, cftPigSale.TaskId, cftPigSale.ContrNbr, cftPigSale.OrdNbr, cftPigSale.SaleTypeId
, cftPigSale.SaleBasis
, LTRIM(RTRIM('MG' + cftPigGroup.CF03)) AS MasterGroup
FROM 
(cftPigSale 
LEFT JOIN cftPigSale AS rev ON cftPigSale.RefNbr = rev.OrigRefNbr) 
INNER JOIN cftPigGroup ON cftPigSale.PigGroupID = cftPigGroup.PigGroupID
WHERE 
(
 (
	(cftPigSale.SaleTypeId)='MS'
 ) 
	AND 
(
	   (cftPigSale.CustId)='TYS' 
	Or (cftPigSale.CustId)='HOR' 
	Or (cftPigSale.CustId)='SWIFT'
	Or (cftPigSale.CustId)='TRIFOO' 
	Or (cftPigSale.CustId)='TRIOAK'
) 
AND 
(	(cftPigSale.DocType)<>'RE') 
	AND 
	(	(rev.RefNbr) Is Null) 
	AND ((cftPigSale.SaleDate)>='1/3/2010')
)
GROUP BY cftPigSale.SaleDate, cftPigSale.KillDate, LTRIM(RTRIM(cftPigSale.TattooNbr)), cftPigSale.PkrContactId
, cftPigSale.SiteContactID, cftPigSale.PMLoadId, cftPigSale.TaskId, cftPigSale.ContrNbr, cftPigSale.OrdNbr
, cftPigSale.SaleTypeId, cftPigSale.SaleBasis, LTRIM(RTRIM('MG' + cftPigGroup.CF03))
HAVING (((cftPigSale.SaleBasis)<>'LW'));

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;


SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
 IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC CFFDB.dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
SET  @StepMsg = @Comments
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg


-------------------------------------------------------------------------------
-- create temp table SaleSite2
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table #SaleSite2'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('tempdb..#SaleSite2')) IS NOT NULL
	TRUNCATE TABLE #SaleSite2
Else
IF (OBJECT_ID ('tempdb..#SaleSite2')) IS NOT NULL
	DROP TABLE #SaleSite2

CREATE TABLE #SaleSite2 (
	[SaleDate] [smalldatetime] NOT NULL,
	[KillDate] [smalldatetime] NOT NULL,
	[Tattoo] [char](6) NOT NULL,
	[PkrContactId] [char](6) NOT NULL,
	[SiteContactId] [char](6) NOT NULL,
	[PMLoadId] [char](6) NOT NULL,
	[Headcount] [int] NOT NULL,
	[LiveWt] [float] NOT NULL,
	[CarcassWt] [float] NOT NULL,
	[Amount] [float] NOT NULL,
	[Base Dollars] [float] NOT NULL,
	[PL] [float] NOT NULL,
	[NPPC] [float] NOT NULL,
	[Insect] [float] NOT NULL,
	[Other] [float] NOT NULL,
	[Scale] [float] NOT NULL,
	[SortLoss] [float] NOT NULL,
	[Trucking] [float] NOT NULL,
	[TruckAllow] [float] NOT NULL,
	[Deferred] [float] NOT NULL,
	[EffectiveDate] [smalldatetime] NOT NULL,
	[MktManger] [char](50) NOT NULL,
	[TaskId] [char] (32) NOT NULL,
	[ContrNbr] [char] (10) NOT NULL,
	[OrdNbr] [char] (10) NOT NULL,
	[MasterGroup] [char] (12) NOT NULL
	)


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load temp table SaleSite2
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load temp table SaleSite2'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

INSERT INTO #SaleSite2
SELECT #PigSaleAll.SaleDate, #PigSaleAll.KillDate, #PigSaleAll.Tattoo, #PigSaleAll.PkrContactId
, #PigSaleAll.SiteContactID, #PigSaleAll.PMLoadId, #PigSaleAll.Headcount, #PigSaleAll.LiveWt
, #PigSaleAll.CarcassWt, #PigSaleAll.Amount, #PigSaleAll.[Base Dollars], #PigSaleAll.PL, #PigSaleAll.NPPC
, #PigSaleAll.Insect, #PigSaleAll.Other, #PigSaleAll.Scale, #PigSaleAll.SortLoss, #PigSaleAll.Trucking
, #PigSaleAll.TruckAllow, #PigSaleAll.Deferred, #MktMgrEffDateTable.EffectiveDate, #MktMgrEffDateTable.MktManger
, #PigSaleAll.TaskId, #PigSaleAll.ContrNbr, #PigSaleAll.OrdNbr, #PigSaleAll.MasterGroup
FROM #PigSaleAll 
LEFT JOIN #MktMgrEffDateTable ON #PigSaleAll.SiteContactID = #MktMgrEffDateTable.SiteContactID
GROUP BY #PigSaleAll.SaleDate, #PigSaleAll.KillDate, #PigSaleAll.Tattoo, #PigSaleAll.PkrContactId
, #PigSaleAll.SiteContactID, #PigSaleAll.PMLoadId, #PigSaleAll.Headcount, #PigSaleAll.LiveWt
, #PigSaleAll.CarcassWt, #PigSaleAll.Amount, #PigSaleAll.[Base Dollars], #PigSaleAll.PL, #PigSaleAll.NPPC
, #PigSaleAll.Insect, #PigSaleAll.Other, #PigSaleAll.Scale, #PigSaleAll.SortLoss, #PigSaleAll.Trucking
, #PigSaleAll.TruckAllow, #PigSaleAll.Deferred, #MktMgrEffDateTable.EffectiveDate, #MktMgrEffDateTable.MktManger
, #PigSaleAll.TaskId, #PigSaleAll.ContrNbr, #PigSaleAll.OrdNbr, #PigSaleAll.MasterGroup
HAVING #MktMgrEffDateTable.EffectiveDate < #PigSaleAll.SaleDate

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded #SaleSite2, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
 IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC CFFDB.dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
SET  @StepMsg = @Comments
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- create temp table PIGSALEREV
--PIGSALE3
--qryMaxMktMgrEffDate
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table qryMaxMktMgrEffDate'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('tempdb..#qryMaxMktMgrEffDate')) IS NOT NULL
	TRUNCATE TABLE #PIGSALEREV
Else
IF (OBJECT_ID ('tempdb..#qryMaxMktMgrEffDate')) IS NOT NULL
	DROP TABLE #qryMaxMktMgrEffDate

CREATE TABLE #qryMaxMktMgrEffDate (
	[AmtBaseSale] [float] NOT NULL,
	[AmtCheck] [float] NOT NULL,
	[AmtDefer] [float] NOT NULL,
	[AmtGradePrem] [float] NOT NULL,
	[AmtInsect] [float] NOT NULL,
	[AmtInsur] [float] NOT NULL,
	[AmtNPPC] [float] NOT NULL,
	[AmtOther] [float] NOT NULL,
	[AmtScale] [float] NOT NULL,
	[AmtSortLoss] [float] NOT NULL,
	[AmtTruck] [float] NOT NULL,
	[AmtTruckAllow] [float] NOT NULL,
	[ARBatNbr] [char](10) NOT NULL,
	[ARRefNbr] [char](10) NOT NULL,
	[AvgWgt] [float] NULL,
	[BarnNbr] [char](6) NOT NULL,
	[BaseAcct] [char](10) NOT NULL,
	[BasePrice] [float] NOT NULL,
	[BatNbr] [char](10) NOT NULL,
	[ChkPaidNbr] [char](10) NOT NULL,
	[ContrNbr] [char](10) NOT NULL,
	[CpnyID] [char](10) NOT NULL,
	[Crtd_DateTime] [smalldatetime] NOT NULL,
	[Crtd_Prog] [char](8) NOT NULL,
	[Crtd_User] [char](10) NOT NULL,
	[CustId] [char](15) NOT NULL,
	[DelvCarcCWgt] [float] NOT NULL,
	[DelvCarcWgt] [float] NOT NULL,
	[DelvLiveCWgt] [float] NOT NULL,
	[DelvLiveWgt] [float] NOT NULL,
	[DepositDate] [smalldatetime] NOT NULL,
	[DocType] [char](2) NOT NULL,
	[GrpReqFlg] [smallint] NOT NULL,
	[HCTot] [smallint] NOT NULL,
	[HeadCount] [smallint] NOT NULL,
	[KillDate] [smalldatetime] NOT NULL,
	[Lupd_DateTime] [smalldatetime] NOT NULL,
	[Lupd_Prog] [char](8) NOT NULL,
	[Lupd_User] [char](10) NOT NULL,
	[NoteId] [int] NOT NULL,
	[OrdNbr] [char](10) NOT NULL,
	[OrigRefNbr] [char](10) NOT NULL,
	[PigGroupID] [char](10) NOT NULL,
	[PkrContactId] [char](6) NOT NULL,
	[PMLoadId] [char](6) NOT NULL,
	[Project] [char](16) NOT NULL,
	[RefNbr] [char](10) NOT NULL,
	[SaleBasis] [char](2) NOT NULL,
	[SaleDate] [smalldatetime] NOT NULL,
	[SaleTypeId] [char](2) NOT NULL,
	[SiteContactID] [char](6) NOT NULL,
	[TaskId] [char](32) NOT NULL,
	[TattooNbr] [char](6) NOT NULL,
	[TotPigCnt] [smallint] NOT NULL,
	[TrkgPaidFlg] [smallint] NOT NULL,
	[TrkVendID] [char](15) NOT NULL,
	[MaxEffDate] [smalldatetime] NOT NULL)



SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load temp table PIGSALEREV
--PIGSALE3
--qryMaxMktMgrEffDate
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load qryMaxMktMgrEffDate'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

INSERT INTO #qryMaxMktMgrEffDate
SELECT cftPigSale.[AmtBaseSale]
      ,cftPigSale.[AmtCheck]
      ,cftPigSale.[AmtDefer]
      ,cftPigSale.[AmtGradePrem]
      ,cftPigSale.[AmtInsect]
      ,cftPigSale.[AmtInsur]
      ,cftPigSale.[AmtNPPC]
      ,cftPigSale.[AmtOther]
      ,cftPigSale.[AmtScale]
      ,cftPigSale.[AmtSortLoss]
      ,cftPigSale.[AmtTruck]
      ,cftPigSale.[AmtTruckAllow]
      ,cftPigSale.[ARBatNbr]
      ,cftPigSale.[ARRefNbr]
      ,cftPigSale.[AvgWgt]
      ,cftPigSale.[BarnNbr]
      ,cftPigSale.[BaseAcct]
      ,cftPigSale.[BasePrice]
      ,cftPigSale.[BatNbr]
      ,cftPigSale.[ChkPaidNbr]
      ,cftPigSale.[ContrNbr]
      ,cftPigSale.[CpnyID]
      ,cftPigSale.[Crtd_DateTime]
      ,cftPigSale.[Crtd_Prog]
      ,cftPigSale.[Crtd_User]
      ,cftPigSale.[CustId]
      ,cftPigSale.[DelvCarcCWgt]
      ,cftPigSale.[DelvCarcWgt]
      ,cftPigSale.[DelvLiveCWgt]
      ,cftPigSale.[DelvLiveWgt]
      ,cftPigSale.[DepositDate]
      ,cftPigSale.[DocType]
      ,cftPigSale.[GrpReqFlg]
      ,cftPigSale.[HCTot]
      ,cftPigSale.[HeadCount]
      ,cftPigSale.[KillDate]
      ,cftPigSale.[Lupd_DateTime]
      ,cftPigSale.[Lupd_Prog]
      ,cftPigSale.[Lupd_User]
      ,cftPigSale.[NoteId]
      ,cftPigSale.[OrdNbr]
      ,cftPigSale.[OrigRefNbr]
      ,cftPigSale.[PigGroupID]
      ,cftPigSale.[PkrContactId]
      ,cftPigSale.[PMLoadId]
      ,cftPigSale.[Project]
      ,cftPigSale.[RefNbr]
      ,cftPigSale.[SaleBasis]
      ,cftPigSale.[SaleDate]
      ,cftPigSale.[SaleTypeId]
      ,cftPigSale.[SiteContactID]
      ,cftPigSale.[TaskId]
      ,cftPigSale.[TattooNbr]
      ,cftPigSale.[TotPigCnt]
      ,cftPigSale.[TrkgPaidFlg]
      ,cftPigSale.[TrkVendID]
      ,max(#MktMgrEffDateTable2.EffectiveDate)
FROM cftPigSale 
LEFT JOIN cftPigSale AS reverse ON cftPigSale.RefNbr = reverse.OrigRefNbr
LEFT JOIN #MktMgrEffDateTable2 ON cftPigSale.SiteContactID = #MktMgrEffDateTable2.SiteContactID
WHERE #MktMgrEffDateTable2.EffectiveDate < cftPigSale.SaleDate
AND cftPigSale.SaleDate > '12/28/2008' 
AND cftPigSale.ARRefNbr <>'' 
AND cftPigSale.DocType <>'RE' 
AND reverse.RefNbr Is Null
group by cftPigSale.[AmtBaseSale]      ,cftPigSale.[AmtCheck]      ,cftPigSale.[AmtDefer]      ,cftPigSale.[AmtGradePrem]      ,cftPigSale.[AmtInsect]
      ,cftPigSale.[AmtInsur]      ,cftPigSale.[AmtNPPC]      ,cftPigSale.[AmtOther]      ,cftPigSale.[AmtScale]      ,cftPigSale.[AmtSortLoss]      ,cftPigSale.[AmtTruck]
      ,cftPigSale.[AmtTruckAllow]      ,cftPigSale.[ARBatNbr]      ,cftPigSale.[ARRefNbr]      ,cftPigSale.[AvgWgt]      ,cftPigSale.[BarnNbr]      ,cftPigSale.[BaseAcct]
      ,cftPigSale.[BasePrice]      ,cftPigSale.[BatNbr]      ,cftPigSale.[ChkPaidNbr]      ,cftPigSale.[ContrNbr]      ,cftPigSale.[CpnyID]      ,cftPigSale.[Crtd_DateTime]
      ,cftPigSale.[Crtd_Prog]      ,cftPigSale.[Crtd_User]      ,cftPigSale.[CustId]      ,cftPigSale.[DelvCarcCWgt]      ,cftPigSale.[DelvCarcWgt]      ,cftPigSale.[DelvLiveCWgt]
      ,cftPigSale.[DelvLiveWgt]      ,cftPigSale.[DepositDate]      ,cftPigSale.[DocType]      ,cftPigSale.[GrpReqFlg]      ,cftPigSale.[HCTot]      ,cftPigSale.[HeadCount]
      ,cftPigSale.[KillDate]      ,cftPigSale.[Lupd_DateTime]      ,cftPigSale.[Lupd_Prog]      ,cftPigSale.[Lupd_User]      ,cftPigSale.[NoteId]      ,cftPigSale.[OrdNbr]
      ,cftPigSale.[OrigRefNbr]      ,cftPigSale.[PigGroupID]      ,cftPigSale.[PkrContactId]      ,cftPigSale.[PMLoadId]      ,cftPigSale.[Project]      ,cftPigSale.[RefNbr]
      ,cftPigSale.[SaleBasis]      ,cftPigSale.[SaleDate]      ,cftPigSale.[SaleTypeId]      ,cftPigSale.[SiteContactID]      ,cftPigSale.[TaskId]      ,cftPigSale.[TattooNbr]
      ,cftPigSale.[TotPigCnt]      ,cftPigSale.[TrkgPaidFlg]      ,cftPigSale.[TrkVendID]

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded #qryMaxMktMgrEffDate, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC CFFDB.dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- create  table#cft_cube_KillDB_final2
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create table #cft_cube_KillDB_final2'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('tempdb..#cft_cube_KillDB_final2')) IS NOT NULL
	TRUNCATE TABLE #cft_cube_KillDB_final2
Else
IF (OBJECT_ID ('tempdb..#cft_cube_KillDB_final2')) IS NOT NULL
	DROP TABLE #cft_cube_KillDB_final2

CREATE TABLE #cft_cube_KillDB_final2 (
	[PICYear_week] [varchar] (6) NOT NULL,
	[Packer] [char] (50) NOT NULL,
	[Sales Type] [char](30) NOT NULL,
	[MarketManager] [char](30) NOT NULL,
	[Gender] [char](30) NOT NULL,
	[LoadType] [char](30) NOT NULL,
	[CpnyID] [char](10) NOT NULL,
	[Headcount] [smallint] NOT NULL,
	[LiveCWgt] [float] NOT NULL,
	[CarcassWgt] [float] NOT NULL,	
	[Amount] [float] NOT NULL,
	[Base Dollars] [float] NOT NULL,
	[PL] [float] NOT NULL,
	[NPPC] [float] NOT NULL,
	[Insect] [float] NOT NULL,
	[Other] [float] NOT NULL,
	[Scale] [float] NOT NULL,
	[SortLoss] [float] NOT NULL,
	[Trucking] [float] NOT NULL,
	[TruckAllow] [float] NOT NULL,
	[Deferred] [float] NOT NULL	
)



SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load temp table#cft_cube_KillDB_final2
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load#cft_cube_KillDB_final2'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

INSERT INTO #cft_cube_KillDB_final2
SELECT cfvDayDefinition_WithWeekInfo.PICYear_Week, 
CASE WHEN ltrim(rtrim(#qryMaxMktMgrEffDate.ContrNbr)) = '000011' THEN ltrim(rtrim(cftContact.contactname)) 
	 WHEN ltrim(rtrim(#qryMaxMktMgrEffDate.ContrNbr)) = '000016'  THEN ltrim(rtrim(cftContact.contactname))+' Cargill'
	 WHEN cftPSOrdHdr.PSOrdTYpe = 'O' THEN ltrim(rtrim(cftContact.contactname))+' Open'
	 else ltrim(rtrim(cftContact.contactname)) end as Packer,
CASE WHEN ltrim(rtrim(cftPSType.Descr)) = 'Butcher' Then 'Butcher Sale'
	 WHEN ltrim(rtrim(cftPSType.SalesTypeId)) = 'MS' Then ltrim(rtrim(cftPSType.SalesTypeId))+ ' ' + ltrim(rtrim(#qryMaxMktMgrEffDate.SaleBasis))
	 else ltrim(rtrim(cftPSType.Descr)) end as [Sales Type], 
T2.[MarketManager],
isnull(cftPigGenderType.Description,'No Gender') as Gender,
isnull(cftPM2.Description,'No LoadType') as LoadType,
#qryMaxMktMgrEffDate.CpnyID, 
Sum(#qryMaxMktMgrEffDate.HCTot) AS Headcount,
Sum(#qryMaxMktMgrEffDate.DelvLiveWgt) AS LiveWt, 
Sum(#qryMaxMktMgrEffDate.DelvCarcWgt) AS CarcassWt, 
Sum(#qryMaxMktMgrEffDate.AmtCheck) AS Amount, 
Sum(#qryMaxMktMgrEffDate.AmtBaseSale) AS [Base Dollars], 
Sum(#qryMaxMktMgrEffDate.AmtGradePrem) AS PL, 
Sum(#qryMaxMktMgrEffDate.AmtNPPC) AS NPPC, 
Sum(#qryMaxMktMgrEffDate.AmtInsect) AS Insect, 
Sum(#qryMaxMktMgrEffDate.AmtOther) AS Other, 
Sum(#qryMaxMktMgrEffDate.AmtScale) AS Scale, 
Sum(#qryMaxMktMgrEffDate.AmtSortLoss) AS SortLoss, 
Sum(#qryMaxMktMgrEffDate.AmtTruck) AS Trucking, 
Sum(#qryMaxMktMgrEffDate.AmtTruckAllow) AS TruckAllow,
Sum(#qryMaxMktMgrEffDate.AmtDefer) AS [Deferred]
FROM #qryMaxMktMgrEffDate 
	LEFT JOIN #MktMgrEffDateTable2 as T2 ON #qryMaxMktMgrEffDate.SiteContactID = T2.SiteContactID
		 AND #qryMaxMktMgrEffDate.MaxEffDate = T2.EffectiveDate 
	LEFT JOIN cftContact ON #qryMaxMktMgrEffDate.PkrContactId = cftContact.ContactID
	LEFT JOIN cftPSOrdHdr ON #qryMaxMktMgrEffDate.OrdNbr = cftPSOrdHdr.OrdNbr
	LEFT JOIN cftPigGroup ON #qryMaxMktMgrEffDate.PigGroupID = cftPigGroup.PigGroupID
	LEFT JOIN cftPSType ON #qryMaxMktMgrEffDate.SaleTypeId = cftPSType.SalesTypeId
	LEFT JOIN cftPigGenderType ON cftPigGroup.PigGenderTypeID = cftPigGenderType.PigGenderTypeID
	left join (SELECT cftPM.PMID, MST.Description FROM cftPM
				inner join cftMarketSaleType MST on MST.MarketSaleTypeId = cftPM.MarketSaleTypeID) as cftPM2
			on cftPM2.PMID = #qryMaxMktMgrEffDate.PMLoadId
	LEFT JOIN cfvDayDefinition_WithWeekInfo ON #qryMaxMktMgrEffDate.SaleDate = cfvDayDefinition_WithWeekInfo.DayDate
WHERE #qryMaxMktMgrEffDate.SaleDate >= '1/3/2010'
GROUP BY cfvDayDefinition_WithWeekInfo.PICYear_Week,
CASE WHEN ltrim(rtrim(#qryMaxMktMgrEffDate.ContrNbr)) = '000011' THEN ltrim(rtrim(cftContact.contactname)) 
	 WHEN ltrim(rtrim(#qryMaxMktMgrEffDate.ContrNbr)) = '000016'  THEN ltrim(rtrim(cftContact.contactname))+' Cargill'
	 WHEN cftPSOrdHdr.PSOrdTYpe = 'O' THEN ltrim(rtrim(cftContact.contactname))+' Open'
	 else ltrim(rtrim(cftContact.contactname)) end,
CASE WHEN ltrim(rtrim(cftPSType.Descr)) = 'Butcher' Then 'Butcher Sale'
	 WHEN ltrim(rtrim(cftPSType.SalesTypeId)) = 'MS' Then ltrim(rtrim(cftPSType.SalesTypeId))+ ' ' + ltrim(rtrim(#qryMaxMktMgrEffDate.SaleBasis))
	 else ltrim(rtrim(cftPSType.Descr)) end, 
T2.MarketManager, 
isnull(cftPigGenderType.Description,'No Gender'),
isnull(cftPM2.Description,'No LoadType'),
#qryMaxMktMgrEffDate.CpnyID
;


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded #KillDB_final2, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC CFFDB.dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

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

----------
select * 
from #cft_cube_KillDB_final2
--where year = 'CY2004' and time = '04WK43' and locnbr = 'LOC5710'
--and PM like '%056372'





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

	  





