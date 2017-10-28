 CREATE PROCEDURE smConDiscount_Cancelled
		@parm1 varchar( 10 )
AS
	SELECT * FROM smConDiscount
	WHERE

		smConDiscount.ContractID = @parm1

	Order By
		smConDiscount.ContractID,
		smConDiscount.AccrueDate,
		smConDiscount.BillDate

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConDiscount_Cancelled] TO [MSDSL]
    AS [dbo];

