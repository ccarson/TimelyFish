 /****** Object:  Stored Procedure dbo.PurchOrd_Last    Script Date: 4/16/98 7:50:26 PM ******/
Create Proc PurchOrd_Last as
    Select PurchOrd.PONbr from PurchOrd
        order by PONbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurchOrd_Last] TO [MSDSL]
    AS [dbo];

