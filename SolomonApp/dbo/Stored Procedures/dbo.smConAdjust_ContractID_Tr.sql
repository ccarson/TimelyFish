 CREATE PROCEDURE smConAdjust_ContractID_Tr
	@parm1 varchar( 10 ),
	@parm2min smalldatetime, @parm2max smalldatetime
	AS
	SELECT *
	FROM smConAdjust
	WHERE ContractID LIKE @parm1
	   AND TransDate BETWEEN @parm2min AND @parm2max
	ORDER BY ContractID,
	   TransDate

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


