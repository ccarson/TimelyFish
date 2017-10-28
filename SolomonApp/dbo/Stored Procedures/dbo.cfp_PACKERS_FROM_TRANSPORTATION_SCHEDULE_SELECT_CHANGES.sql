
-- =============================================
-- Author:	mdawson
-- Create date: 12/6/2007
-- Description:	Returns Packers in Transportation Schedule
--		based on date criteria, that have changes
-- =============================================

CREATE PROC [dbo].[cfp_PACKERS_FROM_TRANSPORTATION_SCHEDULE_SELECT_CHANGES]
	(@StartDate as smalldatetime, @EndDate as smalldatetime)

AS
Select Distinct 
	c.ContactID, 
	rtrim(c.ContactName) as ContactName,
	c.TranSchedMethTypeID
FROM 
SolomonApp.dbo.cftPM pm (NOLOCK)
JOIN SolomonApp.dbo.cftPacker p (NOLOCK) on pm.DestContactID=p.ContactID
JOIN SolomonApp.dbo.cftContact c (NOLOCK) on p.ContactID=c.ContactID
JOIN dbo.cft_PM_HISTORY cft_PM_HISTORY (NOLOCK) 
	on  RTRIM(cft_PM_HISTORY.PMID) = RTRIM(pm.PMID)
where pm.MovementDate between @StartDate and @EndDate
and pm.Highlight<>255
and cft_PM_HISTORY.SentChanges <> 1
Order by ContactName


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_PACKERS_FROM_TRANSPORTATION_SCHEDULE_SELECT_CHANGES] TO [MSDSL]
    AS [dbo];

