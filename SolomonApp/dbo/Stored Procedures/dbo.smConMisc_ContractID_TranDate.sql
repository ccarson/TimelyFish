 CREATE PROCEDURE smConMisc_ContractID_TranDate
        @parm1 varchar( 10 ),
        @parm2min smalldatetime, @parm2max smalldatetime,
        @parm3 varchar( 10 ),
        @parm4min smallint, @parm4max smallint
AS
        SELECT *
        FROM smConMisc
        WHERE ContractID LIKE @parm1
           AND TranDate BETWEEN @parm2min AND @parm2max
           AND BatNbr LIKE @parm3
           AND LineNbr BETWEEN @parm4min AND @parm4max
        ORDER BY ContractID,
           TranDate,
           BatNbr,
           LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


