
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 04/22/2008
-- Description:	Creates new contact phone record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CONTACT_PHONE_INSERT
(
	@ContactID					int,
	@PhoneID					int,
	@PhoneTypeID				int,
	@PhoneCarrierID				int,
	@Comment					varchar(50),
	@CreatedBy					varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT dbo.cft_CONTACT_PHONE
	(
		[ContactID]
		,[PhoneID]
		,[PhoneTypeID]
		,[PhoneCarrierID]
		,[Comment]
		,[CreatedBy]
	) 
	VALUES 
	(
		@ContactID
		,@PhoneID
		,@PhoneTypeID
		,@PhoneCarrierID
		,@Comment
		,@CreatedBy
	)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_PHONE_INSERT] TO [db_sp_exec]
    AS [dbo];

