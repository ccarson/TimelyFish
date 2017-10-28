 /****** Object:  Stored Procedure dbo.TaxRate_Updt    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc TaxRate_Updt @parm1 smalldatetime AS
       Select * from SalesTax
           where NewRateDate <= @parm1
           and   NewTaxRate <> 0
           and   TaxType = 'T'
           Order by TaxId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TaxRate_Updt] TO [MSDSL]
    AS [dbo];

