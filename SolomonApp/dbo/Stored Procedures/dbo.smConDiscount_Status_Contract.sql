 CREATE PROCEDURE smConDiscount_Status_Contract
	@parm1 varchar( 1 ),
	@parm2 varchar( 10 ),
	@parm3 smalldatetime
AS
	SELECT *
	FROM smConDiscount
	WHERE Status LIKE @parm1
	   AND ContractID LIKE @parm2
	   AND BillDate <= @parm3
	ORDER BY Status,
	   ContractID,
	   BillDate

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConDiscount_Status_Contract] TO [MSDSL]
    AS [dbo];

