 CREATE PROCEDURE smConDiscount_Accrue
AS
SELECT * FROM smConDiscount
	WHERE
		smConDiscount.AccrualProcess = 0

	ORDER BY
		smConDiscount.ContractID,
		smConDiscount.AccrueDate,
		smConDiscount.BillDate

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConDiscount_Accrue] TO [MSDSL]
    AS [dbo];

