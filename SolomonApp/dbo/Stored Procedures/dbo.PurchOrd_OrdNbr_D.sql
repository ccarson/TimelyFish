 /****** Object:  Stored Procedure dbo.PurchOrd_OrdNbr_D    Script Date: 4/16/98 7:50:26 PM ******/
Create Proc PurchOrd_OrdNbr_D @parm1 varchar ( 10) as
    Select * from PurchOrd where PONbr LIKE @parm1 Order by PONbr DESC


