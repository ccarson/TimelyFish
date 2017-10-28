
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 03/18/2008
-- Description:	Selects contract type record by status
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_CONTRACT_TYPE_SELECT_BY_STATUS]
(
    @ContractTypeStatusID	int,
    @FeedMillID			char(10)
)
AS
BEGIN
SET NOCOUNT ON;

SELECT CT.ContractTypeID,
       CT.Name,
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
INNER JOIN dbo.cft_CONTRACT_TYPE_FEED_MILL CTFM ON CTFM.ContractTypeID = CT.ContractTypeID AND CTFM.FeedMIllID = @FeedMillID

WHERE ContractTypeStatusID = @ContractTypeStatusID
ORDER BY Name
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CONTRACT_TYPE_SELECT_BY_STATUS] TO [db_sp_exec]
    AS [dbo];

