 /****** Object:  Stored Procedure dbo.PurchOrd_Status    Script Date: 4/16/98 7:50:26 PM ******/
Create Proc PurchOrd_Status as
    Select * from PurchOrd where Status <> 'M' and Status <> 'X'
        order by PONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurchOrd_Status] TO [MSDSL]
    AS [dbo];

