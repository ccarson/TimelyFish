 /****** Object:  Stored Procedure dbo.POReceipt_BatNbr    Script Date: 4/16/98 7:50:26 PM ******/
Create Procedure POReceipt_BatNbr @parm1 varchar ( 10) As
Select * From POReceipt
Where BatNbr = @parm1
        and Rlsed = 0
Order By Batnbr, RcptNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReceipt_BatNbr] TO [MSDSL]
    AS [dbo];

