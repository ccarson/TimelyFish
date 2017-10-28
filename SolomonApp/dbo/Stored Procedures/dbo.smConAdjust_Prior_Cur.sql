 CREATE PROCEDURE smConAdjust_Prior_Cur
	@parm1 varchar( 6 )
AS
SELECT * FROM smConAdjust
	WHERE
		PerPost <= @parm1 AND
		AccruetoGL = 0
	ORDER BY
		PerPost,
		AccrueToGl,
		ContractID,
		TransDate,
		Batnbr,
		LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


