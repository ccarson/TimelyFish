
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 03/07/2008
-- Description:	Selects final delivery date for a contract.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_CONTRACT_SELECT_FINAL_DELIVERY_DATE]
(
    @ContractID		int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT TOP 1 DeliveryDate
FROM dbo.cft_PARTIAL_TICKET
WHERE ContractID = @ContractID
ORDER BY DeliveryDate DESC

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CONTRACT_SELECT_FINAL_DELIVERY_DATE] TO [db_sp_exec]
    AS [dbo];

