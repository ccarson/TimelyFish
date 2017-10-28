









CREATE PROCEDURE [dbo].[cfp_REPORT_MORTALITY_DETAIL_BY_PIC_DATE_vRPTGRP22]
	@PicDate				CHAR(6)
,	@PigProdPhaseID			VARCHAR(3)
,	@NumWeeks				int
,	@ReportingGroupID				VARCHAR(10)
,	@PhaseDesc				VARCHAR(30)
,	@SrSvcManager			VARCHAR(100)
,	@SvcManager				VARCHAR(100)
,	@SiteContactID			VARCHAR(6)
AS

-- 201312 smr reporting group enhancement

IF RTRIM(@ReportingGroupID) = -1
	SET @ReportingGroupID = '%'

DECLARE @PicYear char(4)
DECLARE @PicWeek char(2)
DECLARE @PicStartDate datetime
DECLARE @PicStartDateSingle datetime
DECLARE @PicEndDate datetime
SET @PicYear = '20' + LEFT(@PicDate,2)
SET @PicWeek = RIGHT(@PicDate,2)

SELECT @PicEndDate = WeekEndDate FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE PicYear = CAST(@PicYear AS INT) AND PicWeek = CAST(@PicWeek AS INT)
SELECT @PicStartDate = WeekOfDate FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE DATEADD(wk,-@NumWeeks,@PicEndDate) BETWEEN WeekOfDate AND WeekEndDate
SELECT @PicStartDateSingle = WeekOfDate FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE DATEADD(wk,-0,@PicEndDate) BETWEEN WeekOfDate AND WeekEndDate

---------------------------------------------------------------------
--first week
---------------------------------------------------------------------
CREATE TABLE #PicRange (PicDate char(6))
INSERT INTO #PicRange
SELECT CAST(RIGHT(PicYear,2) AS VARCHAR) + 'WK' + RIGHT('0' + CAST(PicWeek AS VARCHAR),2) PicDate
FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK)
WHERE	WeekOfDate >= @PicStartDateSingle
AND		WeekEndDate <= @PicEndDate

---------------------------------------------------------------------
--all weeks
---------------------------------------------------------------------
CREATE TABLE #PicRangeFull (PicDate char(6))
INSERT INTO #PicRangeFull
SELECT CAST(RIGHT(PicYear,2) AS VARCHAR) + 'WK' + RIGHT('0' + CAST(PicWeek AS VARCHAR),2) PicDate
FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK)
WHERE	WeekOfDate >= @PicStartDate
AND		WeekEndDate <= @PicEndDate

---------------------------------------------------------------------
--eligible ReportingGroupID's and phases
--only eligible if the ReportingGroupID and pigprodphaseid have data for first week
---------------------------------------------------------------------
CREATE TABLE #ReportSites (ReportingGroupID int, PigProdPhaseID char(3), PigGroupID int)
INSERT INTO #ReportSites
select distinct ReportingGroupID, PigProdPhaseID, PigGroupID
FROM  dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (NOLOCK)
WHERE EXISTS (SELECT x.* FROM  dbo.cft_PIG_GROUP_CENSUS x (NOLOCK)
		WHERE x.PigProdPhaseID = cft_PIG_GROUP_CENSUS.PigProdPhaseID
		AND x.PICYear_Week = @PicDate)
AND cft_PIG_GROUP_CENSUS.PICYear_Week = @PicDate


--get data
SELECT 
	cft_PIG_GROUP_CENSUS.PigGroupID
,	cft_PIG_GROUP_CENSUS.ReportingGroupID
,	cft_PIG_FLOW_REPORTING_GROUP.Reporting_Group_Description
,	cftContact.ContactID SiteContactID
,	cftContact.ContactName SiteName
,	cft_PIG_GROUP_CENSUS.SrSvcManager	-- added for modification to Mortality detail ssrs report change   20120813 sripley
,	cft_PIG_GROUP_CENSUS.SvcManager
,	cft_PIG_GROUP_CENSUS.Description PGDescription
,	cft_PIG_GROUP_CENSUS.PodDescription
,	cft_PIG_GROUP_BASE_SOURCE.BaseSource
,	cft_PIG_GROUP_CENSUS.PICYear_Week
,	cft_PIG_GROUP_CENSUS.PigProdPhaseID
,	cft_PIG_GROUP_CENSUS.PhaseDesc
,	cft_PIG_GROUP_CENSUS.NurserySource
,	cft_PIG_GROUP_CENSUS.PigFlowStartDate
,	SUM(cft_PIG_GROUP_CENSUS.CurrentInv) SUMCurrentInv
,	SUM(cft_PIG_GROUP_CENSUS.PigDeaths) SUMPigDeaths
,	SUM(cft_PIG_GROUP_CENSUS.CumulativePigDeaths) SUMCumulativePigDeaths
,	SUM(cft_PIG_GROUP_CENSUS.HeadStarted) SUMHeadStarted
,	case when CAST(SUM(cft_PIG_GROUP_CENSUS.HeadStarted) AS NUMERIC(10,2)) = 0
		then 0
		else CAST((CAST(SUM(cft_PIG_GROUP_CENSUS.CumulativePigDeaths) AS NUMERIC(10,2)) / CAST(SUM(cft_PIG_GROUP_CENSUS.HeadStarted) AS NUMERIC(10,2))) * 100 AS NUMERIC(10,2)) 
	end MortalityPercent
,   Site.BioSecurityLevel -- BMD 20130807 added to color code groups on Mortality Detail SSRS report based upon BioSecurityLevel
,	99999 as SortOrder
INTO #ReportData_init
FROM  dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (NOLOCK)
JOIN [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW_REPORTING_GROUP cft_PIG_FLOW_REPORTING_GROUP (NOLOCK)
	ON cft_PIG_FLOW_REPORTING_GROUP.ReportingGroupID = cft_PIG_GROUP_CENSUS.ReportingGroupID
LEFT Join [$(CentralData)].dbo.Site SITE (NOLOCK) on site.contactid=cft_PIG_GROUP_CENSUS.SiteContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact cftContact (NOLOCK)
	ON cftContact.ContactID = cft_PIG_GROUP_CENSUS.SiteContactID
LEFT JOIN  dbo.cft_PIG_GROUP_BASE_SOURCE cft_PIG_GROUP_BASE_SOURCE (NOLOCK)
	ON cft_PIG_GROUP_BASE_SOURCE.PigGroupID = cft_PIG_GROUP_CENSUS.PigGroupID
JOIN #PicRangeFull PicRange
	ON PicRange.PicDate = cft_PIG_GROUP_CENSUS.PICYear_Week
JOIN #ReportSites ReportSites
	ON ReportSites.ReportingGroupID = cft_PIG_GROUP_CENSUS.ReportingGroupID
	AND ReportSites.PigProdPhaseID = cft_PIG_GROUP_CENSUS.PigProdPhaseID
	AND ReportSites.PigGroupID = cft_PIG_GROUP_CENSUS.PigGroupID
WHERE cft_PIG_GROUP_CENSUS.PigProdPhaseID like @PigProdPhaseID
AND	cft_PIG_GROUP_CENSUS.ReportingGroupID like @ReportingGroupID
AND cft_PIG_GROUP_CENSUS.PhaseDesc like @PhaseDesc
AND	RTRIM(cft_PIG_GROUP_CENSUS.SrSvcManager) LIKE RTRIM(@SrSvcManager)
AND RTRIM(cft_PIG_GROUP_CENSUS.SvcManager) like RTRIM(@SvcManager)
AND RTRIM(cft_PIG_GROUP_CENSUS.SiteContactID) like RTRIM(@SiteContactID)

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
,   Site.BioSecurityLevel
ORDER BY
	cft_PIG_GROUP_CENSUS.PodDescription
,	cft_PIG_FLOW_REPORTING_GROUP.Reporting_Group_Description
,	cft_PIG_GROUP_CENSUS.PhaseDesc
,	cft_PIG_GROUP_CENSUS.Description
,	SUMCumulativePigDeaths


------------------------------------------------------------------
--SORTING
------------------------------------------------------------------
SELECT IDENTITY (int) as SortID, SiteContactID, MIN(PigFlowStartDate) AS PigFlowStartDate INTO #Sort1 FROM #ReportData_init GROUP BY SiteContactID ORDER BY MIN(PigFlowStartDate)

UPDATE #ReportData_init
SET SortOrder = Sort1.SortID
FROM #ReportData_init ReportData
JOIN #Sort1 Sort1
	ON Sort1.SiteContactID = ReportData.SiteContactID
------------------------------------------------------------------
--END SORTING
------------------------------------------------------------------

SELECT * FROM #ReportData_init ORDER BY SortOrder, PigFlowStartDate, SUMCumulativePigDeaths			--added so cumulative pig deaths display correct total 20141112 NJH


DROP TABLE #ReportData_init
DROP TABLE #Sort1
DROP TABLE #PicRange
DROP TABLE #PicRangeFull
DROP TABLE #ReportSites










