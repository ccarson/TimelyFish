-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 06/10/2008
-- Description:	Updates a record in cft_CONTACT
-- ============================================================
CREATE PROCEDURE dbo.cfp_CONTACT_UPDATE
(
		@ContactID					int
		,@ContactName				varchar(50)
		,@ContactTypeID				int
		,@Title						int
		,@ContactFirstName			varchar(30)
		,@ContactMiddleName			varchar(30)
		,@ContactLastName			varchar(30)
		,@EMailAddress				varchar(50)
		,@TranSchedMethodTypeID		int
		,@DefaultContactMethodID	int
		,@StatusTypeID				int
		,@SolomonContactID			varchar(6)
		,@ShortName					varchar(30)
		,@UpdatedBy					varchar(50)
)
AS
BEGIN

UPDATE dbo.cft_CONTACT
   SET 	[ContactName] = @ContactName
		,[ContactTypeID] = @ContactTypeID
		,[Title] = @Title
		,[ContactFirstName] = @ContactFirstName
		,[ContactMiddleName] = @ContactMiddleName
		,[ContactLastName] = @ContactLastName
		,[EMailAddress] = @EMailAddress
		,[TranSchedMethodTypeID] = @TranSchedMethodTypeID
		,[DefaultContactMethodID] = @DefaultContactMethodID
		,[StatusTypeID] = @StatusTypeID
		,[SolomonContactID] = @SolomonContactID
		,[ShortName] = @ShortName
		,[UpdatedBy] = @UpdatedBy

 WHERE 
		[ContactID] = @ContactID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_UPDATE] TO [db_sp_exec]
    AS [dbo];

