CREATE PROCEDURE Dbo.SPFixMissingPigProdPods004
@piggroupid varchar(8)
 AS
--Created on 01/24/2007 by Dave Killion
--This SP returns the destination pig group status and 
--pig prod pod id. This SP is used by the application 
--FixPigProdPod.
/**
***************************************************************
	Created for ticket 189
	Date: 02/05/2007
	Author: Dave Killion
***************************************************************
**/


Select 
	PGStatusID,
	PigProdPodID 
from cftPigGroup where PigGroupID= @piggroupid

GO
GRANT CONTROL
    ON OBJECT::[dbo].[SPFixMissingPigProdPods004] TO [MSDSL]
    AS [dbo];

