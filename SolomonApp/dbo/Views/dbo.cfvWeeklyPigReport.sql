

CREATE VIEW [dbo].[cfvWeeklyPigReport]
	AS
/***  qryWeeklyPigReporting: Used in Weekly Pig Reporting report  ***/
/***  Created 3/28/2005 Eric Lind  ***/
-- 11/23/2015 BMD Rewrote query to tune for performance.

SELECT
   sm.TranDate,
   sm.CallDate,
   pg.PigGroupID,
   pg.Description,
   c.ContactName,
   c.ContactID

FROM cftPigGroup pg
LEFT JOIN cftSafeMort sm on pg.PigGroupID = sm.PigGroupID 
LEFT JOIN (Select PigGroupID, MAX(TranDate) MaxPGTranDate from cftSafeMort group by PigGroupID
           ) smPGMax on pg.piggroupid = smPGMax.PigGroupID
Cross Join (SELECT MAX(TranDate) MaxTranDate FROM cftSafeMort) smMax 
JOIN cftContact c on c.ContactID = pg.SiteContactID
Where (pg.pgStatusID IN ('T', 'A')
		and ((sm.TranDate = smPGMax.MaxPGTranDate
		and sm.TranDate < smMax.MaxTranDate)
   or sm.TranDate is null))
 
