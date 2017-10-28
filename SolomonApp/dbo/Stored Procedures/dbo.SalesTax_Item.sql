 /****** Object:  Stored Procedure dbo.SalesTax_Item    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc SalesTax_Item @parm1 varchar ( 10) as
    Select * from SalesTax
    where TaxId like @parm1
    and TaxCalcType = 'I'
    order by TaxId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SalesTax_Item] TO [MSDSL]
    AS [dbo];

