


CREATE PROCEDURE [dbo].[cfp_cube_MarketDB_STF]
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
2017-08-24  JMaas		Create procedure; using cfp_cube_MarketDB_Triumph as a template. Market manager lookup now uses cff_tvf_GetSiteMarketManagerData.

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
SET @ProcessName        = 'cfp_cube_MarketDB_STF'
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
SET  @StepMsg = 'Truncate the staging table [$(CFFDB)].dbo.cftmarketdbSTF_stg'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;

IF (OBJECT_ID ('[$(CFFDB)].dbo.cftmarketdbSTF_stg')) IS NOT NULL
	TRUNCATE TABLE [$(CFFDB)].dbo.cftmarketdbSTF_stg

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
SET @RecordsProcessed = @RowCount
SET @Comments = 'truncate staging table '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
                
             
-------------------------------------------------------------------------------
-- create temp table TriumphCrossTabWeightRangesNew
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table #STFCrossTabWeightRangesNew'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('tempdb..#STFCrossTabWeightRangesNew')) IS NOT NULL
	TRUNCATE TABLE #STFCrossTabWeightRangesNew
Else
IF (OBJECT_ID ('tempdb..#STFCrossTabWeightRangesNew')) IS NOT NULL
	DROP TABLE #STFCrossTabWeightRangesNew

CREATE TABLE #STFCrossTabWeightRangesNew (
	[PlantNbr] [varchar] (10) NOT NULL,
	[KillDate] [smalldatetime] NOT NULL,
	[TattooNbr] [varchar](10) NOT NULL,
	[Under160] [int] NULL,
	[160 - 169] [int] NULL,
	[170 - 179] [int] NULL,
	[180 - 189] [int] NULL,
	[190 - 199] [int] NULL,
	[200 - 209] [int] NULL,
	[210 - 219] [int] NULL,
	[220 - 229] [int] NULL,
	[230 - 239] [int] NULL,
	[240 - 249] [int] NULL,
	[250 - 259] [int] NULL,
	[260 - 269] [int] NULL,
	[>269] [int] NULL
	)

SET  @StepMsg = 'inserting into temp table #STFCrossTabWeightRangesNew'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;
	
insert into #STFCrossTabWeightRangesNew
select PlantNbr, killdate, TattooNbr
		, ISNULL(SUM(CASE WHEN weightrange = 'Under160' THEN  wgtcnt END),0) [Under160]
		, ISNULL(SUM(CASE WHEN weightrange = '160 - 169' THEN  wgtcnt END),0) [160 - 169]
		, ISNULL(SUM(CASE WHEN weightrange = '170 - 179' THEN  wgtcnt END),0) [170 - 179]
		, ISNULL(SUM(CASE WHEN weightrange = '180 - 189' THEN  wgtcnt END),0) [180 - 189]
		, ISNULL(SUM(CASE WHEN weightrange = '190 - 199' THEN  wgtcnt END),0) [190 - 199]
		, ISNULL(SUM(CASE WHEN weightrange = '200 - 209' THEN  wgtcnt END),0) [200 - 209]
		, ISNULL(SUM(CASE WHEN weightrange = '210 - 219' THEN  wgtcnt END),0) [210 - 219]
		, ISNULL(SUM(CASE WHEN weightrange = '220 - 229' THEN  wgtcnt END),0) [220 - 229]
		, ISNULL(SUM(CASE WHEN weightrange = '230 - 239' THEN  wgtcnt END),0) [230 - 239]
		, ISNULL(SUM(CASE WHEN weightrange = '240 - 249' THEN  wgtcnt END),0) [240 - 249]
		, ISNULL(SUM(CASE WHEN weightrange = '250 - 259' THEN  wgtcnt END),0) [250 - 259]	
		, ISNULL(SUM(CASE WHEN weightrange = '260 - 269' THEN  wgtcnt END),0) [260 - 269]	
		, ISNULL(SUM(CASE WHEN weightrange = '>269'	  THEN  wgtcnt END),0) [>269]
		from
			(SELECT 
			  Case STF.PlantNbr when '961' then '013805' -- Seaboard Triumph Foods, LLC 
			  end as PlantNbr
			, STF.KillDate, STF.TattooNbr, STF.HotWgt, 1 as wgtcnt
			, CASE when HotWgt >= 0 and hotwgt < 160 then 'Under160'
				when HotWgt >= 160 and hotwgt < 170 then '160 - 169'
				when HotWgt >= 170 and hotwgt < 180 then '170 - 179'
				when HotWgt >= 180 and hotwgt < 190 then '180 - 189'
				when HotWgt >= 190 and hotwgt < 200 then '190 - 199'
				when HotWgt >= 200 and hotwgt < 210 then '200 - 209'
				when HotWgt >= 210 and hotwgt < 220 then '210 - 219'
				when HotWgt >= 220 and hotwgt < 230 then '220 - 229'
				when HotWgt >= 230 and hotwgt < 240 then '230 - 239'
				when HotWgt >= 240 and hotwgt < 250 then '240 - 249'
				when HotWgt >= 250 and hotwgt < 260 then '250 - 259'
				when HotWgt >= 260 and hotwgt < 270 then '260 - 269'
			else '>269'
			end  as weightrange
			FROM [$(SolomonApp)].dbo.cftPSDetSTF STF (nolock)
			WHERE KillDate > '1/3/2010' 
			) as basedata
			group by  PlantNbr, KillDate, TattooNbr

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;

SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded #STFCrossTabWeightRangesNew temp table, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
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
WHERE (((dbo_cftPigSale.SaleTypeID)='MS') and ((dbo_cftPigSale.SaleBasis) in ('CW','LW')) --This is a better criteria for Sales that should have associated carcass data.
AND ((dbo_cftPigSale.CustId)='STF') AND ((dbo_cftPigSale.DocType)<>'RE') AND ((rev.RefNbr) Is Null) AND ((dbo_cftPigSale.SaleDate)>='1/3/2010'))
) doover
where Firstque = 1


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded #FirstsTable temp table, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'                

IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg



print 'next is code to select cube data'
-------------------------------------------------------------------------------
-- generate the cube data and insert into table [$(CFFDB)].dbo.cftmarketdbSTF_stg
-------------------------------------------------------------------------------
insert into [$(CFFDB)].dbo.cftmarketdbSTF_stg
SELECT dbo_cfvDayDefinition_WithWeekInfo.PICYear_Week AS Week
, dbo_cftContact.ContactName AS Site
, dbo_cftContact_1.ContactName AS Packer
, MM.ContactName AS MktManager
, isnull(rtrim(LoadTypeTable.Description),'No LoadType') AS LoadType
, Sum(SaleSiteSTF.HCTot) AS Headcount
, Sum(SaleSiteSTF.LiveWt) AS SumOfLiveWt
, Sum(SaleSiteSTF.CarcassWt) AS SumOfCarcassWt
, Sum(SaleSiteSTF.PL) AS SumOfPL
, Sum(SaleSiteSTF.SortLoss) AS SumOfSortLoss
, Sum(tct.[Under160]) AS [SumOf0-159]
, Sum(tct.[160 - 169]) AS [SumOf160-169]
, Sum(tct.[170 - 179]) AS [SumOf170-179]
, Sum(tct.[180 - 189]) AS [SumOf180-189]
, Sum(tct.[190 - 199]) AS [SumOf190-199]
, Sum(tct.[200 - 209]) AS [SumOf200-209]
, Sum(tct.[210 - 219]) AS [SumOf210-219]
, Sum(tct.[220 - 229]) AS [SumOf220-229]
, Sum(tct.[230 - 239]) AS [SumOf230-239]
, Sum(tct.[240 - 249]) AS [SumOf240-249]
, Sum(tct.[250 - 259]) AS [SumOf250-259]
, Sum(tct.[260 - 269]) AS [SumOf260-269]
, Sum(tct.[>269]) AS [SumOf269>]
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
WHERE (((dbo_cftPigSale.SaleTypeID)='MS') and ((dbo_cftPigSale.SaleBasis) in ('CW','LW')) --This is a better criteria for Sales that should have associated carcass data.
AND ((dbo_cftPigSale.CustId)='STF') AND ((dbo_cftPigSale.DocType)<>'RE') AND ((rev.RefNbr) Is Null) AND ((dbo_cftPigSale.SaleDate)>='1/3/2010'))
GROUP BY dbo_cftPigSale.SaleDate, dbo_cftPigSale.KillDate, rtrim(dbo_cftPigSale.TattooNbr), dbo_cftPigSale.PkrContactId
) as SaleSiteSTF
left join  #FirstsTable F 
	on F.SaleDate = SaleSiteSTF.SaleDate

	and
	f.KillDate = SaleSiteSTF.KillDate
	and f.Tattoo = SaleSiteSTF.TattooNbr --Changed f.TattooNbr to f.Tattoo
	and f.PkrContactID = SaleSiteSTF.PkrContactId 
OUTER APPLY [$(SolomonApp)].dbo.cff_tvf_GetSiteMarketManagerData(f.SiteContactID, f.SaleDate ) AS MM
LEFT JOIN [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dbo_cfvDayDefinition_WithWeekInfo (nolock) ON SaleSiteSTF.SaleDate=dbo_cfvDayDefinition_WithWeekInfo.DayDate
LEFT JOIN [$(SolomonApp)].dbo.cftContact dbo_cftContact (nolock) ON dbo_cftContact.ContactID=F.SiteContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact AS dbo_cftContact_1 (nolock) ON dbo_cftContact_1.ContactID = SaleSiteSTF.PkrContactId
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
inner join #STFCrossTabWeightRangesNew tct
	on tct.PlantNbr = f.PkrContactID
	and tct.KillDate = f.KillDate
	and tct.TattooNbr = f.Tattoo
GROUP BY dbo_cfvDayDefinition_WithWeekInfo.PICYear_Week, dbo_cftContact.ContactName, dbo_cftContact_1.ContactName, MM.ContactName, LoadTypeTable.Description
print 'end of cube data select'
---------------------- end of the cube build ---------------

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

	  



















