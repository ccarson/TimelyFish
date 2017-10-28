 CREATE PROCEDURE smConMisc_ContractID_Taxable_
        @parm1 varchar( 10 ),
        @parm2 varchar( 1 ),
        @parm3 varchar( 10 )
AS
        SELECT *
        FROM smConMisc
        WHERE ContractID LIKE @parm1
           AND Taxable LIKE @parm2
           AND BatNbr LIKE @parm3
        ORDER BY ContractID,
           Taxable,
           BatNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


