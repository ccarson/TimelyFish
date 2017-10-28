--*************************************************************
--	Purpose:Look up related PigMovements for a PigGroup
--		where the Destination is possibly the specified group		
--	Author: Charity Anderson
--	Date: 1/27/2005
--	Usage: PGExceptions 
--	Parms: @parm1 (PigGroupID),@parm2 (NbrDays)
--*************************************************************

CREATE PROC dbo.pCF535RelatedPMOpen
	@parm1 as varchar(10),@parm2 as smallint
AS
Select Distinct pm.*
from vCF535PigMovement pm

JOIN (Select pg.PigGroupID, pg.BarnNbr,pr.RoomNbr,
	pg.SiteContactID,pg.EstStartDate from cftPigGroup pg 
	LEFT JOIN cftPigGroupRoom pr
	on pg.PigGroupID=pg.PigGroupID where pg.PIgGroupID=@parm1) pg
	on pm.DestContactID=pg.SiteContactID

	and (pm.DestBarnNbr=pg.BarnNbr or pm.DestBarnNbr=pg.RoomNbr)
and pm.MovementDate between (pg.EstStartDate-@parm2) and (pg.EstStartDate+@parm2)
where pg.PigGroupID= @parm1 
order by MovementDate ASC



 