







CREATE VIEW [dbo].[cfv_PM_Event]
AS

SELECT		
			ev.PM_Event_ID
			, ev.PMID
			, wd.PICWeek AS 'Week'
			, c3.ContactName As Source
			, pm.SourceBarnNbr
			, pm.MovementDate
			, pm.LoadingTime
			, c4.ContactName As Destination
			, c2.ContactName as DriverCompany
			, c1.ContactName as Driver
			, ev.EventID
			, Event_Value
			, Event_Comment
		
FROM cftPMEvents ev
JOIN cftPM (NOLOCK) pm ON ev.PMID = pm.PMID
LEFT JOIN cftContact (NOLOCK) c1 ON ev.ContactID = c1.ContactID
LEFT JOIN cftContact (NOLOCK) c2 ON ev.ParentContactID = c2.ContactID
JOIN cftContact (NOLOCK) c3 ON pm.SourceContactID = c3.ContactID
JOIN cftContact (NOLOCK) c4 ON pm.DestContactID = c4.ContactID
JOIN cftWeekDefinition wd (NOLOCK) ON pm.MovementDate BETWEEN wd.WeekOfDate AND wd.WeekEndDate





