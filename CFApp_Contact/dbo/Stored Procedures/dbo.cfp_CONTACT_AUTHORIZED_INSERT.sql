
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 04/17/2008
-- Description:	Creates new cft_CONTACT_AUTHORIZED record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CONTACT_AUTHORIZED_INSERT
(
	@AuthorizedContactID		int,
	@ContactID					int,
	@CreatedBy					varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT dbo.cft_CONTACT_AUTHORIZED
	(
		[AuthorizedContactID]
		,[ContactID]
		,[CreatedBy]
	) 
	VALUES 
	(
		@AuthorizedContactID
		,@ContactID
		,@CreatedBy
	)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_AUTHORIZED_INSERT] TO [db_sp_exec]
    AS [dbo];

