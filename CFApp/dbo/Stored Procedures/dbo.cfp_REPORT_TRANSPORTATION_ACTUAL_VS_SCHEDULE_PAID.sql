

-- =============================================
-- Author:	Matt Dawson
-- Create date:	1/7/2008
-- Description:	Schedule VS Actual Paid Variance Report
-- Parameters: 	@StartDate, 
--		@EndDate,
--		@Variance
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_TRANSPORTATION_ACTUAL_VS_SCHEDULE_PAID] 
@StartDate DATETIME,
@EndDate DATETIME,
@Variance INT
AS


CREATE TABLE #Rates
(	Trucker			char(30)
,	ID			int
,	MovementDate		smalldatetime
,	Source			char(30)
,	Destination		char(30)
,	ScheduledRate		numeric(10,2)
,	ActualRate		numeric(10,2)
,	Variance		numeric(10,2))

INSERT INTO #Rates
SELECT
	TruckerContact.ShortName
,	cftPM.PMLoadID
,	cftPM.MovementDate
,	SourceContact.ShortName
,	DestContact.ShortName
,	SUM([$(SolomonApp)].dbo.getRate(cftPM.PMLoadID,cftPM.PMID,cftWeekDefinition.WeekOfDate,cftPM.PigTypeID,cftPM.PMSystemID,cftPM.PigTrailerID,cftPM.TranSubTypeID))
,	SUM([$(SolomonApp)].dbo.getActualRate(cftPM.PMID))
,	NULL
FROM [$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
LEFT JOIN [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK) 
	on cftPM.SourceContactID = SourceContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact DestContact (NOLOCK) 
	on cftPM.DestContactID = DestContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact TruckerContact (NOLOCK) 
	on cftPM.TruckerContactID = TruckerContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftWeekDefinition cftWeekDefinition (NOLOCK) 
	on cftPM.MovementDate between cftWeekDefinition.WeekOfDate and cftWeekDefinition.WeekEndDate
WHERE	cftPM.PMTypeID = '02'
AND	cftPM.MovementDate BETWEEN @StartDate AND @EndDate
GROUP BY
	TruckerContact.ShortName
,	cftPM.PMLoadID
,	cftPM.MovementDate
,	SourceContact.ShortName
,	DestContact.ShortName
ORDER BY
	cftPM.MovementDate,
	TruckerContact.ShortName

UPDATE	#Rates
SET	Variance = ScheduledRate - ActualRate

SELECT
	Trucker
,	ID
,	MovementDate
,	Source
,	Destination
,	ScheduledRate
,	ActualRate
,	Variance
FROM #Rates
WHERE ABS(Variance) > @Variance








GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_ACTUAL_VS_SCHEDULE_PAID] TO [db_sp_exec]
    AS [dbo];

