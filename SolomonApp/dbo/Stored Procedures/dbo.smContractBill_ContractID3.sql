 CREATE PROCEDURE smContractBill_ContractID3 @parm1 varchar(10), @parm2 varchar(10), @parm3 varchar(10), @parm4 smallint, @parm5 smallint AS
          SELECT *,billamount+miscamt
            FROM smContractBill
           WHERE ContractId     = @parm1
	     AND BillDate BETWEEN @parm2 AND @parm3
             AND LineNbr BETWEEN @parm4 AND @parm5
        ORDER BY ContractID,
                 BillDate,
		 LineNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContractBill_ContractID3] TO [MSDSL]
    AS [dbo];

