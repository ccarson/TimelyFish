
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 04/17/2008
-- Description:	Deletes an address record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_ADDRESS_DELETE
(
	@AddressID		int
)
AS
BEGIN
	DELETE dbo.cft_ADDRESS
	WHERE	AddressID = @AddressID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_ADDRESS_DELETE] TO [db_sp_exec]
    AS [dbo];

