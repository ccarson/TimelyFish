
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 05/22/2008
-- Description:	Selects Price Later  contract type record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_CONTRACT_TYPE_SELECT_PRICE_LATER]
(
    @FeedMillID		char(10)
)
AS
BEGIN
SET NOCOUNT ON;

SELECT CT.ContractTypeID,
       CT.Name,
       CT.ContractTypeStatusID,
       CT.Template,
       CT.TemplateFields,
       CT.TemplateFileName,
       CT.PriceLater,
       CT.DeferredPayment,
		CT.CRM,
       CT.CreatedDateTime,
       CT.CreatedBy,
       CT.UpdatedDateTime,
       CT.UpdatedBy   
FROM dbo.cft_CONTRACT_TYPE CT
INNER JOIN dbo.cft_CONTRACT_TYPE_FEED_MILL CTFM ON CT.ContractTypeID = CTFM.ContractTypeID
WHERE CTFM.FeedMillID = @FeedMillID AND CT.PriceLater = 1
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CONTRACT_TYPE_SELECT_PRICE_LATER] TO [db_sp_exec]
    AS [dbo];

