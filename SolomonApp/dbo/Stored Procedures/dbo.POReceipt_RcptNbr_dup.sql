 /****** Object:  Stored Procedure dbo.POReceipt_RcptNbr_dup    Script Date: 4/16/98 7:50:26 PM ******/
Create Procedure POReceipt_RcptNbr_dup @parm1 varchar ( 10) As
Select * From POReceipt
Where POReceipt.RcptNbr = @parm1
Order By POReceipt.RcptNbr


