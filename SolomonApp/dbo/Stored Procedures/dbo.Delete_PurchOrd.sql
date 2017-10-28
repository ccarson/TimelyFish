 /****** Object:  Stored Procedure dbo.Delete_PurchOrd    Script Date: 4/16/98 7:50:25 PM ******/
Create Proc Delete_PurchOrd @parm1 varchar ( 6) as
    Select * from PurchOrd where
                (PerClosed <= @parm1 and PerClosed <> '')
        Order by PONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_PurchOrd] TO [MSDSL]
    AS [dbo];

