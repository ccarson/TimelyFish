
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 07/29/2009
-- Description:	CENTRAL DATA - Creates new contact phone record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CD_CONTACT_PHONE_INSERT
(
	@ContactID					int,
	@PhoneID					int,
	@PhoneTypeID				int,
	@PhoneCarrierID				int,
	@Comment					varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT [$(CentralData)].dbo.ContactPhone
	(
		[ContactID]
		,[PhoneID]
		,[PhoneTypeID]
		,[PhoneCarrierID]
		,[Comment]
	) 
	VALUES 
	(
		@ContactID
		,@PhoneID
		,@PhoneTypeID
		,@PhoneCarrierID
		,@Comment
	)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_CONTACT_PHONE_INSERT] TO [db_sp_exec]
    AS [dbo];

