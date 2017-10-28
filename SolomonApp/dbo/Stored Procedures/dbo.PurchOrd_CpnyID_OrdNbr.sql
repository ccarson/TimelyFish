 /****** Object:  Stored Procedure dbo.PurchOrd_CpnyID_OrdNbr    Script Date: 4/16/98 7:50:26 PM ******/
Create Proc PurchOrd_CpnyID_OrdNbr @parm1 varchar ( 10), @parm2 varchar(10) as
    Select * from PurchOrd where CpnyID = @parm1 and PONbr LIKE @parm2 and POType <> 'BL' Order by PONbr


