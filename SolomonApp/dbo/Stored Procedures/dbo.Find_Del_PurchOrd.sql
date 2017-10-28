 /****** Object:  Stored Procedure dbo.Find_Del_PurchOrd    Script Date: 4/16/98 7:50:25 PM ******/
Create Proc Find_Del_PurchOrd @parm1 varchar ( 6) as
    Select * from PurchOrd
            where (PurchOrd.PerClosed <= @parm1 and PurchOrd.PerClosed <> '')


