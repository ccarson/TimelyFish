 /****** Object:  Stored Procedure dbo.PurchOrd_CpnyID_OrdNbr_D    Script Date: 4/16/98 7:50:26 PM ******/
Create Proc PurchOrd_CpnyID_OrdNbr_D @parm1 varchar ( 10), @parm2 varchar(10) as
    Select * from PurchOrd where CpnyID = @parm1 and PONbr LIKE @parm2 Order by PONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurchOrd_CpnyID_OrdNbr_D] TO [MSDSL]
    AS [dbo];

