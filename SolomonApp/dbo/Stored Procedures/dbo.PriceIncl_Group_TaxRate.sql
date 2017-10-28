CREATE PROCEDURE PriceIncl_Group_TaxRate @GroupID varchar( 10 )
AS

SELECT Min(s.PrcTaxIncl), Min(g.GroupID), Min(s.Taxtype), SUM(ROUND(s.TaxRate,6))
  FROM SalesTax s WITH (NOLOCK) JOIN SlsTaxGrp g WITH (NOLOCK)
                    ON s.TaxID = g.TaxID
                   AND s.TaxType = 'T'
 WHERE g.GroupID = @GroupID
 GROUP BY g.GroupID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PriceIncl_Group_TaxRate] TO [MSDSL]
    AS [dbo];

