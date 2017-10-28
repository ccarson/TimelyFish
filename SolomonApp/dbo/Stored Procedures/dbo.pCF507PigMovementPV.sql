--*************************************************************
--	Purpose:PV for PigMovement table			
--	Author: Charity Anderson
--	Date: 8/2/2004
--	Usage: PigTransportRecord 
--	Parms: @parm1 (PigMovementID)
--*************************************************************

CREATE PROC dbo.pCF507PigMovementPV
	@parm1 as varchar(6)
AS
Select pm.*
from vCF507PigMovement pm
LEFT JOIN cftPacker on pm.DestContactID=cftPacker.ContactID
where PMID like @parm1 and cftPacker.ContactID is null order by PMID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF507PigMovementPV] TO [MSDSL]
    AS [dbo];

