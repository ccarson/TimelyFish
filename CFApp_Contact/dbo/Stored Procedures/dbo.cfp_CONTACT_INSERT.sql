
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 04/17/2008
-- Description:	Creates new contact record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CONTACT_INSERT
(
	@ContactID					int		OUT,
	@ContactName				varchar(50),
	@ContactTypeID				int,
	@Title						int,
	@ContactFirstName			varchar(30),
	@ContactMiddleName			varchar(30),
	@ContactLastName			varchar(30),
	@EMailAddress				varchar(50),
	@TranSchedMethodTypeID		int,
	@DefaultContactMethodID		int,
	@StatusTypeID				int,
	@SolomonContactID			varchar(6),
	@ShortName					varchar(30),
	@CreatedBy					varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT dbo.cft_CONTACT
	(
		[ContactName]
		,[ContactTypeID]
		,[Title]
		,[ContactFirstName]
		,[ContactMiddleName]
		,[ContactLastName]
		,[EMailAddress]
		,[TranSchedMethodTypeID]
		,[DefaultContactMethodID]
		,[StatusTypeID]
		,[SolomonContactID]
		,[ShortName]
		,[CreatedBy]
	) 
	VALUES 
	(
		@ContactName
		,@ContactTypeID
		,@Title
		,@ContactFirstName
		,@ContactMiddleName
		,@ContactLastName
		,@EMailAddress
		,@TranSchedMethodTypeID
		,@DefaultContactMethodID
		,@StatusTypeID
		,@SolomonContactID
		,@ShortName
		,@CreatedBy
	)
	set @ContactID = @@identity
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_INSERT] TO [db_sp_exec]
    AS [dbo];

