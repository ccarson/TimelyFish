
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 07/15/2008
-- Description: Deletes Marketer for Contract
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_MARKETER_DELETE_BY_CONTRACT]
(
    @ContractID	int
)
AS
BEGIN
SET NOCOUNT ON;



DELETE dbo.cft_CONTRACT_MARKETER
WHERE ContractID = @ContractID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_MARKETER_DELETE_BY_CONTRACT] TO [db_sp_exec]
    AS [dbo];

