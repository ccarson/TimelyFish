--*************************************************************
--	Purpose: Get contact for order
--	Author: Sue Matter
--	Date: 3/23/2006
--	Usage: Bin Certification			 
--	Parms: Feed Order Number 
--*************************************************************

CREATE   PROCEDURE pXF206FeedContact
	 @parm1 As varchar(10)
 AS 
 SELECT c.*
	FROM cftcontact c
	JOIN cftFeedOrder f ON c.contactid=f.ContactID AND f.OrdNbr=@parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF206FeedContact] TO [MSDSL]
    AS [dbo];

