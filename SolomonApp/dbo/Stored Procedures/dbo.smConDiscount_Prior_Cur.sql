 CREATE PROCEDURE smConDiscount_Prior_Cur
	@parm1 smalldatetime
AS
SELECT * FROM smConDiscount
	WHERE
		AccrueDate <= @parm1 AND
		AccruetoGL = 0
	ORDER BY
		AccrueDate,
		AccrueToGl,
		ContractID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConDiscount_Prior_Cur] TO [MSDSL]
    AS [dbo];

