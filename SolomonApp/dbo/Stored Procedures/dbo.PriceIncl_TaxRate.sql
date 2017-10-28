CREATE PROCEDURE PriceIncl_TaxRate @TaxID varchar( 10 )
AS 

SELECT PrcTaxIncl,TaxId,TaxType,TaxRate 
  FROM SalesTax WITH (NOLOCK)
 WHERE TaxID = @TaxID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PriceIncl_TaxRate] TO [MSDSL]
    AS [dbo];

