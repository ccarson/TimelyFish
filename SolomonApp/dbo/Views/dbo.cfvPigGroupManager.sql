
--*************************************************************
--	Purpose:  Group details for Essbase extract
--	Author: Sue Matter
--	Date: 9/28/2006
--	Usage: Essbase Extract cfvMasterGroupActStart
--	Parms: None
--*************************************************************

CREATE VIEW cfvPigGroupManager
AS
SELECT    pg.CF03, pg.CostFlag, pg.PigGroupID, pg.PigGenderTypeID, pg.PigProdPodID, pg.PGStatusID,
	  st.Qty As StartQty, sv.SvcMgrContactID, sv.Effectivedate
FROM      cftPigGroup pg
LEFT JOIN cfv_GroupStart st ON pg.ProjectID=st.ProjectID and pg.TaskID=st.TaskID
LEFT JOIN cfvCrtSvcMgrName sv ON pg.SiteContactID=sv.sitecontactid
WHERE pg.PGStatusID<>'X'




