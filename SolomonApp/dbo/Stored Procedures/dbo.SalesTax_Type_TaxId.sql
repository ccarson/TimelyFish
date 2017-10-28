 /****** Object:  Stored Procedure dbo.SalesTax_Type_TaxId   ******/
Create Proc  SalesTax_Type_TaxId @parm1 varchar ( 1), @parm2 varchar ( 10) as
       Select * from SalesTax
           where TaxType LIKE @parm1
             and TaxId   LIKE @parm2
           order by TaxType, TaxId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SalesTax_Type_TaxId] TO [MSDSL]
    AS [dbo];

