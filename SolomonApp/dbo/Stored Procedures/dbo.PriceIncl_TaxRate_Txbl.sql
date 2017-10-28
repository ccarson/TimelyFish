CREATE PROCEDURE PriceIncl_TaxRate_Txbl @TaxID VarChar(10), @TaxCat VarChar(10)
AS

SELECT PrcTaxincl,TaxId,TaxRate,TaxType,  
       CASE WHEN CatFlg = 'A'
            THEN CASE WHEN CatExcept00 = @TaxCat 
                        OR CatExcept01 = @TaxCat
                        OR CatExcept02 = @TaxCat
                        OR CatExcept03 = @TaxCat
                        OR CatExcept04 = @TaxCat
                        OR CatExcept05 = @TaxCat
                      THEN 'N'
                      ELSE 'Y'
                       END
			ELSE CASE WHEN CatExcept00 = @TaxCat 
                        OR CatExcept01 = @TaxCat
                        OR CatExcept02 = @TaxCat
                        OR CatExcept03 = @TaxCat
                        OR CatExcept04 = @TaxCat
                        OR CatExcept05 = @TaxCat
                      THEN 'Y'
                      ELSE 'N'
                       END
             END
  FROM SalesTax WITH (NOLOCK)
 WHERE Taxid = @TaxID


