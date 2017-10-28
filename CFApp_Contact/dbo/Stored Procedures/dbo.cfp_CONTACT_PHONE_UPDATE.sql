
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 07/21/2008
-- Description:	Updates a contact phone record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CONTACT_PHONE_UPDATE
(
	@PhoneID			int,
	@PhoneTypeID		int,
	@Comment			varchar(50),
	@PhoneCarrierID		int,
	@UpdatedBy			varchar(50)
)
AS
BEGIN
	UPDATE dbo.cft_CONTACT_PHONE
	SET [PhoneTypeID] = @PhoneTypeID
		,[Comment] = @Comment
		,[PhoneCarrierID] = @PhoneCarrierID
		,[UpdatedBy] = @UpdatedBy

	WHERE 
		[PhoneID] = @PhoneID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_PHONE_UPDATE] TO [db_sp_exec]
    AS [dbo];

