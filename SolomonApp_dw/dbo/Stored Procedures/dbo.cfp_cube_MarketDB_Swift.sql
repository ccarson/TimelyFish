


















create PROCEDURE [dbo].[cfp_cube_MarketDB_Swift]
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
2012-02-22  SRipley		Convert access db load to SQL proc load

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
SET @ProcessName        = 'cfp_cube_MarketDB_Swift'
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
-- truncate the staging table 
-------------------------------------------------------------------------------
SET  @StepMsg = 'Truncate the staging table [$(CFFDB)].dbo.cftmarketdbswift_stg'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;

IF (OBJECT_ID ('[$(CFFDB)].dbo.cftmarketdbswift_stg')) IS NOT NULL
	TRUNCATE TABLE [$(CFFDB)].dbo.cftmarketdbswift_stg

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
SET @RecordsProcessed = @RowCount
SET @Comments = 'truncate staging table '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
-------------------------------------------------------------------------------
-- create temp table SwiftCrossTabWeightRangesNew
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table SwiftCrossTabWeightRangesNew'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('tempdb..#SwiftCrossTabWeightRangesNew')) IS NOT NULL
	TRUNCATE TABLE #SwiftCrossTabWeightRangesNew
Else
IF (OBJECT_ID ('tempdb..#SwiftCrossTabWeightRangesNew')) IS NOT NULL
	DROP TABLE #SwiftCrossTabWeightRangesNew

CREATE TABLE #SwiftCrossTabWeightRangesNew (
	[PlantNbr] [varchar] (10) NOT NULL,
	[KillDate] [smalldatetime] NOT NULL,
	[TattooNbr] [varchar](10) NOT NULL,
	[Under140] [int] NULL,
	[140 - 147] [int] NULL,
	[148 - 154] [int] NULL,
	[155 - 162] [int] NULL,
	[163 - 169] [int] NULL,
	[170 - 176] [int] NULL,
	[177 - 184] [int] NULL,
	[185 - 191] [int] NULL,
	[192 - 198] [int] NULL,
	[199 - 206] [int] NULL,
	[207 - 213] [int] NULL,
	[214 - 220] [int] NULL,
	[221 - 228] [int] NULL,
	[229 - 235] [int] NULL,
	[236 - 242] [int] NULL,
	[243 - 249] [int] NULL,
	[>250] [int] NULL
	)

SET  @StepMsg = 'insert into temp table SwiftCrossTabWeightRangesNew'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;
	
insert into #SwiftCrossTabWeightRangesNew
select PlantNbr, killdate, TattooNbr
		, ISNULL(SUM(CASE WHEN weightrange = 'Under139' THEN  wgtcnt END),0) [Under140]
		, ISNULL(SUM(CASE WHEN weightrange = '140 - 147' THEN  wgtcnt END),0) [140 - 147]
		, ISNULL(SUM(CASE WHEN weightrange = '148 - 154' THEN  wgtcnt END),0) [148 - 154]
		, ISNULL(SUM(CASE WHEN weightrange = '155 - 162' THEN  wgtcnt END),0) [155 - 162]
		, ISNULL(SUM(CASE WHEN weightrange = '163 - 169' THEN  wgtcnt END),0) [163 - 169]
		, ISNULL(SUM(CASE WHEN weightrange = '170 - 176' THEN  wgtcnt END),0) [170 - 176]
		, ISNULL(SUM(CASE WHEN weightrange = '177 - 184' THEN  wgtcnt END),0) [177 - 184]
		, ISNULL(SUM(CASE WHEN weightrange = '185 - 191' THEN  wgtcnt END),0) [185 - 191]
		, ISNULL(SUM(CASE WHEN weightrange = '192 - 198' THEN  wgtcnt END),0) [192 - 198]
		, ISNULL(SUM(CASE WHEN weightrange = '199 - 206' THEN  wgtcnt END),0) [199 - 206]
		, ISNULL(SUM(CASE WHEN weightrange = '207 - 213' THEN  wgtcnt END),0) [207 - 213]	
		, ISNULL(SUM(CASE WHEN weightrange = '214 - 220' THEN  wgtcnt END),0) [214 - 220]
		, ISNULL(SUM(CASE WHEN weightrange = '221 - 228' THEN  wgtcnt END),0) [221 - 228]		
		, ISNULL(SUM(CASE WHEN weightrange = '229 - 235' THEN  wgtcnt END),0) [229 - 235]		
		, ISNULL(SUM(CASE WHEN weightrange = '236 - 242' THEN  wgtcnt END),0) [236 - 242]
		, ISNULL(SUM(CASE WHEN weightrange = '243 - 249' THEN  wgtcnt END),0) [243 - 249]					
		, ISNULL(SUM(CASE WHEN weightrange = '>249'	  THEN  wgtcnt END),0) [>250]
		from
			(SELECT 
			  Case Swift.PlantNbr
			  when '00048' then '000554' -- Swift-Marshalltown
			  when '00092' then '000555' --Swift-Worthington
			  end as PlantNbr
			, Swift.KillDate, Swift.TattooNbr, Swift.HotWeight, 1 as wgtcnt
			, CASE when HotWeight >= 0 and HotWeight < 140 then 'Under139'
				when HotWeight >= 140 and HotWeight < 148 then '140 - 147'
				when HotWeight >= 148 and HotWeight < 155 then '148 - 154'
				when HotWeight >= 155 and HotWeight < 163 then '155 - 162'
				when HotWeight >= 163 and HotWeight < 170 then '163 - 169'
				when HotWeight >= 170 and HotWeight < 177 then '170 - 176'
				when HotWeight >= 177 and HotWeight < 185 then '177 - 184'
				when HotWeight >= 185 and HotWeight < 192 then '185 - 191'
				when HotWeight >= 192 and HotWeight < 199 then '192 - 198'
				when HotWeight >= 199 and HotWeight < 207 then '199 - 206'
				when HotWeight >= 207 and HotWeight < 214 then '207 - 213'
				when HotWeight >= 214 and HotWeight < 221 then '214 - 220'
				when HotWeight >= 221 and HotWeight < 229 then '221 - 228'
				when HotWeight >= 229 and HotWeight < 236 then '229 - 235'
				when HotWeight >= 236 and HotWeight < 243 then '236 - 242'
				when HotWeight >= 243 and HotWeight < 250 then '243 - 249'		
			else '>249'
			end  as weightrange
			FROM [$(SolomonApp)].dbo.cftPSDetSwift Swift (nolock)
			WHERE (KillDate > '1/3/2010'
			AND ExceptionCode in ('','A')) 
			) as basedata
			group by  PlantNbr, KillDate, TattooNbr


-- added index for perf cftPSDetSwift_killdate_incl

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded SwiftCrossTabWeightRangesNew temp table, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
                
-------------------------------------------------------------------------------
-- create temp table MktMgrEffDateTable: (bottom level using Solomon tables)
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table  MktMgrEffDateTable'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('tempdb..#MktMgrEffDateTable')) IS NOT NULL
	TRUNCATE TABLE #MktMgrEffDateTable
Else
IF (OBJECT_ID ('tempdb..#MktMgrEffDateTable')) IS NOT NULL
	DROP TABLE #MktMgrEffDateTable
	
CREATE TABLE #MktMgrEffDateTable (
	[SiteContactID] [varchar] (10) NOT NULL,
	[ContactName] [varchar] (50) NULL,
	[StartDate] [smalldatetime] NOT NULL,
	[EndDate] [smalldatetime] NULL
	)

SET  @StepMsg = 'insert into temp table #MktMgrEffDateTable'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;
	
insert into #MktMgrEffDateTable
select mn.SiteContactID, c.ContactName , mn.EffectiveDate startdate, mx.EffectiveDate -1 enddate
from 
(select SiteContactID, mktmgrcontactid, EffectiveDate, ROW_NUMBER() over(order by sitecontactid, effectivedate) as rowcnt
FROM [$(SolomonApp)].dbo.cftMktMgrAssign (nolock)) as mn
inner join [$(SolomonApp)].dbo.cftcontact c (nolock)
	on c.contactid = mn.MktMgrContactID
left join
(select SiteContactID, MktMgrContactID, EffectiveDate, (ROW_NUMBER() over(order by sitecontactid, effectivedate) - 1) as rowcnt
FROM [$(SolomonApp)].dbo.cftMktMgrAssign (nolock)) as mx
	on mn.SiteContactID = mx.SiteContactID and mn.rowcnt = mx.rowcnt
union
select ContactID as SiteContactID, 'No Service Manager' as ContactName, '1/1/1900' as startdate, GETDATE() + 3650 as enddate
from [$(SolomonApp)].dbo.cftSite S (nolock)
except
select sitecontactid, 'No Service Manager' as ContactName, '1/1/1900' as effectivedate,  GETDATE() + 3650  as enddate
from [$(SolomonApp)].dbo.cftMktMgrAssign  MM (nolock)
order by 1, 3

-------------------------------------------------------------------------------
-- create temp table first site manager and pmloadid for split loads
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table  FirstsTable'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('tempdb..#FirstsTable')) IS NOT NULL
	TRUNCATE TABLE #FirstsTable
Else
IF (OBJECT_ID ('tempdb..#FirstsTable')) IS NOT NULL
	DROP TABLE #FirstsTable
	
CREATE TABLE #FirstsTable (
	[SaleDate]		[smalldatetime] NOT NULL,
	[KillDate]		[smalldatetime] NOT NULL,
	[Tattoo]		[varchar](10) NOT NULL,
	[PkrContactID]	[varchar] (10) NOT NULL,
	[SiteContactID]	[varchar] (10) NOT NULL,
	[PMLoadID]		[varchar] (10) NOT NULL,
	[HCTot]			[int] NOT NULL,
	[Firstque]		[smallint] NOT NULL
	)

SET  @StepMsg = 'inserting into temp table #FirstsTable'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;
	
insert into #FirstsTable
select doover.*
from 
(SELECT dbo_cftPigSale.SaleDate
, dbo_cftPigSale.KillDate
, dbo_cftPigSale.TattooNbr AS Tattoo
, dbo_cftPigSale.PkrContactId
, dbo_cftPigSale.SiteContactID AS SiteContactID
, dbo_cftPigSale.PMLoadId AS PMLoadId
, dbo_cftPigSale.HCTot
, ROW_NUMBER() over(partition by dbo_cftPigSale.SaleDate, dbo_cftPigSale.KillDate, dbo_cftPigSale.TattooNbr, dbo_cftPigSale.PkrContactId
order by dbo_cftPigSale.HCTot DESC) as Firstque
FROM [$(SolomonApp)].dbo.cftPigSale as dbo_cftPigSale (nolock)
LEFT JOIN [$(SolomonApp)].dbo.cftPigSale AS rev (nolock) ON dbo_cftPigSale.RefNbr = rev.OrigRefNbr
--WHERE (((dbo_cftPigSale.SaleBasis)='CW')  --This is a better criteria for sales with carcass detail
WHERE (((dbo_cftPigSale.SaleBasis) in ('LW','CW') and ((dbo_cftPigSale.SaleTypeID)='MS')) --This is a better criteria for Sales that should have associated carcass data.
AND ((dbo_cftPigSale.CustId)='SWIFT') AND ((dbo_cftPigSale.DocType)<>'RE') AND ((rev.RefNbr) Is Null) AND ((dbo_cftPigSale.SaleDate)>='1/3/2010'))
) doover
where Firstque = 1


-------------------------------------------------------------------------------
-- generate the cube data
-------------------------------------------------------------------------------
IF (OBJECT_ID ('[$(CFFDB)].dbo.cftmarketdbswift_stg')) IS NOT NULL
	TRUNCATE TABLE [$(CFFDB)].dbo.cftmarketdbswift_stg

insert into [$(CFFDB)].dbo.cftmarketdbswift_stg
SELECT dbo_cfvDayDefinition_WithWeekInfo.PICYear_Week AS Week
, dbo_cftContact.ContactName AS Site
, dbo_cftContact_1.ContactName AS Packer
, MM.ContactName AS MktManager
, isnull(rtrim(LoadTypeTable.Description),'No LoadType') AS LoadType
, Sum(SaleSiteTriumph5.HCTot) AS Headcount
, Sum(SaleSiteTriumph5.LiveWt) AS SumOfLiveWt
, Sum(SaleSiteTriumph5.CarcassWt) AS SumOfCarcassWt
, Sum(SaleSiteTriumph5.PL) AS SumOfPL
, Sum(SaleSiteTriumph5.SortLoss) AS SumOfSortLoss
, Sum(tct.[Under140]) AS [SumOfUnder139]
, Sum(tct.[140 - 147]) AS [SumOf140 - 147]
, Sum(tct.[148 - 154]) AS [SumOf148 - 154]
, Sum(tct.[155 - 162]) AS [SumOf155 - 162]
, Sum(tct.[163 - 169]) AS [SumOf163 - 169]
, Sum(tct.[170 - 176]) AS [SumOf170 - 176]
, Sum(tct.[177 - 184]) AS [SumOf177 - 184]
, Sum(tct.[185 - 191]) AS [SumOf185 - 191]
, Sum(tct.[192 - 198]) AS [SumOf192 - 198]
, Sum(tct.[199 - 206]) AS [SumOf199 - 206]
, Sum(tct.[207 - 213]) AS [SumOf207 - 213]
, Sum(tct.[214 - 220]) AS [SumOf214 - 220]
, Sum(tct.[221 - 228]) AS [SumOf221 - 228]
, Sum(tct.[229 - 235]) AS [SumOf229 - 235]
, Sum(tct.[236 - 242]) AS [SumOf236 - 242]
, Sum(tct.[243 - 249]) AS [SumOf243 - 249]
, Sum(tct.[>250]) AS [SumOf>250]
FROM 
(
SELECT dbo_cftPigSale.SaleDate, dbo_cftPigSale.KillDate, rtrim(dbo_cftPigSale.TattooNbr) AS TattooNbr, dbo_cftPigSale.PkrContactId
, Sum(dbo_cftPigSale.HCTot) AS HCTot
, Sum(dbo_cftPigSale.DelvLiveWgt) AS LiveWt
, Sum(dbo_cftPigSale.DelvCarcWgt) AS CarcassWt
, Sum(dbo_cftPigSale.AmtCheck) AS Amount
, Sum(dbo_cftPigSale.AmtBaseSale) AS [Base Dollars]
, Sum(dbo_cftPigSale.AmtGradePrem) AS PL
, Sum(dbo_cftPigSale.AmtNPPC) AS NPPC
, Sum(dbo_cftPigSale.AmtInsect) AS Insect
, Sum(dbo_cftPigSale.AmtOther) AS Other
, Sum(dbo_cftPigSale.AmtScale) AS Scale
, Sum(dbo_cftPigSale.AmtSortLoss) AS SortLoss
, Sum(dbo_cftPigSale.AmtTruck) AS Trucking
, Sum(dbo_cftPigSale.AmtTruckAllow) AS TruckAllow
, Sum(dbo_cftPigSale.AmtDefer) AS [Deferred]
FROM [$(SolomonApp)].dbo.cftPigSale as dbo_cftPigSale (nolock)
LEFT JOIN [$(SolomonApp)].dbo.cftPigSale AS rev (nolock) ON dbo_cftPigSale.RefNbr = rev.OrigRefNbr
--WHERE (((dbo_cftPigSale.SaleBasis)='CW') --This is a better criteria for Sales that should have associated carcass data.
WHERE (((dbo_cftPigSale.SaleBasis) in ('LW','CW') and ((dbo_cftPigSale.SaleTypeID)='MS')) --This is a better criteria for Sales that should have associated carcass data.
AND ((dbo_cftPigSale.CustId)='SWIFT') AND ((dbo_cftPigSale.DocType)<>'RE') AND ((rev.RefNbr) Is Null) AND ((dbo_cftPigSale.SaleDate)>='1/3/2010'))
GROUP BY dbo_cftPigSale.SaleDate, dbo_cftPigSale.KillDate, rtrim(dbo_cftPigSale.TattooNbr), dbo_cftPigSale.PkrContactId
) as SaleSiteTriumph5
left join  #FirstsTable F 
	on F.SaleDate = SaleSiteTriumph5.SaleDate
	and	f.KillDate = SaleSiteTriumph5.KillDate
	and f.Tattoo = SaleSiteTriumph5.TattooNbr --Changed f.TattooNbr to f.Tattoo
	and f.PkrContactID = SaleSiteTriumph5.PkrContactId 
inner join #MktMgrEffDateTable MM
	on MM.SiteContactID = f.SiteContactID
	--and f.KillDate Use SaleDate to determine the MarketManager
	and f.SaleDate
	between MM.startdate and isnull(MM.EndDate,GETDATE()+3650) --changed MM.EffectiveDate to MM.startdate
LEFT JOIN [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dbo_cfvDayDefinition_WithWeekInfo (nolock) ON SaleSiteTriumph5.SaleDate=dbo_cfvDayDefinition_WithWeekInfo.DayDate
LEFT JOIN [$(SolomonApp)].dbo.cftContact dbo_cftContact (nolock) ON dbo_cftContact.ContactID=F.SiteContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact AS dbo_cftContact_1 (nolock) ON dbo_cftContact_1.ContactID = SaleSiteTriumph5.PkrContactId
		--LEFT JOIN [$(SolomonApp)].dbo.cftContact AS dbo_cftContact_2 (nolock) ON dbo_cftContact_2.ContactID = MM.MktMgrContactID
LEFT JOIN [$(SolomonApp)].dbo.cftPM dbo_cftPM (nolock) ON F.PMLoadId=dbo_cftPM.PMID
LEFT JOIN 
		(select marketsaletypeid
		, CASE WHEN marketsaletypeid = '10' Then 'Top Load'
			   WHEN marketsaletypeid = '20' Then 'Second Top'
			   WHEN marketsaletypeid = '25' Then 'Third Top'
			   WHEN marketsaletypeid = '30' Then 'Market Load'
		       else 'No LoadType'		   		 
		       end as Description
		  from [$(SolomonApp)].dbo.cftMarketSaleType (nolock)) as LoadTypeTable
			on LoadTypeTable.marketsaletypeid = dbo_cftPM.MarketSaleTypeID
inner join #SwiftCrossTabWeightRangesNew tct
	on tct.PlantNbr = f.PkrContactID
	and tct.KillDate = f.KillDate
	and tct.TattooNbr = f.Tattoo
GROUP BY dbo_cfvDayDefinition_WithWeekInfo.PICYear_Week, dbo_cftContact.ContactName, dbo_cftContact_1.ContactName, MM.ContactName, LoadTypeTable.Description


---------------------- end of the cube build ---------------


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded #MktMgrEffDateTable temp table, '
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

	  

















GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_cube_MarketDB_Swift] TO [SE\ssis_datareader]
    AS [dbo];

