
-- ===================================================================
-- Author:	Doran Dahle
-- Create date: 09/9/2015
-- Description:	CENTRAL DATA - Deletes all Physical contact address record for a contact 
-- ===================================================================
Create PROCEDURE [dbo].[cfp_CD_CONTACT_ADDRESS_DELETE]
(
	@ContactID			int
)
AS
BEGIN
	Delete From [$(CentralData)].dbo.ContactAddress
	WHERE [ContactID] = @ContactID
		and [AddressTypeID] = 1
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_CONTACT_ADDRESS_DELETE] TO [db_sp_exec]
    AS [dbo];

