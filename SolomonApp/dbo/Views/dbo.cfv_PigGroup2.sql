/****** Sue Matter:  Used on Feed Exception Report    Script Date: 11/30/2004 ******/
CREATE     VIEW cfv_PigGroup2
AS
SELECT	si.SiteID, pg.BarnNbr, gr.RoomNbr, pg.PigGroupID, st.StartDate, fp.LastOrder, pg.EstStartDate
FROM cftPigGroup pg
JOIN PJPENT pj ON pg.TaskID=pj.pjt_entity
JOIN cftSite si ON pg.SiteContactID=si.ContactID
LEFT JOIN cfv_GroupStart st ON pg.ProjectID=st.ProjectID and pg.TaskID=st.TaskID
LEFT JOIN cfv_GroupFeed fp ON pg.ProjectID=fp.ProjectID and pg.TaskID=fp.TaskID
LEFT JOIN cftPigGroupRoom gr ON pg.PigGroupID=gr.PigGroupID
Where pg.PigGroupID IN (Select Max(pg2.PigGroupID)
From cftPigGroup pg2
JOIN cftSite si2 ON pg2.SiteContactID=si2.ContactID
LEFT JOIN cftPigGroupRoom gr2 ON pg2.PigGroupID=gr2.PigGroupID
Where pg2.PGStatusID<>'T' AND pg2.PGStatusID<>'I'
Group by si2.SiteID, pg2.BarnNbr, gr2.RoomNbr) 




 