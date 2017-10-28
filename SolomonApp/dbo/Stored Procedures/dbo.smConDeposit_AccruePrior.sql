 CREATE PROCEDURE smConDeposit_AccruePrior
        @parm1 varchar( 6 )
AS
SELECT * FROM smConDeposit
        WHERE
                PerPost < @parm1 AND
                AccruedtoGL = 0

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


