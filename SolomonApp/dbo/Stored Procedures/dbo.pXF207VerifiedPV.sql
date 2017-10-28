--*************************************************************
--	Purpose: Verified PV Override
--	Author: Sue Matter
--	Date: 3/23/2006
--	Usage: Bin Verification			 
--	Parms: ContactID 
--*************************************************************

CREATE   PROCEDURE pXF207VerifiedPV
	  	@ContactID varchar(6)

AS 
Select * 
FROM cftContact
WHERE ContactTypeID<>'04' AND StatusTypeID<>2
AND ContactID = @ContactID 



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF207VerifiedPV] TO [MSDSL]
    AS [dbo];

