--*************************************************************
--	Purpose: Submitted by PV 
--	Author: Sue Matter
--	Date: 2/2/2006
--	Usage: Pig Group Eligibility			 
--	Parms: ContactID 
--*************************************************************

CREATE   PROCEDURE pXP238SubmitPV
	  	@ContactID varchar(6),
	@parm2 varchar(6)

 AS 
Select svc.* 
FROM cfvCurrentMktSvc svc
WHERE svc.SiteContactID = @ContactID 
AND MgrContactID = @parm2



 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP238SubmitPV] TO [MSDSL]
    AS [dbo];

