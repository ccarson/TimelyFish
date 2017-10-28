
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 05/29/2008
-- Description:	Return true if contract has partial tickets assigned, false otherwise.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_CONTRACT_HAS_PARTIAL_TICKETS]
(
    @ContractID		int
)
AS
BEGIN

  DECLARE @HasPartialTickets bit

  SELECT @HasPartialTickets = CASE WHEN EXISTS (SELECT 1 FROM dbo.cft_PARTIAL_TICKET WHERE ContractID = @ContractID) THEN 1 ELSE 0 END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CONTRACT_HAS_PARTIAL_TICKETS] TO [db_sp_exec]
    AS [dbo];

