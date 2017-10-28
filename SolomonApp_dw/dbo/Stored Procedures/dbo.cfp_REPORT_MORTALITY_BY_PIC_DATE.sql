
-- 2/22/2016, BMD, Updated to exclude SBF Pig Groups

CREATE PROCEDURE [dbo].[cfp_REPORT_MORTALITY_BY_PIC_DATE]
	@PicDate CHAR(6)
,	@NumWeeks int
AS

---------------------------------------------------------------------
--pic dates
---------------------------------------------------------------------
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
CREATE TABLE #ReportSites (PigFlowID int, PigProdPhaseID char(3))
INSERT INTO #ReportSites
select distinct PigFlowID, cft_PIG_GROUP_CENSUS.PigProdPhaseID
FROM  dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (NOLOCK)
inner join [$(SolomonApp)].dbo.cftpiggroup cpp on cft_PIG_GROUP_CENSUS.PigGroupID=cpp.PigGroupID and cpp.PigProdPodID != 53 -- Ignore SBF groups
WHERE EXISTS (SELECT x.* FROM  dbo.cft_PIG_GROUP_CENSUS x (NOLOCK)
		WHERE x.PigProdPhaseID = cft_PIG_GROUP_CENSUS.PigProdPhaseID
		AND x.PICYear_Week = @PicDate)
AND cft_PIG_GROUP_CENSUS.PICYear_Week = @PicDate

---------------------------------------------------------------------
--target line data
---------------------------------------------------------------------
DECLARE @MortalityPercentAllTargetLine DECIMAL(10,3)
DECLARE @MortalityPercentFinishingTargetLine DECIMAL(10,3)
DECLARE @MortalityPercentNurseryTargetLine DECIMAL(10,3)
DECLARE @MortalityPercentWeanToFinishTargetLine DECIMAL(10,3)

select @MortalityPercentAllTargetLine = TargetLineValue
from [$(CFApp_PigManagement)].dbo.cft_TARGET_LINE
where TargetLineTypeID = 19

select @MortalityPercentFinishingTargetLine = TargetLineValue
from [$(CFApp_PigManagement)].dbo.cft_TARGET_LINE
where TargetLineTypeID = 20

select @MortalityPercentNurseryTargetLine = TargetLineValue
from [$(CFApp_PigManagement)].dbo.cft_TARGET_LINE
where TargetLineTypeID = 21

select @MortalityPercentWeanToFinishTargetLine = TargetLineValue
from [$(CFApp_PigManagement)].dbo.cft_TARGET_LINE
where TargetLineTypeID = 27



---------------------------------------------------------------------
--get data
---------------------------------------------------------------------
CREATE TABLE #ReportData
(	PigFlowID int
,	PigFlowDescription varchar(100)
,	PICYear_Week char(6)
,	PigProdPhaseID char(3)
,	SvcManager varchar(100)
,	SrSvcManager varchar(100)
,	SUMCurrentInv int
,	SUMPigDeaths int
,	AVGMortalityPercent numeric(10,2)
,	CumulativeAVGMortalityPercent numeric(10,2)
,	CumulativeAVGMortalityPercentByPhaseAndPigFlowID numeric(10,2)
,	SUMCumulativePigDeaths int
,	MortalityPercentAllTargetLine decimal(10,3)
,	MortalityPercentFinishingTargetLine decimal(10,3)
,	MortalityPercentNurseryTargetLine decimal(10,3)
,   MortalityPercentWeanToFinishTargetLine decimal(10,3)
,  chart01_srsvcmanager varchar(50)
,  chart02_srsvcmanager varchar(50)
,  chart03_srsvcmanager varchar(50)
,  chart04_srsvcmanager varchar(50)
,  chart05_srsvcmanager varchar(50)
,  chart06_srsvcmanager varchar(50)
,  chart07_srsvcmanager varchar(50)
,  chart08_srsvcmanager varchar(50)
,  chart09_srsvcmanager varchar(50)
,  chart10_srsvcmanager varchar(50)
,  chart11_srsvcmanager varchar(50)
,  chart12_srsvcmanager varchar(50)
,  chart13_srsvcmanager varchar(50)
,  chart14_srsvcmanager varchar(50)
,  chart15_srsvcmanager varchar(50)
,  chart16_srsvcmanager varchar(50)
,  chart17_srsvcmanager varchar(50)
,  chart18_srsvcmanager varchar(50)
,  chart19_srsvcmanager varchar(50)
,  chart20_srsvcmanager varchar(50)
,  chart21_srsvcmanager varchar(50)
,  chart22_srsvcmanager varchar(50)
,  chart23_srsvcmanager varchar(50)
,  chart24_srsvcmanager varchar(50)
,  chart25_srsvcmanager varchar(50)
,  chart26_srsvcmanager varchar(50)
,  chart27_srsvcmanager varchar(50)
,  chart28_srsvcmanager varchar(50)
,  chart29_srsvcmanager varchar(50)
,  chart30_srsvcmanager varchar(50)
)

INSERT INTO #ReportData
SELECT 
	cft_PIG_GROUP_CENSUS.PigFlowID
,	cft_PIG_FLOW.PigFlowDescription
,	cft_PIG_GROUP_CENSUS.PICYear_Week
,	cft_PIG_GROUP_CENSUS.PigProdPhaseID
,	cft_PIG_GROUP_CENSUS.SvcManager
,	case when cft_PIG_GROUP_CENSUS.SrSvcManager = 'Wordekemper, Terry' then 'Nursery' else cft_PIG_GROUP_CENSUS.SrSvcManager end as SrSvcManager
,	SUM(cft_PIG_GROUP_CENSUS.CurrentInv) SUMCurrentInv
,	SUM(cft_PIG_GROUP_CENSUS.PigDeaths) SUMPigDeaths
,	CASE WHEN CAST(SUM(cft_PIG_GROUP_CENSUS.CurrentInv) AS NUMERIC(10,2)) = 0
		THEN 0
		ELSE CAST((CAST(SUM(cft_PIG_GROUP_CENSUS.PigDeaths) AS NUMERIC(10,2)) / CAST(SUM(cft_PIG_GROUP_CENSUS.CurrentInv) AS NUMERIC(10,2))) * 100 AS NUMERIC(10,2))
	END AVGMortalityPercent
,	NULL
,	NULL
,	SUM(cft_PIG_GROUP_CENSUS.CumulativePigDeaths) SUMCumulativePigDeaths
,	@MortalityPercentAllTargetLine MortalityPercentAllTargetLine
,	@MortalityPercentFinishingTargetLine MortalityPercentFinishingTargetLine
,	@MortalityPercentNurseryTargetLine MortalityPercentNurseryTargetLine
,   @MortalityPercentWeanToFinishTargetLine MortalityPercentWeanToFinishTargetLine
, null,null,null,null,null,null,null,null,null,null
, null,null,null,null,null,null,null,null,null,null
, null,null,null,null,null,null,null,null,null,null
FROM  dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (NOLOCK)
inner join [$(SolomonApp)].dbo.cftpiggroup cpp on cft_PIG_GROUP_CENSUS.PigGroupID=cpp.PigGroupID and cpp.PigProdPodID != 53 -- Ignore SBF groups
JOIN [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW cft_PIG_FLOW (NOLOCK)
	ON cft_PIG_FLOW.PigFlowID = cft_PIG_GROUP_CENSUS.PigFlowID
JOIN #PicRangeFull PicRange
	ON PicRange.PicDate = cft_PIG_GROUP_CENSUS.PICYear_Week
JOIN #ReportSites ReportSites
	ON ReportSites.PigFlowID = cft_PIG_GROUP_CENSUS.PigFlowID
	AND ReportSites.PigProdPhaseID = cft_PIG_GROUP_CENSUS.PigProdPhaseID
GROUP BY 
	cft_PIG_GROUP_CENSUS.PigFlowID
,	cft_PIG_FLOW.PigFlowDescription
,	cft_PIG_GROUP_CENSUS.PICYear_Week
,	cft_PIG_GROUP_CENSUS.PigProdPhaseID
,	cft_PIG_GROUP_CENSUS.SvcManager
,	cft_PIG_GROUP_CENSUS.SrSvcManager
ORDER BY
	cft_PIG_GROUP_CENSUS.PICYear_Week desc
,	cft_PIG_FLOW.PigFlowDescription

UPDATE	#ReportData
SET	CumulativeAVGMortalityPercent = x.CumulativeAVGMortalityPercent
FROM	(SELECT AVG(AVGMortalityPercent) CumulativeAVGMortalityPercent FROM #ReportData) x

UPDATE	#ReportData
SET	CumulativeAVGMortalityPercentByPhaseAndPigFlowID = x.CumulativeAVGMortalityPercent
FROM	#ReportData ReportData
JOIN	(SELECT PigFlowID, PigProdPhaseID, AVG(AVGMortalityPercent) CumulativeAVGMortalityPercent FROM #ReportData GROUP BY PigFlowID, PigProdPhaseID) x
	ON x.PigFlowID = ReportData.PigFlowID
	AND x.PigProdPhaseID = ReportData.PigProdPhaseID
	
IF @NumWeeks <> 5
BEGIN
	---------------------------------------------------------------------
	--insert dummy records for graphs
	---------------------------------------------------------------------
	select *
	into #build
	from #PicRangeFull PicRange
	CROSS JOIN (SELECT DISTINCT PigFlowID, PigFlowDescription, PigProdPhaseID, SvcManager, SrSvcManager, CumulativeAVGMortalityPercentByPhaseAndPigFlowID FROM #ReportData) ReportData

	insert into #ReportData
	select PigFlowID,PigFlowDescription,PicDate,PigProdPhaseID,SvcManager,SrSvcManager,NULL,NULL,NULL,NULL,CumulativeAVGMortalityPercentByPhaseAndPigFlowID,NULL,NULL,NULL,NULL,NULL
	, null,null,null,null,null,null,null,null,null,null
	, null,null,null,null,null,null,null,null,null,null
	, null,null,null,null,null,null,null,null,null,null
	from #build build
	where not exists
	(select * from #ReportData 
	where	PICYear_Week = build.PicDate
	and		PigFlowID = build.PigFlowID
	and		PigFlowDescription = build.PigFlowDescription
	and		PigProdPhaseID = build.PigProdPhaseID
	and		SvcManager = build.SvcManager
	and		SrSvcManager = build.SrSvcManager
	and		CumulativeAVGMortalityPercentByPhaseAndPigFlowID = build.CumulativeAVGMortalityPercentByPhaseAndPigFlowID)


	DROP TABLE #build
	---------------------------------------------------------------------
	--END: insert dummy records for graphs
	---------------------------------------------------------------------
END


UPDATE	#ReportData
SET	
  chart01_srsvcmanager = case when chartloc = 1 then x.srsvcmanager end
, chart02_srsvcmanager = case when chartloc = 2 then x.srsvcmanager end
, chart03_srsvcmanager = case when chartloc = 3 then x.srsvcmanager end
, chart04_srsvcmanager = case when chartloc = 4 then x.srsvcmanager end
, chart05_srsvcmanager = case when chartloc = 5 then x.srsvcmanager end
, chart06_srsvcmanager = case when chartloc = 6 then x.srsvcmanager end
, chart07_srsvcmanager = case when chartloc = 7 then x.srsvcmanager end
, chart08_srsvcmanager = case when chartloc = 8 then x.srsvcmanager end
, chart09_srsvcmanager = case when chartloc = 9 then x.srsvcmanager end
, chart10_srsvcmanager = case when chartloc = 10 then x.srsvcmanager end
, chart11_srsvcmanager = case when chartloc = 11 then x.srsvcmanager end
, chart12_srsvcmanager = case when chartloc = 12 then x.srsvcmanager end
, chart13_srsvcmanager = case when chartloc = 13 then x.srsvcmanager end
, chart14_srsvcmanager = case when chartloc = 14 then x.srsvcmanager end
, chart15_srsvcmanager = case when chartloc = 15 then x.srsvcmanager end
, chart16_srsvcmanager = case when chartloc = 16 then x.srsvcmanager end
, chart17_srsvcmanager = case when chartloc = 17 then x.srsvcmanager end
, chart18_srsvcmanager = case when chartloc = 18 then x.srsvcmanager end
, chart19_srsvcmanager = case when chartloc = 19 then x.srsvcmanager end
, chart20_srsvcmanager = case when chartloc = 20 then x.srsvcmanager end
, chart21_srsvcmanager = case when chartloc = 21 then x.srsvcmanager end
, chart22_srsvcmanager = case when chartloc = 22 then x.srsvcmanager end
, chart23_srsvcmanager = case when chartloc = 23 then x.srsvcmanager end
, chart24_srsvcmanager = case when chartloc = 24 then x.srsvcmanager end
, chart25_srsvcmanager = case when chartloc = 25 then x.srsvcmanager end
, chart26_srsvcmanager = case when chartloc = 26 then x.srsvcmanager end
, chart27_srsvcmanager = case when chartloc = 27 then x.srsvcmanager end
, chart28_srsvcmanager = case when chartloc = 28 then x.srsvcmanager end
, chart29_srsvcmanager = case when chartloc = 29 then x.srsvcmanager end
, chart30_srsvcmanager = case when chartloc = 30 then x.srsvcmanager end
FROM	#ReportData ReportData
JOIN	(Select srsvcmanager, row_Number() over(order by srsvcmanager )
		as 'chartloc'
		FROM (select srsvcmanager, count(1) freqcnt from #ReportData group by srsvcmanager) xx) x
	ON x.SrSvcManager = ReportData.SrSvcManager

SELECT * FROM #ReportData
where srsvcmanager not like '%no sr svc%'
order by SrSvcManager

DROP TABLE #ReportData
DROP TABLE #PicRange
DROP TABLE #PicRangeFull
DROP TABLE #ReportSites


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MORTALITY_BY_PIC_DATE] TO [db_sp_exec]
    AS [dbo];

