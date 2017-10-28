
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 05/13/2008
-- Description:	Selects all Quote records
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_QUOTE_SELECT
(
  @FeedMillID	char(10)
)
AS
BEGIN
SET NOCOUNT ON;

SELECT Q.QuoteID,
       Q.CornProducerID,
       Q.Price,
       Q.Active,
       Q.NumberOfLoads,
       Q.EffectiveDate,
       Q.EffectiveDateTo,
       Q.Futures,
       Q.Basis,
       Q.CreatedDateTime,
       Q.CreatedBy,
       Q.UpdatedDateTime,
       Q.UpdatedBy,
       V.RemitName AS CornProducerBusinessName,
       Q.FeedMillID
FROM dbo.cft_QUOTE Q
INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendID = Q.CornProducerID
WHERE Q.FeedMillID = @FeedMillID
ORDER BY Q.QuoteID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_QUOTE_SELECT] TO [db_sp_exec]
    AS [dbo];

