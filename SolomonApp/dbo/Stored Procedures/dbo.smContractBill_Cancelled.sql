 CREATE PROCEDURE smContractBill_Cancelled
        @parm1 as VarChar(10)
AS
        SELECT * FROM smContractBill
        WHERE
                smContractBill.BillFlag = 0 AND
                smContractBill.Status = 'O' AND
                smContractBill.ContractID = @parm1

        Order By
                smContractBill.ContractID,
                smContractBill.BillDate

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContractBill_Cancelled] TO [MSDSL]
    AS [dbo];

