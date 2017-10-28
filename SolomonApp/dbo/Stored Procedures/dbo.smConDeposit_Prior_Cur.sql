 CREATE PROCEDURE smConDeposit_Prior_Cur
        @parm1 varchar( 6 )
AS
SELECT * FROM smConDeposit
        WHERE
                PerPost <= @parm1 AND
                AccruedtoGL = 0
        ORDER BY
                PerPost,
                AccruedToGL,
                ContractID,
                TranDate,
                Batnbr,
                Linenbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


