






CREATE  PROCEDURE [dbo].[cfp_cube_ASOSale_SaleType]
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
SET @ProcessName        = 'cfp_cube_ASOSale_SaleType'
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
-- create temp table LoadCrewDates
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table LoadCrewDates'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('tempdb..#LoadCrewDates')) IS NOT NULL
	TRUNCATE TABLE #LoadCrewDates
Else
IF (OBJECT_ID ('tempdb..#LoadCrewDates')) IS NOT NULL
	DROP TABLE #LoadCrewDates

CREATE TABLE #LoadCrewDates (
	[LoadCrewID] [int] NOT NULL,
	[ContactID] [int] NOT NULL,
	[LoadCrewName] [char](50) NOT NULL,
	[AssignedFromDate] [datetime] NOT NULL,
	[AssignedToDate] [datetime] NOT NULL
	)


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load temp table
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load temp table #LoadCrewDates'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

INSERT INTO #LoadCrewDates
SELECT LCS.LoadCrewID, LCS.ContactID, LC.LoadCrewName
, LCS.AssignedFromDate
, CASE WHEN [AssignedToDate] Is Null THEN '12/31/2020' ELSE [AssignedToDate] END as AssignedToDate
FROM CFApp.dbo.cft_LOAD_CREW LC
RIGHT JOIN CFApp.dbo.cft_LOAD_CREW_SITES  LCS ON LC.LoadCrewID = LCS.LoadCrewID;

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
-- create temp table MakeSaleTypeTable1
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table #MakeSaleTypeTable1'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('tempdb..#MakeSaleTypeTable1')) IS NOT NULL
	TRUNCATE TABLE #MakeSaleTypeTable1
Else
IF (OBJECT_ID ('tempdb..#MakeSaleTypeTable1')) IS NOT NULL
	DROP TABLE #MakeSaleTypeTable1

CREATE TABLE #MakeSaleTypeTable1 (
	[PMLoadID] [char](10) NOT NULL,
	[PMID] [char](10) NOT NULL,
	[BatNbr] [char](10) NOT NULL,
	[RefNbr] [char](10) NOT NULL,
	[SaleDate] [smalldatetime] NOT NULL,
	[SiteContactID] [char](6) NOT NULL,
	[PkrContactId] [char] (6) NOT NULL,
	[TaskId] [char](32) NOT NULL,
	[SaleTypeId] [char](2) NOT NULL,
	[PigTypeID] [char](2) NOT NULL,
	[MarketSaleTypeID] [char](2) NOT NULL,
	[MovementDate] [smalldatetime] NOT NULL,
	[DestContactID] [char] (10) NOT NULL,
	[TruckerContactID] [char] (6) NOT NULL,
	[EstimatedQty]	[smallint]  NOT NULL,
	[DetailTypeId] [char] (2) NOT NULL,
	[Qty] [smallint]  NOT NULL,
	[WgtLive] [float] NOT NULL
	)


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load temp table MakeSaleTypeTable1
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load temp table MakeSaleTypeTable1'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

INSERT INTO #MakeSaleTypeTable1
SELECT cftPM.PMLoadID, cftPM.PMID, cfvPIGSALEREV.BatNbr, cfvPIGSALEREV.RefNbr, cfvPIGSALEREV.SaleDate, 
cfvPIGSALEREV.SiteContactID, cfvPIGSALEREV.PkrContactId, cfvPIGSALEREV.TaskId, cfvPIGSALEREV.SaleTypeId, 
cftPM.PigTypeID, cftPM.MarketSaleTypeID, cftPM.MovementDate, cftPM.DestContactID, 
cftPM.TruckerContactID, cftPM.EstimatedQty, cftPSDetail.DetailTypeId, cftPSDetail.Qty, 
cftPSDetail.WgtLive
FROM (cftPM LEFT JOIN cfvPIGSALEREV ON cftPM.PMID = cfvPIGSALEREV.PMLoadId) 
LEFT JOIN cftPSDetail ON (cfvPIGSALEREV.ARBatNbr = cftPSDetail.BatNbr) AND (cfvPIGSALEREV.RefNbr = cftPSDetail.RefNbr)
WHERE (((cfvPIGSALEREV.RefNbr)<>'') 
AND ((cfvPIGSALEREV.SaleTypeId)<>'CS' And (cfvPIGSALEREV.SaleTypeId)<>'MC' 
And (cfvPIGSALEREV.SaleTypeId)<>'CB') AND ((cftPM.PigTypeID)='04'))

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded #MakeSaleTypeTable1, '
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
-- create temp table CrossTabQtyQueryJM
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table CrossTabQtyQueryJM'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('tempdb..#CrossTabQtyQueryJM')) IS NOT NULL
	TRUNCATE TABLE #CrossTabQtyQueryJM
Else
IF (OBJECT_ID ('tempdb..#CrossTabQtyQueryJM')) IS NOT NULL
	DROP TABLE #CrossTabQtyQueryJM

CREATE TABLE #CrossTabQtyQueryJM (
	[SiteID] [char](6) NOT NULL,
	[PMLoadID] [char](10) NOT NULL,
	[SaleDate] [smalldatetime] NOT NULL,
	[Time] [char] (10) NOT NULL,
	[PigGroup] [char](32) NOT NULL,
	[Packer]	[char] (50) NOT NULL,
	[Trucker]	[char] (50) NOT NULL,
	[MilestoPacker] [float] NOT NULL,
	[DetailTypeId] [char] (6) NOT NULL,
	[SumOfQty] [float] NOT NULL
	)



SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load temp table CrossTabQtyQueryJM
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load CrossTabQtyQueryJM'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

INSERT INTO #CrossTabQtyQueryJM
SELECT [SiteContactID] AS SiteID
, #MakeSaleTypeTable1.PMLoadID
, #MakeSaleTypeTable1.SaleDate AS SaleDate
, cfvDayDefinition_WithWeekInfo.PICYear_Week AS [Time]
, #MakeSaleTypeTable1.TaskId AS PigGroup
, cftContact.ContactName AS Packer
, dbo_cftContact_1.ContactName AS Trucker
, vCFContactMilesMatrix.OneWayMiles AS MilesToPacker
, #MakeSaleTypeTable1.DetailTypeId+'_Qty' as DetailedTypeID
, Sum(#MakeSaleTypeTable1.Qty) AS SumOfQty
FROM 
#MakeSaleTypeTable1
INNER JOIN vCFContactMilesMatrix ON (#MakeSaleTypeTable1.PkrContactId = vCFContactMilesMatrix.DestSite) 
			AND (#MakeSaleTypeTable1.SiteContactID = vCFContactMilesMatrix.SourceSite)
INNER JOIN cfvDayDefinition_WithWeekInfo ON #MakeSaleTypeTable1.SaleDate = cfvDayDefinition_WithWeekInfo.DayDate
INNER JOIN cftContact ON #MakeSaleTypeTable1.PkrContactId = cftContact.ContactID 
INNER JOIN cftContact AS dbo_cftContact_1 ON #MakeSaleTypeTable1.TruckerContactID = dbo_cftContact_1.ContactID
GROUP BY [SiteContactID] 
, #MakeSaleTypeTable1.PMLoadID
, #MakeSaleTypeTable1.SaleDate 
, cfvDayDefinition_WithWeekInfo.PICYear_Week 
, #MakeSaleTypeTable1.TaskId 
, cftContact.ContactName
, dbo_cftContact_1.ContactName 
, vCFContactMilesMatrix.OneWayMiles
, #MakeSaleTypeTable1.DetailTypeId
--TRANSFORM Sum(SaleTypeTable1.Qty) AS SumOfQty
--SELECT CInt([SiteContactID]) AS SiteID, SaleTypeTable1.PMLoadID, First(SaleTypeTable1.SaleDate) AS SaleDate
--, First(dbo_cfvDayDefinition_WithWeekInfo.PICYear_Week) AS [Time], First(SaleTypeTable1.TaskId) AS PigGroup
--, First(dbo_cftContact.ContactName) AS Packer, First(dbo_cftContact_1.ContactName) AS Trucker
--, First(dbo_vCFContactMilesMatrix.OneWayMiles) AS MilesToPacker
--FROM (((SaleTypeTable1 INNER JOIN dbo_vCFContactMilesMatrix ON (SaleTypeTable1.PkrContactId = dbo_vCFContactMilesMatrix.DestSite) 
--AND (SaleTypeTable1.SiteContactID = dbo_vCFContactMilesMatrix.SourceSite)) 
--INNER JOIN dbo_cfvDayDefinition_WithWeekInfo ON SaleTypeTable1.SaleDate = dbo_cfvDayDefinition_WithWeekInfo.DayDate) 
--INNER JOIN dbo_cftContact ON SaleTypeTable1.PkrContactId = dbo_cftContact.ContactID) 
--INNER JOIN dbo_cftContact AS dbo_cftContact_1 ON SaleTypeTable1.TruckerContactID = dbo_cftContact_1.ContactID
--GROUP BY CInt([SiteContactID]), SaleTypeTable1.PMLoadID
--PIVOT [DetailTypeId]+"_Qty";

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded #CrossTabQtyQueryJM, '
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
-- truncate table cftASOSaleQty
-------------------------------------------------------------------------------
SET  @StepMsg = 'truncate table cftASOSaleQty'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('SolomonApp.dbo.cftASOSaleQty')) IS NOT NULL
	TRUNCATE TABLE SolomonApp.dbo.cftASOSaleQty
--Else
--IF (OBJECT_ID ('tempdb..#FINAL_QtyTableJM')) IS NOT NULL
--	DROP TABLE #FINAL_QtyTableJM

--CREATE TABLE #FINAL_QtyTableJM (
--	[Year] [char](10) NOT NULL,
--	[Time] [char] (10) NOT NULL,
--	[LocNbr] [varchar] (7) ,
--	[SiteName] [varchar] (50),
--	[PigGroupName] [char](32) NOT NULL,
--	[GroupAlias] [varchar] (84) NOT NULL,
--	[PM] [char](13) NOT NULL,
--	[PodName] [char] (30) NOT NULL,
--	[Packer]	[char] (50) NOT NULL,
--	[Trucker]	[char] (55) NOT NULL,
--	[FeedAdditive] [varchar] (9) NOT NULL,
--	[ServiceManager] [varchar] (50) NOT NULL,
--	[LoadCrew] [char](55) NOT NULL,
--	[DaysonPaylean] [INT] NOT NULL, 
--	[MilestoPacker] [float] NOT NULL,
--	[AB_Qty] [float] ,
--	[BB_Qty] [float] ,
--	[BO_Qty] [float],
--	[CD_Qty] [float] ,
--	[CP_Qty] [float] ,					
--	[DT_Qty] [float] ,
--	[DY_Qty] [float] ,
--	[HV_Qty] [float] ,
--	[IB_Qty] [float] ,
--	[LT_Qty] [float] ,
--	[RR_Qty] [float] ,
--	[SB_Qty] [float] ,
--	[TB_Qty] [float] ,
--	[SS_Qty] [float] 
--	)


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load table cftASOSaleQty
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load table cftASOSaleQty'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

INSERT INTO SolomonApp.dbo.cftASOSaleQty
SELECT 'CY20'+Left([Time],2) AS [Year]
, #CrossTabQtyQueryJM.Time
, vCFPigGroupAttributes.LocNbr
, RTrim([Site]) AS SiteName
, RTrim([PigGroup]) AS PigGroupName
, vCFPigGroupAttributes.GroupAlias
, 'PM_'+RTrim([PMLoadID]) AS PM
, RTrim([Pod]) AS PodName
, RTrim([Packer]) AS PackeNamer
, RTrim([Trucker])+'-TR' AS TruckerName
, CASE WHEN [Paylean] = '' THEN 'NoPaylean' else [Paylean] END as FeedAdditive
--, IIf(([Paylean])="","NoPaylean",[Paylean]) AS FeedAdditive
, RTrim([PGServManager]) AS ServiceManager
, CASE WHEN #LoadCrewDates.LoadCrewName IS NULL THEN 'NoLoadCrew' else 'LC_'+#LoadCrewDates.LoadCrewName END  AS LoadCrew
--, IIf([LoadCrewDates.LoadCrewName] Is Null,"NoLoadCrew","LC_"+[LoadCrewDates.LoadCrewName]) AS LoadCrew
, vCFPigGroupAttributes.DaysonPaylean
, #CrossTabQtyQueryJM.MilesToPacker
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'AB_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'BB_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'BO_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'CD_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'CP_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'DT_Qty' THEN #CrossTabQtyQueryJM.SumOfQty END)
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'DY_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'HV_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'IB_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'LT_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'RR_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'SB_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'TB_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'SS_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
FROM 
(#CrossTabQtyQueryJM INNER JOIN vCFPigGroupAttributes ON #CrossTabQtyQueryJM.PigGroup=vCFPigGroupAttributes.GroupNumber) 
LEFT JOIN #LoadCrewDates ON (#CrossTabQtyQueryJM.SiteID=#LoadCrewDates.ContactID) 
AND (#CrossTabQtyQueryJM.SaleDate>=#LoadCrewDates.AssignedFromDate) 
AND (#CrossTabQtyQueryJM.SaleDate<#LoadCrewDates.AssignedToDate)
group by
'CY20'+Left([Time],2)
, #CrossTabQtyQueryJM.Time
, vCFPigGroupAttributes.LocNbr
, RTrim([Site])
, RTrim([PigGroup]) 
, vCFPigGroupAttributes.GroupAlias
, 'PM_'+RTrim([PMLoadID])
, RTrim([Pod]) 
, RTrim([Packer]) 
, RTrim([Trucker])+'-TR' 
, [Paylean]
, RTrim([PGServManager]) 
, #LoadCrewDates.LoadCrewName
, vCFPigGroupAttributes.DaysonPaylean
, #CrossTabQtyQueryJM.MilesToPacker;

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded ASOSaleQty, '
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
-- create temp table CrossTabWtQueryJM
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table CrossTabWtQueryJM'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('tempdb..#CrossTabWtQueryJM')) IS NOT NULL
	TRUNCATE TABLE #CrossTabWtQueryJM
Else
IF (OBJECT_ID ('tempdb..#CrossTabWtQueryJM')) IS NOT NULL
	DROP TABLE #CrossTabWtQueryJM

CREATE TABLE #CrossTabWtQueryJM (
	[SiteID] [char](6) NOT NULL,
	[PMLoadID] [char](10) NOT NULL,
	[SaleDate] [smalldatetime] NOT NULL,
	[Time] [char] (10) NOT NULL,
	[PigGroup] [char](32) NOT NULL,
	[Packer]	[char] (50) NOT NULL,
	[Trucker]	[char] (50) NOT NULL,
	[MilestoPacker] [float] NOT NULL,
	[DetailTypeId] [char] (5) NOT NULL,
	[WgtLive] [float] NOT NULL
	)


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load temp table CrossTabWtQueryJM
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load CrossTabWtQueryJM'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

INSERT INTO #CrossTabWtQueryJM
--TRANSFORM Sum(SaleTypeTable1.WgtLive) AS SumOfWgtLive
--SELECT CInt([SiteContactID]) AS SiteID, SaleTypeTable1.PMLoadID, First(SaleTypeTable1.SaleDate) AS SaleDate
--, First(#MakeSaleTypeTable1.SaleDate) AS SaleDate
--, First(dbo_cfvDayDefinition_WithWeekInfo.PICYear_Week) AS [Time], First(#MakeSaleTypeTable1.TaskId) AS PigGroup
--, First(dbo_cftContact.ContactName) AS Packer, First(dbo_cftContact_1.ContactName) AS Trucker
--, First(dbo_vCFContactMilesMatrix.OneWayMiles) AS MilesToPacker
SELECT [SiteContactID] AS SiteID
, #MakeSaleTypeTable1.PMLoadID
, #MakeSaleTypeTable1.SaleDate AS SaleDate
, cfvDayDefinition_WithWeekInfo.PICYear_Week AS [Time]
, #MakeSaleTypeTable1.TaskId AS PigGroup
, cftContact.ContactName AS Packer
, dbo_cftContact_1.ContactName AS Trucker
, vCFContactMilesMatrix.OneWayMiles AS MilesToPacker
, #MakeSaleTypeTable1.DetailTypeId+'_Wt' as DetailedTypeID
, Sum(#MakeSaleTypeTable1.WgtLive) AS SumOfWgtLive
FROM 
(((#MakeSaleTypeTable1 INNER JOIN cfvDayDefinition_WithWeekInfo ON #MakeSaleTypeTable1.SaleDate = cfvDayDefinition_WithWeekInfo.DayDate) 
INNER JOIN cftContact AS dbo_cftContact_1 ON #MakeSaleTypeTable1.TruckerContactID = dbo_cftContact_1.ContactID) 
INNER JOIN vCFContactMilesMatrix ON (#MakeSaleTypeTable1.PkrContactId = vCFContactMilesMatrix.DestSite) 
	AND (#MakeSaleTypeTable1.SiteContactID = vCFContactMilesMatrix.SourceSite)) 
INNER JOIN cftContact ON #MakeSaleTypeTable1.PkrContactId = cftContact.ContactID
GROUP BY [SiteContactID] , #MakeSaleTypeTable1.PMLoadID
, #MakeSaleTypeTable1.SaleDate 
, cfvDayDefinition_WithWeekInfo.PICYear_Week 
, #MakeSaleTypeTable1.TaskId 
, cftContact.ContactName
, dbo_cftContact_1.ContactName 
, vCFContactMilesMatrix.OneWayMiles
, #MakeSaleTypeTable1.DetailTypeId
--PIVOT [DetailTypeId]+"_Wt";

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded #CrossTabWtQueryJM, '
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
-- truncate SolomonApp.dbo.cftASOSaleWt
-------------------------------------------------------------------------------
SET  @StepMsg = 'Truncate table SolomonApp.dbo.cftASOSaleWt'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('SolomonApp.dbo.cftASOSaleWt')) IS NOT NULL
	TRUNCATE TABLE SolomonApp.dbo.cftASOSaleWt
--Else
--IF (OBJECT_ID ('tempdb..#FINAL_WtTableJM')) IS NOT NULL
--	DROP TABLE #FINAL_WtTableJM

--CREATE TABLE #FINAL_WtTableJM (
--	[Year] [char](10) NOT NULL,
--	[Time] [char] (10) NOT NULL,
--	[LocNbr] [varchar] (7) ,
--	[SiteName] [varchar] (50),
--	[PigGroupName] [char](32) NOT NULL,
--	[GroupAlias] [varchar] (84) NOT NULL,
--	[PM] [char](13) NOT NULL,
--	[PodName] [char] (30) NOT NULL,
--	[Packer]	[char] (50) NOT NULL,
--	[Trucker]	[char] (55) NOT NULL,
--	[FeedAdditive] [varchar] (9) NOT NULL,
--	[ServiceManager] [varchar] (50) NOT NULL,
--	[LoadCrew] [char](55) NOT NULL,
--	[DaysonPaylean] [INT] NOT NULL, 
--	[MilestoPacker] [float] NOT NULL,
--	[AB_Wt] [float] ,
--	[BB_Wt] [float] ,
--	[BO_Wt] [float],
--	[CD_Wt] [float] ,
--	[CP_Wt] [float] ,					
--	[DT_Wt] [float] ,
--	[DY_Wt] [float] ,
--	[HV_Wt] [float] ,
--	[IB_Wt] [float] ,
--	[LT_Wt] [float] ,
--	[RR_Wt] [float] ,
--	[SB_Wt] [float] ,
--	[TB_Wt] [float] ,
--	[SS_Wt] [float]
--	)


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load SolomonApp.dbo.cftASOSaleWt
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load SolomonApp.dbo.cftASOSaleWt'
EXEC CFFDB.dbo.cfp_PrintTs @StepMsg

INSERT INTO SolomonApp.dbo.cftASOSaleWt
SELECT 'CY20'+Left([Time],2) AS [Year]
, #CrossTabWtQueryJM.Time
, vCFPigGroupAttributes.LocNbr
, RTrim([Site]) AS SiteName
, RTrim([PigGroup]) AS PigGroupName
, vCFPigGroupAttributes.GroupAlias
, 'PM_'+RTrim([PMLoadID]) AS PM
, RTrim([Pod]) AS PodName
, RTrim([Packer]) AS PackeNamer
, RTrim([Trucker])+'-TR' AS TruckerName
, CASE WHEN [Paylean] = '' THEN 'NoPaylean' else [Paylean] END as FeedAdditive
--, IIf(([Paylean])="","NoPaylean",[Paylean]) AS FeedAdditive
, RTrim([PGServManager]) AS ServiceManager
, CASE WHEN #LoadCrewDates.LoadCrewName IS NULL THEN 'NoLoadCrew' else 'LC_'+#LoadCrewDates.LoadCrewName END  AS LoadCrew
--, IIf([LoadCrewDates.LoadCrewName] Is Null,"NoLoadCrew","LC_"+[LoadCrewDates.LoadCrewName]) AS LoadCrew
, vCFPigGroupAttributes.DaysonPaylean
, #CrossTabWtQueryJM.MilesToPacker
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'AB_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'BB_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'BO_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'CD_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'CP_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'DT_Wt' THEN #CrossTabWtQueryJM.WgtLive END)
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'DY_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'HV_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'IB_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'LT_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'RR_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'SB_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'TB_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'SS_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
FROM 
(#CrossTabWtQueryJM INNER JOIN vCFPigGroupAttributes ON #CrossTabWtQueryJM.PigGroup=vCFPigGroupAttributes.GroupNumber) 
LEFT JOIN #LoadCrewDates ON (#CrossTabWtQueryJM.SiteID=#LoadCrewDates.ContactID) 
AND (#CrossTabWtQueryJM.SaleDate>=#LoadCrewDates.AssignedFromDate) 
AND (#CrossTabWtQueryJM.SaleDate<#LoadCrewDates.AssignedToDate)
GROUP BY
'CY20'+Left([Time],2)
, #CrossTabWtQueryJM.Time
, vCFPigGroupAttributes.LocNbr
, RTrim([Site])
, RTrim([PigGroup]) 
, vCFPigGroupAttributes.GroupAlias
, 'PM_'+RTrim([PMLoadID]) 
, RTrim([Pod]) 
, RTrim([Packer]) 
, RTrim([Trucker])+'-TR'
, [Paylean]
, RTrim([PGServManager]) 
, #LoadCrewDates.LoadCrewName
, vCFPigGroupAttributes.DaysonPaylean
, #CrossTabWtQueryJM.MilesToPacker
;

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded SolomonApp.dbo.cftASOSaleWt, '
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
--select * 
--from #FINAL_QtyTableJM
--where year = 'CY2004' and time = '04WK43' and locnbr = 'LOC5710'
--and PM like '%056372'

--select * 
--from #FINAL_WtTableJM
--where Sitename = 'F059' and PigGroupName = 'PG02047' and pm = 'PM_058001'
---------


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

	  





GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_cube_ASOSale_SaleType] TO [MSDSL]
    AS [dbo];

