--*************************************************************
--	Purpose:Look up related PigMovements for a PigGroup
--		where the Source is possibly the specified group		
--	Author: Charity Anderson
--	Date: 1/25/2005
--	Usage: PGExceptions 
--	Parms: @parm1 (PigGroupID),@parm2 (NbrDays)
--*************************************************************

CREATE PROC dbo.pXP210RelatedPM
	@parm1 as varchar(10),@parm2 as smallint
AS
Select Distinct pm.*
from vXP210PigMovement pm


where pm.SourcePigGroupID= @parm1 
order by MovementDate DESC


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP210RelatedPM] TO [MSDSL]
    AS [dbo];

