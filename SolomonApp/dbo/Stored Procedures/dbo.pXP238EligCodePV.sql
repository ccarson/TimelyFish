--*************************************************************
--	Purpose: Eligibility Code PV 
--	Author: Sue Matter
--	Date: 2/2/2006
--	Usage: Pig Group Eligibility			 
--	Parms: Eligibility Type 
--*************************************************************

CREATE   PROCEDURE pXP238EligCodePV
	@parm1 smallint, @parm2 As varchar(3)
 AS 
 SELECT *
	FROM cftEligCode
	WHERE EligScr='P' 
	AND EligType = @parm1
 	AND EligCode = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP238EligCodePV] TO [MSDSL]
    AS [dbo];

