 CREATE PROCEDURE smConAdjust_AccruePrior
	@parm1 varchar( 6 )
AS
SELECT * FROM smConAdjust
	WHERE
		PerPost < @parm1 AND
		AccruetoGL = 0

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConAdjust_AccruePrior] TO [MSDSL]
    AS [dbo];

