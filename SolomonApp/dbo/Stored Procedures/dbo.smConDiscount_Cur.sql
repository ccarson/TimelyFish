 CREATE PROCEDURE smConDiscount_Cur
	@parm1 smalldatetime,
	@parm2 smalldatetime
AS
SELECT * FROM smConDiscount
	WHERE
		AccrueDate >= @parm1 and
		Accruedate <= @parm2
			AND
		AccruetoGL = 0
	ORDER BY
		AccrueDate,
		AccrueToGL,
		ContractID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConDiscount_Cur] TO [MSDSL]
    AS [dbo];

