 /****** Object:  Stored Procedure dbo.POReceipt_RcptNbr_BatNbr    Script Date: 4/16/98 7:50:26 PM ******/
Create Procedure POReceipt_RcptNbr_BatNbr @parm1 varchar ( 10), @parm2 varchar ( 10) As
Select * From POReceipt
Where POReceipt.BatNbr <> ' ' and POReceipt.BatNbr = @parm1 And POReceipt.RcptNbr LIKE @parm2
Order By POReceipt.RcptNbr


