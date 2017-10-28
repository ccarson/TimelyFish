--*************************************************************
--	Purpose: Eligibility Code PV 
--	Author: Sue Matter
--	Date: 3/23/2006
--	Usage: Bin Certification			 
--	Parms: Eligibility Type 
--*************************************************************

CREATE   PROCEDURE pXF206EligCodePV
	@parm1 smallint, @parm2 As varchar(3)
 AS 
 SELECT *
	FROM cftEligCode
	WHERE EligScr='B' 
	AND EligType = @parm1
 	AND EligCode = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF206EligCodePV] TO [MSDSL]
    AS [dbo];

