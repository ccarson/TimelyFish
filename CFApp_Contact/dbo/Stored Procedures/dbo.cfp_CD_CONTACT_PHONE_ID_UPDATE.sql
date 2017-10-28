
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 06/04/2010
-- Description:	Updates a contact phone PhoneID
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CD_CONTACT_PHONE_ID_UPDATE
(
	@ContactID			int
	,@PhoneID			int
	,@PhoneTypeID		int
)
AS
BEGIN

	UPDATE [$(CentralData)].dbo.ContactPhone
	SET PhoneID = @PhoneID
	WHERE ContactID = @ContactID
	AND PhoneTypeID = @PhoneTypeID
	
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_CONTACT_PHONE_ID_UPDATE] TO [db_sp_exec]
    AS [dbo];

