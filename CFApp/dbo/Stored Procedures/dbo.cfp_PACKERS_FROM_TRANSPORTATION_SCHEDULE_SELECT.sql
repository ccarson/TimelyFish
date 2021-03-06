﻿
-- =============================================
-- Author:	mdawson
-- Create date: 12/6/2007
-- Description:	Returns Packers in Transportation Schedule
--		based on date criteria
-- =============================================

CREATE PROC [dbo].[cfp_PACKERS_FROM_TRANSPORTATION_SCHEDULE_SELECT]
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
where pm.MovementDate between @StartDate and @EndDate
and pm.Highlight<>255
Order by ContactName


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKERS_FROM_TRANSPORTATION_SCHEDULE_SELECT] TO [db_sp_exec]
    AS [dbo];

