
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 07/21/2008
-- Description:	Updates a contact phone record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CD_CONTACT_PHONE_UPDATE
(
	@PhoneID			int,
	@PhoneTypeID		int,
	@Comment			varchar(50),
	@PhoneCarrierID		int
)
AS
BEGIN
	UPDATE [$(CentralData)].dbo.ContactPhone
	SET [PhoneTypeID] = @PhoneTypeID
		,[Comment] = @Comment
		,[PhoneCarrierID] = @PhoneCarrierID
	WHERE 
		[PhoneID] = @PhoneID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_CONTACT_PHONE_UPDATE] TO [db_sp_exec]
    AS [dbo];

