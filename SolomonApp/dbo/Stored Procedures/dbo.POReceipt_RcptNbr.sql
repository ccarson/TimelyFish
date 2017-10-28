 /****** Object:  Stored Procedure dbo.POReceipt_RcptNbr    Script Date: 4/16/98 7:50:26 PM ******/
Create Procedure POReceipt_RcptNbr @parm1 varchar ( 10), @parm2 varchar ( 10) As
Select distinct poreceipt.* From POReceipt
inner join potran on potran.rcptnbr = poreceipt.ponbr
Where potran.PONbr = @parm1 And POReceipt.RcptNbr = @parm2 And POReceipt.Rlsed = 0
Order By POReceipt.PONbr, POReceipt.RcptNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReceipt_RcptNbr] TO [MSDSL]
    AS [dbo];

