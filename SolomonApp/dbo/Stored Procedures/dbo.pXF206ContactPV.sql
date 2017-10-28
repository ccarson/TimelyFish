--*************************************************************
--	Purpose: Get contact for order
--	Author: Sue Matter
--	Date: 3/23/2006
--	Usage: Bin Certification			 
--	Parms: Feed Order Number 
--*************************************************************

CREATE   PROCEDURE pXF206ContactPV
	 @parm1 As varchar(10)
 AS 
 SELECT c.*
	FROM cftcontact c
	JOIN cftSite s on c.ContactID=s.ContactID
	Where c.StatusTypeID=1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF206ContactPV] TO [MSDSL]
    AS [dbo];

