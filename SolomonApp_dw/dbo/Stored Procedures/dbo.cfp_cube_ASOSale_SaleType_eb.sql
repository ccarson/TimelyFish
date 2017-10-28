


CREATE  PROCEDURE [dbo].[cfp_cube_ASOSale_SaleType_eb]
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
2012-02-16  SRipley		Initial build of essbase load of two tables
						[$(CFFDB)].dbo.cftASOSaleQty
						[$(CFFDB)].dbo.cftASOSaleWt
2012-11-15  sripley	added new detail type values
2014-02-13	sripley exetare modifications
2014-03-14  sripley		rename exetare to clarkfield
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
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate,
					   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
-------------------------------------------------------------------------------
-- create temp table LoadCrewDates
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table LoadCrewDates'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;


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
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

INSERT INTO #LoadCrewDates
SELECT LCS.LoadCrewID, LCS.ContactID, LC.LoadCrewName
, LCS.AssignedFromDate
, CASE WHEN [AssignedToDate] Is Null THEN '12/31/2020' ELSE [AssignedToDate] END as AssignedToDate
FROM [$(CFApp)].dbo.cft_LOAD_CREW LC
RIGHT JOIN [$(CFApp)].dbo.cft_LOAD_CREW_SITES  LCS ON LC.LoadCrewID = LCS.LoadCrewID;

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
-- create temp table MakeSaleTypeTable1
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table #MakeSaleTypeTable1'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;


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
      [ContrNbr] [char] (10) NOT NULL,		-- 20140213 sripley added for exetare
      [TaskId] [char](32) NOT NULL,
      [SaleTypeId] [char](2) NOT NULL,
      [PigTypeID] [char](2) NOT NULL,
      [MarketSaleTypeID] [char](2) NOT NULL,
      [MovementDate] [smalldatetime] NOT NULL,
      [DestContactID] [char] (10) NOT NULL,
      [TruckerContactID] [char] (6) NOT NULL,
      [EstimatedQty]    [smallint]  NOT NULL,
      [DetailTypeId] [char] (2) NULL,
      [Qty] [smallint] NULL,
      [WgtLive] [float] NULL
      )



SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load temp table MakeSaleTypeTable1
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load temp table MakeSaleTypeTable1'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

INSERT INTO #MakeSaleTypeTable1
SELECT cftPM.PMLoadID, cftPM.PMID, cfvPIGSALEREV.BatNbr, cfvPIGSALEREV.RefNbr, cfvPIGSALEREV.SaleDate, 
cfvPIGSALEREV.SiteContactID, cfvPIGSALEREV.PkrContactId,
cfvPIGSALEREV.ContrNbr,		-- 20140213 sripley added for exetare
cfvPIGSALEREV.TaskId, cfvPIGSALEREV.SaleTypeId, ------- the cfvpigsalerev will have ContrNbr (contract number) in it.
cftPM.PigTypeID, cftPM.MarketSaleTypeID, cftPM.MovementDate, cftPM.DestContactID, 
cftPM.TruckerContactID, cftPM.EstimatedQty, cftPSDetail.DetailTypeId, cftPSDetail.Qty, 
cftPSDetail.WgtLive
FROM ([$(SolomonApp)].dbo.cftPM as cftPM LEFT JOIN [$(SolomonApp)].dbo.cfvPIGSALEREV as cfvPIGSALEREV ON cftPM.PMID = cfvPIGSALEREV.PMLoadId) 
LEFT JOIN [$(SolomonApp)].dbo.cftPSDetail as cftPSDetail ON (cfvPIGSALEREV.ARBatNbr = cftPSDetail.BatNbr) AND (cfvPIGSALEREV.RefNbr = cftPSDetail.RefNbr)
WHERE 
(((cfvPIGSALEREV.RefNbr)<>'') 
AND ((cfvPIGSALEREV.SaleTypeId)<>'CS'           
--And (cfvPIGSALEREV.SaleTypeId)<>'MC'    -- 20130724 sripley, this is preventing secondary packer info from getting into the cube. users need this info.
And (cfvPIGSALEREV.SaleTypeId)<>'CB') 
AND ((cftPM.PigTypeID)='04'))




SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded #MakeSaleTypeTable1, '
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
-- create temp table #MktMgrEffDateTable	201310 sripley added code to get the market manager.
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table MktMgrEffDateTable'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('tempdb..#MktMgrEffDateTable')) IS NOT NULL
	TRUNCATE TABLE #MktMgrEffDateTable
Else
IF (OBJECT_ID ('tempdb..#MktMgrEffDateTable')) IS NOT NULL
	DROP TABLE #MktMgrEffDateTable

CREATE TABLE #MktMgrEffDateTable (
	[SiteContactID] [char](6) NOT NULL,
	[EffectiveDate] [smalldatetime] NOT NULL,
	[endEffDate] [smalldatetime] NOT NULL,
	[MktManger] [char](50) NOT NULL,
	mktmgrcontactid char(6) not null
	)
	


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load temp table	201310 sripley added code to get the market manager.
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load temp table #MktMgrEffDateTable'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

INSERT INTO #MktMgrEffDateTable
--SELECT cftMktMgrAssign.SiteContactID
--, cftMktMgrAssign.EffectiveDate
----, IIf(Trim$([MktMgrContactID])="","No Service Manager",[ContactName]) AS MktManger
--, CASE When Rtrim(ltrim(cftMktMgrAssign.MktMgrContactID)) = '' then 'No Service Manager' else cftContact.ContactName end as MktManger
--FROM [$(SolomonApp)].dbo.cftMktMgrAssign cftMktMgrAssign (nolock) 
--LEFT JOIN [$(SolomonApp)].dbo.cftContact cftContact (nolock) ON cftMktMgrAssign.MktMgrContactID = cftContact.ContactID
--UNION 
--Select ContactID,'1/1/1900','No Service Manager' 
--from [$(SolomonApp)].dbo.cftSite cftSite (nolock)
--ORDER BY cftMktMgrAssign.SiteContactID, cftMktMgrAssign.EffectiveDate;

select p1.sitecontactid, p1.effectivedate, isnull(p2.effectivedate -1,getdate()) endeffdate
, CASE When Rtrim(ltrim(p1.MktMgrContactID)) = '' then 'No Service Manager' else C.ContactName end as MktManger
, isnull(p1.mktmgrcontactid,p1.mktmgrcontactid)
from 
(SELECT sitecontactid, effectivedate, mktmgrcontactid, 
    ROW_NUMBER() OVER(
      PARTITION BY sitecontactid
      ORDER BY effectivedate) AS rownum                      -- adds a row sequence id
  FROM [$(SolomonApp)].dbo.cftMktMgrAssign
  GROUP BY sitecontactid, effectivedate, mktmgrcontactid) p1
left join
(SELECT sitecontactid, effectivedate, mktmgrcontactid, 
    ROW_NUMBER() OVER(
      PARTITION BY sitecontactid
      ORDER BY effectivedate) AS rownum                      -- adds a row sequence id
  FROM [$(SolomonApp)].dbo.cftMktMgrAssign
  GROUP BY sitecontactid, effectivedate, mktmgrcontactid) p2
on p1.sitecontactid = p2.sitecontactid and p1.rownum + 1 = p2.rownum
LEFT JOIN [$(SolomonApp)].dbo.cftContact C (nolock) ON p1.MktMgrContactID = C.ContactID
--UNION 
--Select ContactID,'1/1/1900','1/1/1900','No Service Manager','no service manager'
--from [$(SolomonApp)].dbo.cftSite cftSite (nolock)
ORDER BY p1.SiteContactID, p1.EffectiveDate;



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
-- create temp table CrossTabQtyQueryJM
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table CrossTabQtyQueryJM'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;


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
	[DetailTypeId] [char] (6) NULL,
	[SumOfQty] [float] NULL,
	[MktManger] [char](50) null	--	201310 sripley added code to get the market manager.
	)



SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load temp table CrossTabQtyQueryJM
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load CrossTabQtyQueryJM'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

INSERT INTO #CrossTabQtyQueryJM
SELECT #MakeSaleTypeTable1.[SiteContactID] AS SiteID
, #MakeSaleTypeTable1.PMLoadID
, #MakeSaleTypeTable1.SaleDate AS SaleDate
, cfvDayDefinition_WithWeekInfo.PICYear_Week AS [Time]
, #MakeSaleTypeTable1.TaskId AS PigGroup
--, cftContact.ContactName AS Packer	20140213 sripley exetare modifications
--,case when #MakeSaleTypeTable1.ContrNbr = '000023' then rtrim(cftContact.ContactName)+' Exetare' else cftContact.ContactName end AS Packer
,case when #MakeSaleTypeTable1.ContrNbr = '000023' then rtrim(cftContact.ContactName)+' Clarkfield' else cftContact.ContactName end AS Packer		-- 20130314 sripley
--, dbo_cftContact_1.ContactName AS Trucker	20140213 sripley exetare modifications
,case when dbo_cftContact_1.ContactName = ' -' then 'NoTrucker' else dbo_cftContact_1.ContactName end AS Trucker
, vCFContactMilesMatrix.OneWayMiles AS MilesToPacker
, #MakeSaleTypeTable1.DetailTypeId+'_Qty' as DetailedTypeID
, Sum(#MakeSaleTypeTable1.Qty) AS SumOfQty
, isnull(mktmbr.MktManger,'No Mrkt Manager') --       201310 sripley added code to get the market manager.
FROM 
#MakeSaleTypeTable1
INNER JOIN [$(SolomonApp)].dbo.vCFContactMilesMatrix as vCFContactMilesMatrix  ON (#MakeSaleTypeTable1.PkrContactId = vCFContactMilesMatrix.DestSite) 
                  AND (#MakeSaleTypeTable1.SiteContactID = vCFContactMilesMatrix.SourceSite)
INNER JOIN [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo as cfvDayDefinition_WithWeekInfo ON #MakeSaleTypeTable1.SaleDate = cfvDayDefinition_WithWeekInfo.DayDate
INNER JOIN [$(SolomonApp)].dbo.cftContact as cftContact ON #MakeSaleTypeTable1.PkrContactId = cftContact.ContactID 
INNER JOIN [$(SolomonApp)].dbo.cftContact AS dbo_cftContact_1 ON #MakeSaleTypeTable1.TruckerContactID = dbo_cftContact_1.ContactID
left join #MktMgrEffDateTable mktmbr on mktmbr.SiteContactID = #MakeSaleTypeTable1.SiteContactID
  and #MakeSaleTypeTable1.Saledate between mktmbr.effectivedate and mktmbr.endeffdate  --       201310 sripley added code to get the market manager.
GROUP BY #MakeSaleTypeTable1.[SiteContactID] 
, #MakeSaleTypeTable1.PMLoadID
, #MakeSaleTypeTable1.SaleDate 
, cfvDayDefinition_WithWeekInfo.PICYear_Week 
, #MakeSaleTypeTable1.TaskId 
--, cftContact.ContactName		20140213 sripley exetare modifications
--,case when #MakeSaleTypeTable1.ContrNbr = '000023' then rtrim(cftContact.ContactName)+' Exetare' else cftContact.ContactName end
,case when #MakeSaleTypeTable1.ContrNbr = '000023' then rtrim(cftContact.ContactName)+' Clarkfield' else cftContact.ContactName end 		-- 20130314 sripley
--, dbo_cftContact_1.ContactName 	20140213 sripley exetare modifications
,case when dbo_cftContact_1.ContactName = ' -' then 'NoTrucker' else dbo_cftContact_1.ContactName end
, vCFContactMilesMatrix.OneWayMiles
, #MakeSaleTypeTable1.DetailTypeId
, mktmbr.MktManger --   201310 sripley added code to get the market manager.



SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded #CrossTabQtyQueryJM, '
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
-- truncate table cftASOSaleQty
-------------------------------------------------------------------------------
SET  @StepMsg = 'truncate table cftASOSaleQty_eb'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('[$(CFFDB)].dbo.cftASOSaleQty_eb')) IS NOT NULL
	TRUNCATE TABLE [$(CFFDB)].dbo.cftASOSaleQty_eb
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
SET  @StepMsg = 'Load table cftASOSaleQty_eb'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

INSERT INTO [$(CFFDB)].dbo.cftASOSaleQty_eb
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
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'LM_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)	--smr 20121115 add
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'LT_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'MR_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)	--smr 20121115 add
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'OW_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)	--smr 20121115 add
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'PQ_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)	--smr 20121115 add
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'RR_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'SB_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'TB_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
, SUM(CASE WHEN #CrossTabQtyQueryJM.DetailTypeId = 'SS_Qty' THEN  #CrossTabQtyQueryJM.SumOfQty END)
, 'MM_' + #CrossTabQtyQueryJM.MktManger	-- smr 201310 add
FROM 
(#CrossTabQtyQueryJM 
	INNER JOIN 
		(SELECT DISTINCT LOCNBR, GroupNumber, GroupAlias, DaysonPaylean, Paylean, Pod, PGServManager, Site
		 FROM [$(SolomonApp)].dbo.vCFPigGroupAttributes)  as vCFPigGroupAttributes 
	ON #CrossTabQtyQueryJM.PigGroup=vCFPigGroupAttributes.GroupNumber) 
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
, #CrossTabQtyQueryJM.MilesToPacker
, #CrossTabQtyQueryJM.MktManger;

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded ASOSaleQty, '
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
-- create temp table CrossTabWtQueryJM
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table CrossTabWtQueryJM'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;


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
	[DetailTypeId] [char] (5) NULL,
	[WgtLive] [float] NULL,
	[MktManger] [char](50)  NULL	--	201310 sripley added code to get the market manager.
	)


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load temp table CrossTabWtQueryJM
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load CrossTabWtQueryJM'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

INSERT INTO #CrossTabWtQueryJM
SELECT #MakeSaleTypeTable1.[SiteContactID] AS SiteID
, #MakeSaleTypeTable1.PMLoadID
, #MakeSaleTypeTable1.SaleDate AS SaleDate
, cfvDayDefinition_WithWeekInfo.PICYear_Week AS [Time]
, #MakeSaleTypeTable1.TaskId AS PigGroup
--, cftContact.ContactName AS Packer	--		20140213 sripley exetare modifications
--,case when #MakeSaleTypeTable1.ContrNbr = '000023' then rtrim(cftContact.ContactName)+' Exetare' else cftContact.ContactName end AS Packer
,case when #MakeSaleTypeTable1.ContrNbr = '000023' then rtrim(cftContact.ContactName)+' Clarkfield' else cftContact.ContactName end AS Packer		-- 20130314 sripley
--, dbo_cftContact_1.ContactName AS Trucker	--		20140213 sripley exetare modifications
,case when dbo_cftContact_1.ContactName = ' -' then 'NoTrucker' else dbo_cftContact_1.ContactName end AS Trucker
, vCFContactMilesMatrix.OneWayMiles AS MilesToPacker
, #MakeSaleTypeTable1.DetailTypeId+'_Wt' as DetailedTypeID
, Sum(#MakeSaleTypeTable1.WgtLive) AS SumOfWgtLive
, isnull(mktmbr.MktManger,'No Mrkt Manager') --       201310 sripley added code to get the market manager.
FROM 
(((#MakeSaleTypeTable1 INNER JOIN [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo as cfvDayDefinition_WithWeekInfo ON #MakeSaleTypeTable1.SaleDate = cfvDayDefinition_WithWeekInfo.DayDate) 
INNER JOIN [$(SolomonApp)].dbo.cftContact AS dbo_cftContact_1 ON #MakeSaleTypeTable1.TruckerContactID = dbo_cftContact_1.ContactID) 
INNER JOIN [$(SolomonApp)].dbo.vCFContactMilesMatrix as vCFContactMilesMatrix ON (#MakeSaleTypeTable1.PkrContactId = vCFContactMilesMatrix.DestSite) 
      AND (#MakeSaleTypeTable1.SiteContactID = vCFContactMilesMatrix.SourceSite)) 
INNER JOIN [$(SolomonApp)].dbo.cftContact as cftContact ON #MakeSaleTypeTable1.PkrContactId = cftContact.ContactID
left join #MktMgrEffDateTable mktmbr on mktmbr.SiteContactID = #MakeSaleTypeTable1.SiteContactID
  and #MakeSaleTypeTable1.Saledate between mktmbr.effectivedate and mktmbr.endeffdate  --       201310 sripley added code to get the market manager.
GROUP BY #MakeSaleTypeTable1.[SiteContactID] , #MakeSaleTypeTable1.PMLoadID
, #MakeSaleTypeTable1.SaleDate 
, cfvDayDefinition_WithWeekInfo.PICYear_Week 
, #MakeSaleTypeTable1.TaskId 
--, cftContact.ContactName	--		20140213 sripley exetare modifications
--,case when #MakeSaleTypeTable1.ContrNbr = '000023' then rtrim(cftContact.ContactName)+' Exetare' else cftContact.ContactName end
,case when #MakeSaleTypeTable1.ContrNbr = '000023' then rtrim(cftContact.ContactName)+' Clarkfield' else cftContact.ContactName end 		-- 20130314 sripley
--, dbo_cftContact_1.ContactName	--		20140213 sripley exetare modifications
,case when dbo_cftContact_1.ContactName = ' -' then 'NoTrucker' else dbo_cftContact_1.ContactName end
, vCFContactMilesMatrix.OneWayMiles
, #MakeSaleTypeTable1.DetailTypeId
, mktmbr.MktManger   --       201310 sripley added code to get the market manager.


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded #CrossTabWtQueryJM, '
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
-- truncate [$(CFFDB)].dbo.cftASOSaleWt
-------------------------------------------------------------------------------
SET  @StepMsg = 'Truncate table [$(CFFDB)].dbo.cftASOSaleWt_eb'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('[$(CFFDB)].dbo.cftASOSaleWt_eb')) IS NOT NULL
	TRUNCATE TABLE [$(CFFDB)].dbo.cftASOSaleWt_eb
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
-- Load [$(CFFDB)].dbo.cftASOSaleWt
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load [$(CFFDB)].dbo.cftASOSaleWt'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

INSERT INTO [$(CFFDB)].dbo.cftASOSaleWt_eb
SELECT 'CY20'+Left([Time],2) AS [Year]
, #CrossTabWtQueryJM.Time
, vCFPigGroupAttributes.LocNbr
, RTrim([Site]) AS SiteName
, RTrim([PigGroup]) AS PigGroupName
, vCFPigGroupAttributes.GroupAlias
, 'PM_'+RTrim([PMLoadID]) AS PM
, RTrim([Pod]) AS PodName
, RTrim([Packer]) AS PackerName
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
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'LM_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)		--20121115 sripley add
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'LT_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'MR_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)		--20121115 sripley add
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'OW_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)		--20121115 sripley add
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'PQ_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)		--20121115 sripley add
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'RR_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'SB_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'TB_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
, SUM(CASE WHEN #CrossTabWtQueryJM.DetailTypeId = 'SS_Wt' THEN  #CrossTabWtQueryJM.WgtLive END)
, 'MM_' + #CrossTabWtQueryJM.MktManger   -- 	201310 sripley added code to get the market manager.
FROM 
(#CrossTabWtQueryJM INNER JOIN [$(SolomonApp)].dbo.vCFPigGroupAttributes as vCFPigGroupAttributes ON #CrossTabWtQueryJM.PigGroup=vCFPigGroupAttributes.GroupNumber) 
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
, #CrossTabWtQueryJM.MktManger   -- 	201310 sripley added code to get the market manager.
;

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded [$(CFFDB)].dbo.cftASOSaleWt, '
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

	  






















GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_cube_ASOSale_SaleType_eb] TO [SE\ssis_datareader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_cube_ASOSale_SaleType_eb] TO [SSIS_Operator]
    AS [dbo];

