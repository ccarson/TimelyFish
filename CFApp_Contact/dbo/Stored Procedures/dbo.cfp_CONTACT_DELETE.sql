
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 04/17/2008
-- Description:	Deletes a contact record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CONTACT_DELETE
(
	@ContactID				int
)
AS
BEGIN
	DELETE dbo.cft_CONTACT_AUTHORIZED
	WHERE	ContactID = @ContactID	

	DELETE dbo.cft_CONTACT_AUTHORIZED
	WHERE	AuthorizedContactID= @ContactID	

	DELETE dbo.cft_CONTACT
	WHERE	ContactID = @ContactID				
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_DELETE] TO [db_sp_exec]
    AS [dbo];

