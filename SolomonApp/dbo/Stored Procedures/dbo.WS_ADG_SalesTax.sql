
CREATE proc WS_ADG_SalesTax 
@TaxID varchar (10)
as  
	SELECT TaxID, Descr, TaxType, TaxRate FROM SalesTax WHERE TaxId LIKE @TaxID ORDER BY TaxID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_ADG_SalesTax] TO [MSDSL]
    AS [dbo];

