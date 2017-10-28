
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 03/05/2008
-- Description:	Selects contract type record by id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_CONTRACT_TYPE_SELECT_BY_ID]
(
    @ContractTypeID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT Name,
       ContractTypeStatusID,
       Template,
       TemplateFields,
       TemplateFileName,
       PriceLater,
       DeferredPayment,
		CRM,
       CreatedDateTime,
       CreatedBy,
       UpdatedDateTime,
       UpdatedBy   
FROM dbo.cft_CONTRACT_TYPE
WHERE ContractTypeID = @ContractTypeID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CONTRACT_TYPE_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

