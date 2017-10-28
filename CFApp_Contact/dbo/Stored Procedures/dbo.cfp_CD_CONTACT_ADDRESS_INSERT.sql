
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 09/28/2009
-- Description:	CENTRAL DATA - Creates new contact address record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CD_CONTACT_ADDRESS_INSERT
(
	@ContactID					int,
	@AddressID					int,
	@AddressTypeID				int
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT [$(CentralData)].dbo.ContactAddress
	(
		[ContactID]
		,[AddressID]
		,[AddressTypeID]
	) 
	VALUES 
	(
		@ContactID
		,@AddressID
		,@AddressTypeID
	)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_CONTACT_ADDRESS_INSERT] TO [db_sp_exec]
    AS [dbo];

