 CREATE PROCEDURE smConMisc_Billing
        @parm1 varchar( 10 ),
        @parm2 smalldatetime
AS
SELECT * FROM smConMisc
        WHERE
                ContractID = @parm1 AND
                TranDate <= @parm2 AND
                Status = 'A'
        ORDER BY
                ContractID,
                TranDate,
                Batnbr,
                LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


