
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 03/04/2008
-- Description:	Selects all contract type records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_CONTRACT_TYPE_SELECT]
AS
BEGIN
SET NOCOUNT ON;

SELECT ContractTypeID,
       Name,
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
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CONTRACT_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];

