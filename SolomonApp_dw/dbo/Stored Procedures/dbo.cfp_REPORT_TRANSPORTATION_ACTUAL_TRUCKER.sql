
CREATE PROCEDURE [dbo].[cfp_REPORT_TRANSPORTATION_ACTUAL_TRUCKER] 
@StartDate DATETIME,
@EndDate DATETIME
--@Variance INT
--@TruckerID INT 
AS

Delete From  dbo.cft_LOAD_TABLE_SOURCE_TRANSPORTATION_INVENTORY_CHECK_WP
	
Insert into  dbo.cft_LOAD_TABLE_SOURCE_TRANSPORTATION_INVENTORY_CHECK_WP

SELECT DISTINCT
	cftPM.PMLoadID
,	SourceContact.ShortName
FROM [$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
LEFT JOIN [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK) 
	on cftPM.SourceContactID = SourceContact.ContactID
WHERE	cftPM.PMTypeID = '02'
AND	cftPM.MovementDate BETWEEN @StartDate AND @EndDate

Delete From  dbo.cft_LOAD_TABLE_DESTINATION_TRANSPORTATION_INVENTORY_CHECK_WP
	
Insert into  dbo.cft_LOAD_TABLE_DESTINATION_TRANSPORTATION_INVENTORY_CHECK_WP

SELECT DISTINCT
	cftPM.PMLoadID
,	DestContact.ShortName
FROM [$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
LEFT JOIN [$(SolomonApp)].dbo.cftContact DestContact (NOLOCK) 
	on cftPM.DestContactID = DestContact.ContactID
WHERE	cftPM.PMTypeID = '02'
AND	cftPM.MovementDate BETWEEN @StartDate AND @EndDate


SELECT
	td.Trucker
,	td.PMLoadID
,	td.MovementDate
,	td.LoadingTime
,	td.PICYear_Week
,	td.Source
,	td.Destination
,	td.ScheduledRate
,	td.ActualRate

FROM (

SELECT
	TruckerContact.ShortName as 'Trucker'
,	cftPM.PMLoadID as 'PMLoadID'
,	Convert(Date,cftPM.MovementDate) as 'MovementDate'
,	rtrim(Convert(Time(0),cftPM.LoadingTime)) as 'LoadingTime'
,	dw.PICYear_Week as 'PICYear_Week'
,	SourceContact.ShortName as 'Source'
,	DestContact.ShortName as 'Destination'
,	SUM([$(SolomonApp)].dbo.getRate(cftPM.PMLoadID,cftPM.PMID,cftWeekDefinition.WeekOfDate,cftPM.PigTypeID,cftPM.PMSystemID,cftPM.PigTrailerID,cftPM.TranSubTypeID)) as 'ScheduledRate'
,	SUM([$(SolomonApp)].dbo.getActualRate(cftPM.PMID)) as 'ActualRate'
FROM [$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
LEFT JOIN (Select Distinct DayDate, PICYear_Week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo) dw
on cftPM.MovementDate = dw.DayDate 
LEFT JOIN (

	Select 
	PM.PMLoadID, 
	dbo.cffn_INVENTORY_CHECK_SOURCE(PM.PMLoadID) as ShortName
	from ( 
	Select PMLoadID
	from  dbo.cft_LOAD_TABLE_SOURCE_TRANSPORTATION_INVENTORY_CHECK_WP
	group by PMLoadID) PM ) SourceContact
	on cftPM.PMLoadID = SourceContact.PMLoadID
		
LEFT JOIN (

	Select 
	PM.PMLoadID, 
	dbo.cffn_INVENTORY_CHECK_DESTINATION(PM.PMLoadID) as ShortName
	from ( 
	Select PMLoadID
	from  dbo.cft_LOAD_TABLE_DESTINATION_TRANSPORTATION_INVENTORY_CHECK_WP
	group by PMLoadID) PM ) DestContact
	on cftPM.PMLoadID = DestContact.PMLoadID 
	
LEFT JOIN [$(SolomonApp)].dbo.cftContact TruckerContact (NOLOCK) 
	on cftPM.TruckerContactID = TruckerContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftWeekDefinition cftWeekDefinition (NOLOCK) 
	on cftPM.MovementDate between cftWeekDefinition.WeekOfDate and cftWeekDefinition.WeekEndDate
WHERE	cftPM.PMTypeID = '02'
AND	cftPM.MovementDate BETWEEN @StartDate AND @EndDate
--and TruckerContact.ContactID = @TruckerID 
GROUP BY
	TruckerContact.ShortName
,	cftPM.PMLoadID
,	cftPM.MovementDate
,	cftPM.LoadingTime
,	dw.PICYear_Week
,	SourceContact.ShortName
,	DestContact.ShortName) td
WHERE td.ActualRate is not null
ORDER BY
	td.MovementDate,
	td.Trucker


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_ACTUAL_TRUCKER] TO [db_sp_exec]
    AS [dbo];

