--*************************************************************
--	Purpose: Eligibility Code PV Override
--	Author: Sue Matter
--	Date: 3/23/2006
--	Usage: Bin Certification			 
--	Parms: Eligibility Type 
--*************************************************************

CREATE   PROCEDURE pXF207EligCodePV
	@parm1 smallint, @parm2 As varchar(3)
 AS 
 SELECT *
	FROM cftEligCode
	WHERE EligScr='O' 
	AND EligType = @parm1
 	AND EligCode = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF207EligCodePV] TO [MSDSL]
    AS [dbo];

