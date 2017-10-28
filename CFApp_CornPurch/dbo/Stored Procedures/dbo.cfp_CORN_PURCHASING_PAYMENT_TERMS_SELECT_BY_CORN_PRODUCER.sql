
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 05/28/2008
-- Description:	Selects Payment Terms records and marks one as default for CornProducer
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_PAYMENT_TERMS_SELECT_BY_CORN_PRODUCER]
(
    @CornProducerID	char(15)
)
AS
BEGIN
SET NOCOUNT ON;

SELECT T.TermsID,
       T.Descr AS Description,
       CAST(CASE WHEN V.VendID IS NULL THEN 0 ELSE 1 END AS bit) AS IsDefaultForCornProducer
FROM [$(SolomonApp)].dbo.Terms T
LEFT OUTER JOIN [$(SolomonApp)].dbo.Vendor V ON T.TermsID = V.Terms AND V.VendID = @CornProducerID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_PAYMENT_TERMS_SELECT_BY_CORN_PRODUCER] TO [db_sp_exec]
    AS [dbo];

