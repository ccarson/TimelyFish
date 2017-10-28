 CREATE PROCEDURE
        smContractBill_HistFix
                @parm1  smalldatetime
                ,@parm2 smalldatetime
AS
        SELECT
                *
        FROM
                smContractBill
        WHERE
                BillDate BETWEEN @parm1 AND @parm2
                        AND
                BillFlag = 1
                        AND
                Status = 'P'
        ORDER BY
                ContractID,
                BillDate

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContractBill_HistFix] TO [MSDSL]
    AS [dbo];

