 /****** Object:  Stored Procedure dbo.PurchOrd_VendId_Status_PONbr    Script Date: 4/16/98 7:50:26 PM ******/
Create Proc PurchOrd_VendId_Status_PONbr @parm1 varchar ( 15), @parm2 varchar ( 10) as
    Select * from PurchOrd where VendId = @parm1
        and PONbr Like @parm2 and Status = 'P'
        order by VendId, PONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurchOrd_VendId_Status_PONbr] TO [MSDSL]
    AS [dbo];

