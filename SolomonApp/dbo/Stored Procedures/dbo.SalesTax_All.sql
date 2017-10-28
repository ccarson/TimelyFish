 /****** Object:  Stored Procedure dbo.SalesTax_All    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc SalesTax_All @parm1 varchar ( 10) as
    Select * from SalesTax
    where TaxId like @parm1
    order by TaxId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SalesTax_All] TO [MSDSL]
    AS [dbo];

