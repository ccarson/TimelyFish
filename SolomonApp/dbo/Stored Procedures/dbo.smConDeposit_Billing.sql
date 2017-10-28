 CREATE PROCEDURE smConDeposit_Billing
        @parm1 varchar( 10 ),
        @parm2 smalldatetime
AS
        SELECT * FROM smConDeposit
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



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConDeposit_Billing] TO [MSDSL]
    AS [dbo];

