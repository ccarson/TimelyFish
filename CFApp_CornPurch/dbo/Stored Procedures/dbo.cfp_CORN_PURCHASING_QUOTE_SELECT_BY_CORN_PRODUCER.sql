
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 05/15/2008
-- Description:	Selects active Quote records by CornProducer
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_QUOTE_SELECT_BY_CORN_PRODUCER
(
    @CornProducerID	varchar(30),
    @FeedMillID		char(10)
)
AS
BEGIN
SET NOCOUNT ON;

SELECT Q.QuoteID,
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
WHERE Q.CornProducerID = @CornProducerID AND Q.Active = 1 AND datediff(day,getdate(),Q.EffectiveDate) IN (-1,0) AND Q.FeedMillID = @FeedMillID
ORDER BY QuoteID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_QUOTE_SELECT_BY_CORN_PRODUCER] TO [db_sp_exec]
    AS [dbo];

