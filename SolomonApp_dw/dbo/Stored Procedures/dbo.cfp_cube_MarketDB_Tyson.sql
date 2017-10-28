



create PROCEDURE [dbo].[cfp_cube_MarketDB_Tyson]
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
SET @ProcessName        = 'cfp_cube_MarketDB_Tyson'
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
SET  @StepMsg = 'Truncate the staging table [$(CFFDB)].dbo.cftmarketdbtyson_stg'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;

IF (OBJECT_ID ('[$(CFFDB)].dbo.cftmarketdbtyson_stg')) IS NOT NULL
	TRUNCATE TABLE [$(CFFDB)].dbo.cftmarketdbtyson_stg

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
SET @RecordsProcessed = @RowCount
SET @Comments = 'truncate staging table '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
                
               
-------------------------------------------------------------------------------
-- create temp table TysonCrossTabWeightRangesNew
-------------------------------------------------------------------------------
SET  @StepMsg = 'Create temp table TysonCrossTabWeightRangesNew'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;


IF (OBJECT_ID ('tempdb..#TysonCrossTabWeightRangesNew')) IS NOT NULL
	TRUNCATE TABLE #TysonCrossTabWeightRangesNew
Else
IF (OBJECT_ID ('tempdb..#TysonCrossTabWeightRangesNew')) IS NOT NULL
	DROP TABLE #TysonCrossTabWeightRangesNew

CREATE TABLE #TysonCrossTabWeightRangesNew (
	[PlantNbr] [varchar] (10) NOT NULL,
	[KillDate] [smalldatetime] NOT NULL,
	[TattooNbr] [varchar](10) NOT NULL,
		[Under140] [int] NULL,
		[140 - 146] [int] NULL,
		[147 - 155] [int] NULL,
		[156 - 163] [int] NULL,
		[164 - 171] [int] NULL,
		[172 - 178] [int] NULL,
		[179 - 186] [int] NULL,
		[187 - 194] [int] NULL,
		[195 - 202] [int] NULL,
		[203 - 209] [int] NULL,
		[210 - 218] [int] NULL,
		[219 - 225] [int] NULL,
		[226 - 233] [int] NULL,
		[234 - 240] [int] NULL,
		[241 - 248] [int] NULL,
		[249 - 255]	[int] NULL,
		[256 - 263]	 [int] NULL,
		[264 - 271]	 [int] NULL,
		[272 - 751]	 [int] NULL,
		[>=752] [int] NULL
	)
	
CREATE NONCLUSTERED INDEX [#TysonCrossTabWeightRangesNew_idx]
ON [dbo].[#TysonCrossTabWeightRangesNew] ([PlantNbr],[KillDate],[TattooNbr])
INCLUDE ([Under140],[140 - 146],[147 - 155],[156 - 163],[164 - 171],[172 - 178],[179 - 186],[187 - 194],[195 - 202],[203 - 209],[210 - 218],[219 - 225],[226 - 233],[234 - 240],[241 - 248],[249 - 255],[256 - 263],[264 - 271],[272 - 751],[>=752])


SET  @StepMsg = 'insert into temp table TysonCrossTabWeightRangesNew'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;
	
insert into #TysonCrossTabWeightRangesNew
select [PlantNbr]
		,[KillDate]
		,[TattooNbr]
		, ISNULL(SUM(CASE WHEN weightrange = 'Under140' THEN  wgtcnt END),0) [Under140]
		, ISNULL(SUM(CASE WHEN weightrange = '140 - 146' THEN  wgtcnt END),0) [140 - 146]
		, ISNULL(SUM(CASE WHEN weightrange = '147 - 155' THEN  wgtcnt END),0) [147 - 155]
		, ISNULL(SUM(CASE WHEN weightrange = '156 - 163' THEN  wgtcnt END),0) [156 - 163]
		, ISNULL(SUM(CASE WHEN weightrange = '164 - 171' THEN  wgtcnt END),0) [164 - 171]
		, ISNULL(SUM(CASE WHEN weightrange = '172 - 178' THEN  wgtcnt END),0) [172 - 178]
		, ISNULL(SUM(CASE WHEN weightrange = '179 - 186' THEN  wgtcnt END),0) [179 - 186]
		, ISNULL(SUM(CASE WHEN weightrange = '187 - 194' THEN  wgtcnt END),0) [187 - 194]
		, ISNULL(SUM(CASE WHEN weightrange = '195 - 202' THEN  wgtcnt END),0) [195 - 202]
		, ISNULL(SUM(CASE WHEN weightrange = '203 - 209' THEN  wgtcnt END),0) [203 - 209]
		, ISNULL(SUM(CASE WHEN weightrange = '210 - 218' THEN  wgtcnt END),0) [210 - 218]
		, ISNULL(SUM(CASE WHEN weightrange = '219 - 225' THEN  wgtcnt END),0) [219 - 225]
		, ISNULL(SUM(CASE WHEN weightrange = '226 - 233' THEN  wgtcnt END),0) [226 - 233]
		, ISNULL(SUM(CASE WHEN weightrange = '234 - 240' THEN  wgtcnt END),0) [234 - 240]
		, ISNULL(SUM(CASE WHEN weightrange = '241 - 248' THEN  wgtcnt END),0) [241 - 248]
		, ISNULL(SUM(CASE WHEN weightrange = '249 - 255' THEN  wgtcnt END),0) [249 - 255]		
		, ISNULL(SUM(CASE WHEN weightrange = '256 - 263' THEN  wgtcnt END),0) [256 - 263]	
		, ISNULL(SUM(CASE WHEN weightrange = '264 - 271' THEN  wgtcnt END),0) [264 - 271]	
		, ISNULL(SUM(CASE WHEN weightrange = '272 - 751' THEN  wgtcnt END),0) [272 - 751]	
		, ISNULL(SUM(CASE WHEN weightrange = '>=752'	  THEN  wgtcnt END),0) [>=752]
		from
			(select 
					 Case PlantCode when '038' then '003348' -- IBP Logansport
									when '38' then '003348' -- IBP Logansport
									when '069' then '000817' -- IBP Storm Lake
									when '69' then '000817' -- IBP Storm Lake
									when '072' then '001013' -- IBP Columbus Jctn
									when '72' then '001013' -- IBP Columbus Jctn
									when '086' then '000824' -- IBP Madison
									when '86' then '000824' -- IBP Madison									
									when '088' then '000823' -- IBP Waterloo
									when '88' then '000823' -- IBP Waterloo
									when '089' then '001016' -- Tyson (Perry)
									when '89' then '001016' -- Tyson (Perry)	  
					end as PlantNbr
			, Tyson.KillDate, Tyson.Tattoo as tattoonbr, TotalHead as wgtcnt
			, CASE
				--This handles all the Tyson Plants except Tyson (Perry)
				when LowWeightRange >= 0 and LowWeightRange < 140 and PlantCode not in ('089','89') then 'Under140'
				when LowWeightRange >= 140 and LowWeightRange < 147 and PlantCode not in ('089','89') then '140 - 146'			
				when LowWeightRange >= 147 and LowWeightRange < 156 and PlantCode not in ('089','89') then '147 - 155'
				when LowWeightRange >= 156 and LowWeightRange < 164 and PlantCode not in ('089','89') then '156 - 163'
				when LowWeightRange >= 164 and LowWeightRange < 172 and PlantCode not in ('089','89') then '164 - 171'
				when LowWeightRange >= 172 and LowWeightRange < 179 and PlantCode not in ('089','89') then '172 - 178'
				when LowWeightRange >= 179 and LowWeightRange < 187 and PlantCode not in ('089','89') then '179 - 186'
				when LowWeightRange >= 187 and LowWeightRange < 195 and PlantCode not in ('089','89') then '187 - 194'
				when LowWeightRange >= 195 and LowWeightRange < 203 and PlantCode not in ('089','89') then '195 - 202'
				when LowWeightRange >= 203 and LowWeightRange < 210 and PlantCode not in ('089','89') then '203 - 209'
				when LowWeightRange >= 210 and LowWeightRange < 219 and PlantCode not in ('089','89') then '210 - 218'
				when LowWeightRange >= 219 and LowWeightRange < 226 and PlantCode not in ('089','89') then '219 - 225'
				when LowWeightRange >= 226 and LowWeightRange < 234 and PlantCode not in ('089','89') then '226 - 233'
				when LowWeightRange >= 234 and LowWeightRange < 241 and PlantCode not in ('089','89') then '234 - 240'
				when LowWeightRange >= 241 and LowWeightRange < 249 and PlantCode not in ('089','89') then '241 - 248'
				when LowWeightRange >= 249 and LowWeightRange < 256 and PlantCode not in ('089','89') then '249 - 255'
				when LowWeightRange >= 256 and LowWeightRange < 264 and PlantCode not in ('089','89') then '256 - 263'
				when LowWeightRange >= 264 and LowWeightRange < 272 and PlantCode not in ('089','89') then '264 - 271'
				when LowWeightRange >= 272 and LowWeightRange < 752 and PlantCode not in ('089','89') then '272 - 751'
				-- This handles the Tyson (Perry) carcass weight ranges and converts them to unskinned weight
				when LowWeightRange >= 0 and LowWeightRange < 125 and PlantCode in ('089','89') then 'Under140'
				when LowWeightRange >= 125 and LowWeightRange < 131 and PlantCode in ('089','89') then '140 - 146'				
				when LowWeightRange >= 131 and LowWeightRange < 139 and PlantCode in ('089','89') then '147 - 155'				
				when LowWeightRange >= 139 and LowWeightRange < 146 and PlantCode in ('089','89') then '156 - 163'				
				when LowWeightRange >= 146 and LowWeightRange < 153 and PlantCode in ('089','89') then '164 - 171'				
				when LowWeightRange >= 153 and LowWeightRange < 159 and PlantCode in ('089','89') then '172 - 178'				
				when LowWeightRange >= 159 and LowWeightRange < 167 and PlantCode in ('089','89') then '179 - 186'				
				when LowWeightRange >= 167 and LowWeightRange < 174 and PlantCode in ('089','89') then '187 - 194'
				when LowWeightRange >= 174 and LowWeightRange < 181 and PlantCode in ('089','89') then '195 - 202'
				when LowWeightRange >= 181 and LowWeightRange < 187 and PlantCode in ('089','89') then '203 - 209'
				when LowWeightRange >= 187 and LowWeightRange < 195 and PlantCode in ('089','89') then '210 - 218'
				when LowWeightRange >= 195 and LowWeightRange < 201 and PlantCode in ('089','89') then '219 - 225'
				when LowWeightRange >= 201 and LowWeightRange < 209 and PlantCode in ('089','89') then '226 - 233'
				when LowWeightRange >= 209 and LowWeightRange < 215 and PlantCode in ('089','89') then '234 - 240'
				when LowWeightRange >= 215 and LowWeightRange < 222 and PlantCode in ('089','89') then '241 - 248'
				when LowWeightRange >= 222 and LowWeightRange < 228 and PlantCode in ('089','89') then '249 - 255'
				when LowWeightRange >= 228 and LowWeightRange < 235 and PlantCode in ('089','89') then '256 - 263'
				when LowWeightRange >= 235 and LowWeightRange < 242 and PlantCode in ('089','89') then '264 - 271'
				when LowWeightRange >= 242 and LowWeightRange < 671 and PlantCode in ('089','89') then '272 - 751'				
			else '>=752'
			end  as weightrange
			FROM [$(SolomonApp)].dbo.cftPSDetTyson Tyson (nolock)
			WHERE KillDate > '1/3/2010'
			) as basedata
			group by  PlantNbr, KillDate, tattoonbr

-- added index for perf cftPSDetTyson_killdate_incl

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded TysonCrossTabWeightRangesNew temp table, '
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

CREATE NONCLUSTERED INDEX [#firsttable_x1]
ON [dbo].[#FirstsTable] ([SaleDate],[KillDate],[Tattoo],[PkrContactID])
INCLUDE ([SiteContactID],[PMLoadID])

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
WHERE (((dbo_cftPigSale.SaleTypeID)='MS') AND ((dbo_cftPigSale.CustId)='TYS') AND ((dbo_cftPigSale.DocType)<>'RE') AND ((rev.RefNbr) Is Null) AND ((dbo_cftPigSale.SaleDate)>='1/3/2010'))
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
-------------------------------------------------------------------------------
-- generate the cube data and insert into table [$(CFFDB)].dbo.cftmarketdbtyson_stg
-------------------------------------------------------------------------------
IF (OBJECT_ID ('[$(CFFDB)].dbo.cftmarketdbtyson_stg')) IS NOT NULL
	TRUNCATE TABLE [$(CFFDB)].dbo.cftmarketdbtyson_stg
	
--PigSaleDetailTyson3:
insert into [$(CFFDB)].dbo.cftmarketdbtyson_stg
SELECT dbo_cfvDayDefinition_WithWeekInfo.PICYear_Week AS Week
, rtrim(dbo_cftContact.ContactName) AS Site
, rtrim(dbo_cftContact_1.ContactName) AS Packer
, rtrim(MM.ContactName) AS MktManager
, isnull(rtrim(LoadTypeTable.Description),'No LoadType') AS LoadType
, Sum(SaleSiteTriumph5.HCTot) AS Headcount
, Sum(SaleSiteTriumph5.LiveWt) AS SumOfLiveWt
, Sum(SaleSiteTriumph5.CarcassWt) AS SumOfCarcassWt
, Sum(SaleSiteTriumph5.PL) AS SumOfPL
, Sum(SaleSiteTriumph5.SortLoss) AS SumOfSortLoss	
, Sum(tct.[Under140]) AS [SumOfUnder140]
, Sum(tct.[140 - 146]) AS [SumOf140 - 146]
, Sum(tct.[147 - 155]) AS [SumOf147 - 155]
, Sum(tct.[156 - 163]) AS [SumOf156 - 163]
, Sum(tct.[164 - 171]) AS [SumOf164 - 171]
, Sum(tct.[172 - 178]) AS [SumOf172 - 178]
, Sum(tct.[179 - 186]) AS [SumOf179 - 186]
, Sum(tct.[187 - 194]) AS [SumOf187 - 194]
, Sum(tct.[195 - 202]) AS [SumOf195 - 202]
, Sum(tct.[203 - 209]) AS [SumOf203 - 209]
, Sum(tct.[210 - 218]) AS [SumOf210 - 218]
, Sum(tct.[219 - 225]) AS [SumOf219 - 225]
, Sum(tct.[226 - 233]) AS [SumOf226 - 233]
, Sum(tct.[234 - 240]) AS [SumOf234 - 240]
, Sum(tct.[241 - 248]) AS [SumOf241 - 248]
, Sum(tct.[249 - 255]) AS [SumOf249 - 255]
, Sum(tct.[256 - 263]) AS [SumOf256 - 263]
, Sum(tct.[264 - 271]) AS [SumOf264 - 271]
, Sum(tct.[272 - 751]) AS [SumOf272 - 751]
, Sum(tct.[>=752]) AS [SumOf>=752]
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
--WHERE (((dbo_cftPigSale.SaleBasis)='CW') --This is a better criteria than SaleBasis<>'LW'
WHERE (((dbo_cftPigSale.SaleTypeID)='MS') and ((dbo_cftPigSale.SaleBasis) in ('CW','LW')) --This is a better criteria for Sales that should have associated carcass data.
AND ((dbo_cftPigSale.CustId)='TYS') AND ((dbo_cftPigSale.DocType)<>'RE') AND ((rev.RefNbr) Is Null)
AND ((dbo_cftPigSale.SaleDate)>='1/3/2010'))
GROUP BY dbo_cftPigSale.SaleDate, dbo_cftPigSale.KillDate, rtrim(dbo_cftPigSale.TattooNbr), dbo_cftPigSale.PkrContactId
) as SaleSiteTriumph5
left join  #FirstsTable F 
	on F.SaleDate = SaleSiteTriumph5.SaleDate
	and
	f.KillDate = SaleSiteTriumph5.KillDate
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
inner join #TysonCrossTabWeightRangesNew tct
	on tct.PlantNbr = f.PkrContactID
	and tct.KillDate = f.KillDate
	and tct.TattooNbr = f.Tattoo
GROUP BY dbo_cfvDayDefinition_WithWeekInfo.PICYear_Week, dbo_cftContact.ContactName, dbo_cftContact_1.ContactName, MM.ContactName, LoadTypeTable.Description



---------------------- end of the cube build ---------------


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cube table, '
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
    ON OBJECT::[dbo].[cfp_cube_MarketDB_Tyson] TO [SE\ssis_datareader]
    AS [dbo];

