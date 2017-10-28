
----------------------------------------------------------------------------------------
--	Purpose: Select the feed detail from SolomonApp
--	Author: Timothy Jones
--	Date: 
--	Program Usage: Essbase File Builder for Sow Data
--	Parms: 
--  Revised : Sue Matter
--  Date:  8/13/2007
--  Purpose:  Use Temp tables in SowData that are prefilled at run time
----------------------------------------------------------------------------------------

Create VIEW [dbo].[vSowFeedDetail]
	(FarmID, ContactID, WeekOfDate, DateDel, InvtIdDel, OrdNbr, QtyDel, Reversal)
	AS

	SELECT FarmId=dbo.GetSowFarmIDFromContactID(f.ContactID,f.DelDate), 
	f.Contactid, dd.WeekOfDate, deldate, invtiddel, ordnbr, 
		QtyDel = CASE reversal WHEN 0 THEN qtydel ELSE qtydel * -1 END, 
		reversal 
	FROM PreSolomonSowFeed f WITH (NOLOCK)
	JOIN DayDefinition dd WITH (NOLOCK) ON f.deldate = dd.daydate
	UNION

	SELECT FarmID=dbo.GetSowFarmIDFromContactID(f.ContactID,f.DateDel), 
	f.contactid, dd.WeekOfDate, f.datedel, f.invtiddel, f.ordnbr, 
		QtyDel = CASE reversal WHEN 0 THEN qtydel ELSE qtydel * -1 END, 
		f.reversal 
	FROM cftFeedOrderTemp f WITH (NOLOCK)
	JOIN DayDefinition dd WITH (NOLOCK) ON f.datedel = dd.daydate
	AND f.Status = 'C'

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowFeedDetail] TO [se\analysts]
    AS [dbo];

