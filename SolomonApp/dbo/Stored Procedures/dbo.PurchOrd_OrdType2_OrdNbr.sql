 /****** Object:  Stored Procedure dbo.PurchOrd_OrdType2_OrdNbr    Script Date: 4/16/98 7:50:26 PM ******/
Create Proc PurchOrd_OrdType2_OrdNbr @parm1 varchar ( 2), @parm2 varchar ( 2), @parm3 varchar ( 10) as
    Select * from PurchOrd where (POType = @parm1 or POType = @parm2)
                  and PONbr like @parm3 and Status <> 'X' order by PONbr, POType


