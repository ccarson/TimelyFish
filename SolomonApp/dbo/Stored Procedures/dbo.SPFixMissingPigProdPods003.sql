CREATE PROCEDURE Dbo.SPFixMissingPigProdPods003

 AS
--Created on 01/24/2007 by Dave Killion
--This SP returns the maximum allowable mixed
--pig pod percent. This SP is used by the application 
--FixPigProdPod.
/**
***************************************************************
	Created for ticket 189
	Date: 02/05/2007
	Author: Dave Killion
***************************************************************
**/


Select 
	MixedPodPctLimit
	
from 
	cftPGSetup

GO
GRANT CONTROL
    ON OBJECT::[dbo].[SPFixMissingPigProdPods003] TO [MSDSL]
    AS [dbo];

