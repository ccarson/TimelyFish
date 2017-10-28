-- ==============================================================================
-- Author:	Brian Cesafsky
-- Create date: 07/29/2009
-- Description:	CENTRAL DATA - Creates new contact record and returns it's ID.
-- 2015-08-03	Doran Dahle Added the MobileAccess column
-- ==============================================================================
CREATE PROCEDURE [dbo].[cfp_CD_CONTACT_INSERT]
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
	@StatusTypeID				int,
	@ShortName					varchar(30),
	@MobileAccess				Smallint
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT [$(CentralData)].dbo.Contact
	(
		[ContactName]
		,[ContactTypeID]
		,[Title]
		,[ContactFirstName]
		,[ContactMiddleName]
		,[ContactLastName]
		,[EMailAddress]
		,[TranSchedMethodTypeID]
		,[StatusTypeID]
		,[ShortName]
		,[MobileAccess]
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
		,@StatusTypeID
		,@ShortName
		,@MobileAccess
	)
	set @ContactID = @@identity
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_CONTACT_INSERT] TO [db_sp_exec]
    AS [dbo];

