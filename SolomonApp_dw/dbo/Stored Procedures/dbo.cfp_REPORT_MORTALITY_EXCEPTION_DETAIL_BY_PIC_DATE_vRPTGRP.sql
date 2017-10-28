

-- 201312 smr reporting group enhancement


CREATE PROCEDURE [dbo].[cfp_REPORT_MORTALITY_EXCEPTION_DETAIL_BY_PIC_DATE_vRPTGRP]
	@PicDate				CHAR(6)
,	@PigProdPhaseID			VARCHAR(3)
,	@NumWeeks				int
,	@PigFlowID				VARCHAR(10)
,	@PhaseDesc				VARCHAR(30)
,	@SrSvcManager			VARCHAR(100)
,	@SvcManager				VARCHAR(100)
,	@SiteContactID			VARCHAR(6)
,	@MortExcept				VARCHAR(6)
AS

IF RTRIM(@PigFlowID) = -1
	SET @PigFlowID = '%'

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
--eligible pigflowid's and phases
--only eligible if the pigflowid and pigprodphaseid have data for first week
---------------------------------------------------------------------
CREATE TABLE #ReportSites (PigFlowID int, PigProdPhaseID char(3), PigGroupID int)
INSERT INTO #ReportSites
select distinct PigFlowID, PigProdPhaseID, PigGroupID
FROM  dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (NOLOCK)
WHERE EXISTS (SELECT x.* FROM  dbo.cft_PIG_GROUP_CENSUS x (NOLOCK)
		WHERE x.PigProdPhaseID = cft_PIG_GROUP_CENSUS.PigProdPhaseID
		AND x.PICYear_Week = @PicDate)
AND cft_PIG_GROUP_CENSUS.PICYear_Week = @PicDate


--get data
SELECT 
	cft_PIG_GROUP_CENSUS.PigGroupID
,	cft_PIG_GROUP_CENSUS.PigFlowID
,	cft_PIG_FLOW.PigFlowDescription
,	cftContact.ContactID SiteContactID
,	cftContact.ContactName SiteName
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
,	ME.MortExcept
,	case when CAST(SUM(cft_PIG_GROUP_CENSUS.HeadStarted) AS NUMERIC(10,2)) = 0
		then 0
		else CAST((CAST(SUM(cft_PIG_GROUP_CENSUS.CumulativePigDeaths) AS NUMERIC(10,2)) / CAST(SUM(cft_PIG_GROUP_CENSUS.HeadStarted) AS NUMERIC(10,2))) * 100 AS NUMERIC(10,2)) 
	end MortalityPercent
,	99999 as SortOrder
,	cft_PIG_GROUP_CENSUS.reportinggroupid		-- 201312 smr reporting group enhancement
INTO #ReportData
FROM  dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (NOLOCK)
JOIN [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW cft_PIG_FLOW (NOLOCK)
	ON cft_PIG_FLOW.PigFlowID = cft_PIG_GROUP_CENSUS.PigFlowID
LEFT JOIN [$(SolomonApp)].dbo.cftContact cftContact (NOLOCK)
	ON cftContact.ContactID = cft_PIG_GROUP_CENSUS.SiteContactID
LEFT JOIN  dbo.cft_PIG_GROUP_BASE_SOURCE cft_PIG_GROUP_BASE_SOURCE (NOLOCK)
	ON cft_PIG_GROUP_BASE_SOURCE.PigGroupID = cft_PIG_GROUP_CENSUS.PigGroupID
JOIN #PicRangeFull PicRange
	ON PicRange.PicDate = cft_PIG_GROUP_CENSUS.PICYear_Week
JOIN #ReportSites ReportSites
	ON ReportSites.PigFlowID = cft_PIG_GROUP_CENSUS.PigFlowID
	AND ReportSites.PigProdPhaseID = cft_PIG_GROUP_CENSUS.PigProdPhaseID
	AND ReportSites.PigGroupID = cft_PIG_GROUP_CENSUS.PigGroupID
LEFT JOIN (Select MEX.PigFlowID, MEX.PigProdPhaseID, Sum(MEX.MortExcept) as MortExcept
	From (Select PigFlowID, PigProdPhaseID, PICYear_Week, 
	Case when Sum(PigDeaths)/(Sum(CurrentInv)*1.00) * 100 >= @MortExcept 
	then 1 else 0 end as MortExcept
	from  dbo.cft_PIG_GROUP_CENSUS PGC
	left join [$(SolomonApp)].dbo.cftWeekDefinition WD
	on PGC.PICYear_Week = CAST(RIGHT(WD.PicYear,2) AS VARCHAR) + 'WK' + RIGHT('0' + CAST(WD.PicWeek AS VARCHAR),2)
	Where WD.WeekEndDate between @PicEndDate-35 and @PicEndDate
	Group by PGC.PigFlowID, PGC.PigProdPhaseID, PGC.PICYear_Week) MEX
	Group by MEX.PigFlowID, MEX.PigProdPhaseID) ME
	ON ME.PigFlowID = cft_PIG_GROUP_CENSUS.PigFlowID
	AND ME.PigProdPhaseID = cft_PIG_GROUP_CENSUS.PigProdPhaseID
	--AND ME.PICYear_Week = cft_PIG_GROUP_CENSUS.PICYear_Week
WHERE cft_PIG_GROUP_CENSUS.PigProdPhaseID like @PigProdPhaseID
AND	cft_PIG_GROUP_CENSUS.PigFlowID like @PigFLowID
AND cft_PIG_GROUP_CENSUS.PhaseDesc like @PhaseDesc
AND	RTRIM(cft_PIG_GROUP_CENSUS.SrSvcManager) LIKE RTRIM(@SrSvcManager)
AND RTRIM(cft_PIG_GROUP_CENSUS.SvcManager) like RTRIM(@SvcManager)
AND RTRIM(cft_PIG_GROUP_CENSUS.SiteContactID) like RTRIM(@SiteContactID)
AND ME.MortExcept > 0

GROUP BY 
	cft_PIG_GROUP_CENSUS.PigGroupID
,	cft_PIG_GROUP_CENSUS.PigFlowID
,	cft_PIG_FLOW.PigFlowDescription
,	cftContact.ContactID
,	cftContact.ContactName
,	cft_PIG_GROUP_CENSUS.SvcManager
,	cft_PIG_GROUP_CENSUS.Description
,	cft_PIG_GROUP_CENSUS.PodDescription
,	cft_PIG_GROUP_BASE_SOURCE.BaseSource
,	cft_PIG_GROUP_CENSUS.PICYear_Week
,	cft_PIG_GROUP_CENSUS.PigProdPhaseID
,	cft_PIG_GROUP_CENSUS.PhaseDesc
,	cft_PIG_GROUP_CENSUS.NurserySource
,	cft_PIG_GROUP_CENSUS.PigFlowStartDate
,	ME.MortExcept
,	cft_PIG_GROUP_CENSUS.reportinggroupid		-- 201312 smr reporting group enhancement
ORDER BY
	cft_PIG_GROUP_CENSUS.PodDescription
,	cft_PIG_FLOW.PigFlowDescription
,	cft_PIG_GROUP_CENSUS.PhaseDesc
,	cft_PIG_GROUP_CENSUS.Description


------------------------------------------------------------------
--SORTING
------------------------------------------------------------------
SELECT IDENTITY (int) as SortID, SiteContactID, MIN(PigFlowStartDate) AS PigFlowStartDate INTO #Sort1 FROM #ReportData GROUP BY SiteContactID ORDER BY MIN(PigFlowStartDate)

UPDATE #ReportData
SET SortOrder = Sort1.SortID
FROM #ReportData ReportData
JOIN #Sort1 Sort1
	ON Sort1.SiteContactID = ReportData.SiteContactID
------------------------------------------------------------------
--END SORTING
------------------------------------------------------------------


-- 201312 smr reporting group enhancement
SELECT RD.*, rg.Reporting_Group_Description 
FROM #ReportData  RD
join [$(CFApp_PigManagement)].dbo.cft_pig_flow_reporting_group rg (NOLOCK)
	ON rg.reportinggroupID = RD.reportinggroupID
ORDER BY SortOrder, PigFlowStartDate
-- 201312 smr reporting group enhancement

DROP TABLE #ReportData
DROP TABLE #Sort1
DROP TABLE #PicRange
DROP TABLE #PicRangeFull
DROP TABLE #ReportSites






GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MORTALITY_EXCEPTION_DETAIL_BY_PIC_DATE_vRPTGRP] TO [db_sp_exec]
    AS [dbo];

