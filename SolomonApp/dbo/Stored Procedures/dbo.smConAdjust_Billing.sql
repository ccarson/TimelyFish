 CREATE PROCEDURE smConAdjust_Billing
	@parm1 varchar( 10 ),
	@parm2 smalldatetime
	AS
SELECT * FROM smConAdjust
	WHERE
		ContractID = @parm1 AND
		BillDate <= @parm2 AND
		Status = 'A'
	ORDER BY
		ContractID,
		BillDate,
		Batnbr,
		LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


