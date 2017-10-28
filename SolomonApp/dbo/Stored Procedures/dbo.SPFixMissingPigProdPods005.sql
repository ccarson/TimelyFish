CREATE PROCEDURE Dbo.SPFixMissingPigProdPods005
@PodID Int
 AS

--Created on 01/24/2007 by Dave Killion
--This SP the mixed pod id and barrow
--pod id based upon the source pig group.
--This SP is used by the application 
--FixPigProdPod.

/**
***************************************************************
	Created for ticket 189
	Date: 02/05/2007
	Author: Dave Killion
***************************************************************
**/

Select 
	MixedPodID,
	BarrowPodID
from cftPigProdPod where PodID=@PodID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[SPFixMissingPigProdPods005] TO [MSDSL]
    AS [dbo];

