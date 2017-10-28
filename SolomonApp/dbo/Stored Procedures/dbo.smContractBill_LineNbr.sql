 CREATE PROCEDURE
        smContractBill_LineNbr
                @parm1  varchar(10)
                ,@parm2beg      smallint
                ,@parm2end      smallint
AS
        SELECT
                *
        FROM
                smContractBill
        WHERE
                ContractId = @parm1
                        AND
                LineNbr BETWEEN @parm2beg AND @parm2end
        ORDER BY
                ContractID,
                LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContractBill_LineNbr] TO [MSDSL]
    AS [dbo];

