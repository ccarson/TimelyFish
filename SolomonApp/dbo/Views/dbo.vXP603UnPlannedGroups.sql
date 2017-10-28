--*************************************************************
--	Purpose:View for groups closing but not planned on the flow 
--			board		
--	Author: Brian Doyle
--	Date: 6/22/2004
--	Usage: XP603 Un-Planned Group Report
--	Parms: 
--	       
--*************************************************************

CREATE VIEW dbo.vXP603UnPlannedGroups
AS
select c.contactname as Site, pg.barnnbr, pg.estclosedate, pp.description as Pod, 
se.onewaymiles as SEDistance, ia.onewaymiles as IFDistance 
from cftpiggroup as pg
left join cftpm as pm on (pg.sitecontactid = pm.destcontactid and pg.barnnbr = pm.destbarnnbr
and pm.movementdate > pg.estclosedate)
left join cftpigprodpod as pp on (pg.PigProdPodID = pp.podid)
left join cftcontact as C on (pg.sitecontactid = c.contactid)
left join vcfcontactmilesmatrix as se on (se.sourcesite = '000352' and se.destsite = pg.sitecontactid)
left join vcfcontactmilesmatrix as ia on (ia.sourcesite = '001330' and ia.destsite = pg.sitecontactid)
where pgstatusid in ('a', 't') and pm.id is null
