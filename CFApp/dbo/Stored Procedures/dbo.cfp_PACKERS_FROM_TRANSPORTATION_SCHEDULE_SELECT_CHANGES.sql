

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
	c.TranSchedMethTypeID,
	'2' as ReportType
FROM 
[$(SolomonApp)].dbo.cftPM pm (NOLOCK)
JOIN [$(SolomonApp)].dbo.cftPacker p (NOLOCK) on pm.DestContactID=p.ContactID
JOIN [$(SolomonApp)].dbo.cftContact c (NOLOCK) on p.ContactID=c.ContactID
JOIN dbo.cft_PM_HISTORY cft_PM_HISTORY (NOLOCK) 
	on  cft_PM_HISTORY.PMID = pm.PMID	
--	on  RTRIM(cft_PM_HISTORY.PMID) = RTRIM(pm.PMID)		-- 20130826 sripley performance issue, applications timing out  also added index [idxcft_PM_History_PMID] ON [dbo].[cft_PM_HISTORY] 
where pm.MovementDate between @StartDate and @EndDate
and pm.Highlight<>255
and cft_PM_HISTORY.SentChanges <> 1
Order by ContactName



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKERS_FROM_TRANSPORTATION_SCHEDULE_SELECT_CHANGES] TO [db_sp_exec]
    AS [dbo];

