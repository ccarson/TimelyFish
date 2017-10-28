--*************************************************************
--	Purpose:PV for PigGroup
--	Author: Charity Anderson
--	Date: 1/20/2005
--	Usage: PigTransportRecord app 
--	Parms:PigGroupID, ContactID
--*************************************************************

CREATE PROC dbo.pCF507PigGroupPV
	@parm1 as varchar(6), @parm2 as varchar(10)
AS
Select * from cftPigGroup pg
JOIN 
cftPGStatus ps on pg.PGStatusID=ps.PGStatusID
where ps.status_transport='A'  and SiteContactID like @parm1 and  PigGroupID like @parm2 order by PigGroupID
