 CREATE PROCEDURE smConMisc_all
        @parm1 varchar( 10 ),
        @parm2min smallint, @parm2max smallint
AS
        SELECT *
        FROM smConMisc
        WHERE BatNbr LIKE @parm1
           AND LineNbr BETWEEN @parm2min AND @parm2max
        ORDER BY BatNbr,
           LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


