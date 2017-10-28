
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 09/28/2009
-- Description:	CENTRAL DATA - Deletes an address record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CD_ADDRESS_DELETE
(
	@AddressID		int
)
AS
BEGIN
	DELETE [$(CentralData)].dbo.Address
	WHERE	AddressID = @AddressID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_ADDRESS_DELETE] TO [db_sp_exec]
    AS [dbo];

