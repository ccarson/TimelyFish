--*************************************************************
--	Purpose:PV for PigMovement table			
--	Author: Charity Anderson
--	Date: 8/2/2004
--	Usage: PigTransportRecord 
--	Parms: @parm1 (PigMovementID)
--*************************************************************

CREATE PROC dbo.pXP135PigMovementPV
	@parm1 as varchar(6)
AS
Select pm.*
from vXP135PigMovement pm
LEFT JOIN cftPacker on pm.DestContactID=cftPacker.ContactID
where PMID like @parm1 and cftPacker.ContactID is null order by PMID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135PigMovementPV] TO [MSDSL]
    AS [dbo];

