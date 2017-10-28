 create Proc CA_Find_AR_Batch_By_Amount @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 float as
Select * from batch
Where module = 'AR'
and CpnyID = @parm1
and BankAcct = @parm2
and BankSub = @parm3
and CuryDepositAmt = @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CA_Find_AR_Batch_By_Amount] TO [MSDSL]
    AS [dbo];

