 Create Procedure POReceipt_PONbr @parm1 varchar ( 10) As
Select distinct POReceipt.* From POReceipt WITH (NoLock)
inner join potran  WITH (NoLock) on potran.rcptnbr = POReceipt.rcptnbr
Where potran.PONbr = @parm1 And POReceipt.Rlsed = 0
Order By POReceipt.PONbr, POReceipt.RcptNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReceipt_PONbr] TO [MSDSL]
    AS [dbo];

