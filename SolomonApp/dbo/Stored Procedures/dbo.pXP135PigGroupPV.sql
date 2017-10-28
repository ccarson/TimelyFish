--*************************************************************
--	Purpose:PV for PigGroup
--	Author: Charity Anderson
--	Date: 1/20/2005
--	Usage: PigTransportRecord app 
--	Parms: ContactID,PigGroupID
--*************************************************************

CREATE PROC dbo.pXP135PigGroupPV
	@parm1 as varchar(6), @parm2 as varchar(10)
AS
Select pg.* from cftPigGroup pg
JOIN 
cftPGStatus ps on pg.PGStatusID=ps.PGStatusID
where ps.status_transport='A'  and SiteContactID like @parm1 and  PigGroupID like @parm2 order by PigGroupID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135PigGroupPV] TO [MSDSL]
    AS [dbo];

