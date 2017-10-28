
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 05/13/2008
-- Description:	Selects Quote record by id
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_QUOTE_SELECT_BY_ID
(
    @QuoteID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT Q.CornProducerID,
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
       Q.feedMillID
FROM dbo.cft_QUOTE Q
INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendID = Q.CornProducerID

WHERE Q.QuoteID = @QuoteID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_QUOTE_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

