--*************************************************************
--	Purpose: Submitted by PV 
--	Author: Sue Matter
--	Date: 2/2/2006
--	Usage: Pig Group Override			 
--	Parms: ContactID 
--*************************************************************

CREATE   PROCEDURE pXF207SubmitPV
@ContactID varchar(6), @parm2 varchar(6)
AS
Select svc.* 
FROM cfvCurrentMktSvc svc
WHERE svc.SiteContactID = @ContactID 
AND MgrContactID = @parm2
--IN ('000874','001022')
 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF207SubmitPV] TO [MSDSL]
    AS [dbo];

