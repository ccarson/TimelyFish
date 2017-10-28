 CREATE PROCEDURE smConDeposit_all
        @parm1 varchar( 10 ),
        @parm2min smallint, @parm2max smallint
AS
        SELECT *
        FROM smConDeposit
        WHERE BatNbr LIKE @parm1
           AND LineNbr BETWEEN @parm2min AND @parm2max
        ORDER BY BatNbr,
           LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConDeposit_all] TO [MSDSL]
    AS [dbo];

