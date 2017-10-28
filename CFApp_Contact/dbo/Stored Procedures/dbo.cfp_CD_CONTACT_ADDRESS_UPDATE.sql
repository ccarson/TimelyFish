
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 09/28/2009
-- Description:	CENTRAL DATA - Updates a contact address record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CD_CONTACT_ADDRESS_UPDATE
(
	@AddressID			int,
	@AddressTypeID		int
)
AS
BEGIN
	UPDATE [$(CentralData)].dbo.ContactAddress
	SET [AddressTypeID] = @AddressTypeID
	WHERE 
		[AddressID] = @AddressID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_CONTACT_ADDRESS_UPDATE] TO [db_sp_exec]
    AS [dbo];

