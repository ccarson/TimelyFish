 CREATE PROCEDURE smConAdjust_ContractID_Tr1
	@parm1 varchar( 10 ),
	@parm2min smalldatetime, @parm2max smalldatetime,
	@parm3 varchar( 10 )
AS
	SELECT *
	FROM smConAdjust
	WHERE ContractID LIKE @parm1
	   AND TransDate BETWEEN @parm2min AND @parm2max
	   AND Batnbr LIKE @parm3
	ORDER BY ContractID,
	   TransDate,
	   Batnbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


