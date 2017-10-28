CREATE PROCEDURE 
	[dbo].[cfp_REPORT_MORTALITY_DETAIL_BY_PIC_DATE_vRPTGRP2_v20_m]
		@PicDate			char(06)
      ,	@PigProdPhaseID		varchar(03)
      ,	@NumWeeks			int
      ,	@ReportingGroupID	varchar(10)
      ,	@PhaseDesc			varchar(30)
      ,	@SrSvcManager		varchar(100)
      ,	@SvcManager			varchar(100)
      ,	@SiteContactID		varchar(06)
AS

SET NOCOUNT, XACT_ABORT ON ; 
-- 201312 smr reporting group enhancement
-- 2/22/2016, BMD, Updated to exclude SBF Pig Groups

IF RTRIM(@ReportingGroupID) = -1
	SET @ReportingGroupID = '%'

DECLARE 
	@PicYear 			char(4)		=	'20' + LEFT( @PicDate, 2 )
  , @PicWeek 			char(2)		=	RIGHT( @PicDate, 2 )
  , @PicStartDate 		datetime
  , @PicStartDateSingle datetime
  , @PicEndDate 		datetime ; 
  
SELECT	@PicEndDate 		= 	WeekEndDate FROM [$(SolomonApp)].dbo.cftWeekDefinition WHERE PicYear = CAST( @PicYear AS INT ) AND PicWeek = CAST( @PicWeek AS INT ) ; 
SELECT  @PicStartDate 		= 	WeekOfDate  FROM [$(SolomonApp)].dbo.cftWeekDefinition WHERE DATEADD( wk, -@NumWeeks, @PicEndDate ) BETWEEN WeekOfDate AND WeekEndDate ;
SELECT  @PicStartDateSingle = 	WeekOfDate  FROM [$(SolomonApp)].dbo.cftWeekDefinition WHERE DATEADD( wk, -0, @PicEndDate ) BETWEEN WeekOfDate AND WeekEndDate ;

---------------------------------------------------------------------
--first week
---------------------------------------------------------------------
CREATE TABLE #PicRange ( PicDate char(6) ) ;
INSERT INTO  #PicRange
SELECT CAST( RIGHT( PicYear, 2 ) AS VARCHAR ) + 'WK' + RIGHT( '0' + CAST( PicWeek AS VARCHAR ), 2 ) AS PicDate
FROM   [$(SolomonApp)].dbo.cftWeekDefinition
WHERE  WeekOfDate >= @PicStartDateSingle
		AND WeekEndDate <= @PicEndDate ;

---------------------------------------------------------------------
--all weeks
---------------------------------------------------------------------
CREATE TABLE #PicRangeFull (PicDate char(6))
INSERT INTO #PicRangeFull
SELECT CAST(RIGHT(PicYear,2) AS VARCHAR) + 'WK' + RIGHT('0' + CAST(PicWeek AS VARCHAR),2) PicDate
FROM   [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK)
WHERE  WeekOfDate >= @PicStartDate
		AND	WeekEndDate <= @PicEndDate

---------------------------------------------------------------------
--eligible ReportingGroupID's and phases
--only eligible if the ReportingGroupID and pigprodphaseid have data for first week
---------------------------------------------------------------------
CREATE TABLE #ReportSites ( ReportingGroupID int, PigProdPhaseID char(3), PigGroupID int )
INSERT INTO 
	#ReportSites
SELECT DISTINCT 
	ReportingGroupID
  , cft_PIG_GROUP_CENSUS.PigProdPhaseID
  , cft_PIG_GROUP_CENSUS.PigGroupID
FROM 
	 dbo.cft_PIG_GROUP_CENSUS_m AS cft_PIG_GROUP_CENSUS 
INNER JOIN 
	[$(SolomonApp)].dbo.cftpiggroup AS cpp 
		ON cft_PIG_GROUP_CENSUS.PigGroupID = cpp.PigGroupID 
WHERE 
	cft_PIG_GROUP_CENSUS.PICYear_Week = @PicDate
		AND cpp.PigProdPodID!= 53 -- Ignore SBF groups

--get data
SELECT 
	cft_PIG_GROUP_CENSUS.PigGroupID
  ,	cft_PIG_GROUP_CENSUS.ReportingGroupID
  ,	cft_PIG_FLOW_REPORTING_GROUP.Reporting_Group_Description
  ,	SiteContactID			=	cftContact.ContactID
  ,	SiteName				=	cftContact.ContactName 
  ,	cft_PIG_GROUP_CENSUS.SrSvcManager	-- added for modification to Mortality detail ssrs report change   20120813 sripley
  ,	cft_PIG_GROUP_CENSUS.SvcManager
  ,	PGDescription			=	cft_PIG_GROUP_CENSUS.Description 
  ,	cft_PIG_GROUP_CENSUS.PodDescription
  ,	cft_PIG_GROUP_BASE_SOURCE.BaseSource
  ,	cft_PIG_GROUP_CENSUS.PICYear_Week
  ,	cft_PIG_GROUP_CENSUS.PigProdPhaseID
  ,	cft_PIG_GROUP_CENSUS.PhaseDesc
  ,	cft_PIG_GROUP_CENSUS.NurserySource
  ,	cft_PIG_GROUP_CENSUS.PigFlowStartDate
  , StartingWeight			=	groupStart.Wgt	
  ,	SUMCurrentInv			=	SUM(cft_PIG_GROUP_CENSUS.CurrentInv) 
  ,	SUMPigDeaths			=	SUM(cft_PIG_GROUP_CENSUS.PigDeaths) 
  ,	SUMCumulativePigDeaths	=	SUM(cft_PIG_GROUP_CENSUS.CumulativePigDeaths) 
  ,	SUMHeadStarted			=	SUM(cft_PIG_GROUP_CENSUS.HeadStarted) 
  ,	MortalityPercent		=	CASE SUM(cft_PIG_GROUP_CENSUS.HeadStarted)
									WHEN 0 THEN 0 
									ELSE CONVERT( numeric(10, 2), ( CONVERT( numeric( 10,2 ), SUM(cft_PIG_GROUP_CENSUS.CumulativePigDeaths) ) / CONVERT( numeric( 10,2 ), SUM(cft_PIG_GROUP_CENSUS.HeadStarted) ) ) * 100 )
								END
,   Site.BioSecurityLevel -- BMD 20130807 added to color code groups on Mortality Detail SSRS report based upon BioSecurityLevel
,	99999 as SortOrder
INTO 
	#ReportData_init
FROM 
	 dbo.cft_PIG_GROUP_CENSUS_m AS cft_PIG_GROUP_CENSUS
INNER JOIN 
	[$(SolomonApp)].dbo.cftPigGroup AS cpp 
		ON cft_PIG_GROUP_CENSUS.PigGroupID = cpp.PigGroupID 
			AND cpp.PigProdPodID != 53 -- Ignore SBF groups
INNER JOIN 
	[$(CFApp_PigManagement)].dbo.cft_PIG_FLOW_REPORTING_GROUP AS cft_PIG_FLOW_REPORTING_GROUP
		ON cft_PIG_FLOW_REPORTING_GROUP.ReportingGroupID = cft_PIG_GROUP_CENSUS.ReportingGroupID
INNER JOIN
	[$(SolomonApp)].dbo.cfv_GroupStart AS groupStart
		ON groupStart.PigGroupID = cft_PIG_GROUP_CENSUS.PigGroupID
LEFT JOIN 
	[$(CentralData)].dbo.Site AS site 
		ON site.contactid=cft_PIG_GROUP_CENSUS.SiteContactID
LEFT JOIN 
	[$(SolomonApp)].dbo.cftContact AS cftContact 
		ON cftContact.ContactID = cft_PIG_GROUP_CENSUS.SiteContactID
LEFT JOIN 
	 dbo.cft_PIG_GROUP_BASE_SOURCE AS cft_PIG_GROUP_BASE_SOURCE
		ON cft_PIG_GROUP_BASE_SOURCE.PigGroupID = cft_PIG_GROUP_CENSUS.PigGroupID
INNER JOIN 
	#PicRangeFull AS PicRange
		ON PicRange.PicDate = cft_PIG_GROUP_CENSUS.PICYear_Week
INNER JOIN 
	#ReportSites AS ReportSites
		ON ReportSites.ReportingGroupID = cft_PIG_GROUP_CENSUS.ReportingGroupID
			AND ReportSites.PigProdPhaseID = cft_PIG_GROUP_CENSUS.PigProdPhaseID
			AND ReportSites.PigGroupID = cft_PIG_GROUP_CENSUS.PigGroupID
WHERE 
	cft_PIG_GROUP_CENSUS.PigProdPhaseID 				LIKE @PigProdPhaseID
		AND	cft_PIG_GROUP_CENSUS.ReportingGroupID 		LIKE @ReportingGroupID
		AND cft_PIG_GROUP_CENSUS.PhaseDesc 				LIKE @PhaseDesc
		AND	RTRIM(cft_PIG_GROUP_CENSUS.SrSvcManager) 	LIKE RTRIM(@SrSvcManager)
		AND RTRIM(cft_PIG_GROUP_CENSUS.SvcManager) 		LIKE RTRIM(@SvcManager)
		AND RTRIM(cft_PIG_GROUP_CENSUS.SiteContactID) 	LIKE RTRIM(@SiteContactID)
        AND cpp.PigProdPodID != 53
        AND cpp.PGStatusID = 'A' 

GROUP BY 
	cft_PIG_GROUP_CENSUS.PigGroupID
  ,	cft_PIG_GROUP_CENSUS.ReportingGroupID
  ,	cft_PIG_FLOW_REPORTING_GROUP.Reporting_Group_Description
  ,	cftContact.ContactID
  ,	cftContact.ContactName
  ,	cft_PIG_GROUP_CENSUS.SrSvcManager			-- added for modification to Mortality detail ssrs report change   20120813 sripley
  ,	cft_PIG_GROUP_CENSUS.SvcManager
  ,	cft_PIG_GROUP_CENSUS.Description
  ,	cft_PIG_GROUP_CENSUS.PodDescription
  ,	cft_PIG_GROUP_BASE_SOURCE.BaseSource
  ,	cft_PIG_GROUP_CENSUS.PICYear_Week
  ,	cft_PIG_GROUP_CENSUS.PigProdPhaseID
  ,	cft_PIG_GROUP_CENSUS.PhaseDesc
  ,	cft_PIG_GROUP_CENSUS.NurserySource
  ,	cft_PIG_GROUP_CENSUS.PigFlowStartDate
  , groupStart.Wgt	
  , Site.BioSecurityLevel ; 

------------------------------------------------------------------
--SORTING
------------------------------------------------------------------
SELECT 
	IDENTITY (int) as SortID
  , SiteContactID
  , MIN(PigFlowStartDate) AS PigFlowStartDate 
INTO 
	#Sort1 
FROM 
	#ReportData_init 
GROUP BY 
	SiteContactID 
ORDER BY 
	MIN(PigFlowStartDate) ; 

UPDATE 
	#ReportData_init
SET 
	SortOrder = Sort1.SortID
FROM 
	#ReportData_init AS ReportData
INNER JOIN 
	#Sort1 AS Sort1
		ON Sort1.SiteContactID = ReportData.SiteContactID ; 
------------------------------------------------------------------
--END SORTING
------------------------------------------------------------------

SELECT * FROM #ReportData_init ORDER BY SortOrder, PigFlowStartDate

DROP TABLE #ReportData_init ;
DROP TABLE #Sort1 ;
DROP TABLE #PicRange ;
DROP TABLE #PicRangeFull ;
DROP TABLE #ReportSites ;

