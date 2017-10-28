
CREATE proc WS_DMG_SalesTax_All 
@TaxID varchar (10)
as  
	SELECT SalesTax.TaxId [Tax ID], SalesTax.Descr [Description], SalesTax.TaxRate [Tax Rate] FROM SalesTax Where TaxID LIKE @TaxID AND TaxType in ('G','T') ORDER BY TaxID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_DMG_SalesTax_All] TO [MSDSL]
    AS [dbo];

