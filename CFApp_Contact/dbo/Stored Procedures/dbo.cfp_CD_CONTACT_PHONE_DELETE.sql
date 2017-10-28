
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 06/04/2010
-- Description:	CENTRAL DATA - Deletes a contact phone record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CD_CONTACT_PHONE_DELETE
(
	@ContactID			int
	,@PhoneID			int
	,@PhoneTypeID		int
)
AS
BEGIN
	DELETE [$(CentralData)].dbo.ContactPhone
	WHERE ContactID = @ContactID
	AND PhoneID = @PhoneID
	AND PhoneTypeID = @PhoneTypeID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_CONTACT_PHONE_DELETE] TO [db_sp_exec]
    AS [dbo];

