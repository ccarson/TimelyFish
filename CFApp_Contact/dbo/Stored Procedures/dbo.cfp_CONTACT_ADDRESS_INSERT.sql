
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 04/17/2008
-- Description:	Creates new contact address record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CONTACT_ADDRESS_INSERT
(
	@ContactID					int,
	@AddressID					int,
	@AddressTypeID				int,
	@CreatedBy					varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT dbo.cft_CONTACT_ADDRESS
	(
		[ContactID]
		,[AddressID]
		,[AddressTypeID]
		,[CreatedBy]
	) 
	VALUES 
	(
		@ContactID
		,@AddressID
		,@AddressTypeID
		,@CreatedBy
	)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_ADDRESS_INSERT] TO [db_sp_exec]
    AS [dbo];

