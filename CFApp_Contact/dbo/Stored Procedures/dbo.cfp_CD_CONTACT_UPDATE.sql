-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 07/29/2009
-- Description:	CENTRAL DATA - Updates a record in CONTACT
-- 2015-08-03	Doran Dahle Added the MobileAccess column
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_CD_CONTACT_UPDATE]
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
		,@StatusTypeID				int
		,@ShortName					varchar(30)
		,@MobileAccess				Smallint
)
AS
BEGIN

UPDATE [$(CentralData)].dbo.Contact
   SET 	[ContactName] = @ContactName
		,[ContactTypeID] = @ContactTypeID
		,[Title] = @Title
		,[ContactFirstName] = @ContactFirstName
		,[ContactMiddleName] = @ContactMiddleName
		,[ContactLastName] = @ContactLastName
		,[EMailAddress] = @EMailAddress
		,[TranSchedMethodTypeID] = @TranSchedMethodTypeID
		,[StatusTypeID] = @StatusTypeID
		,[ShortName] = @ShortName
		,[MobileAccess] = @MobileAccess
 WHERE 
		[ContactID] = @ContactID
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_CONTACT_UPDATE] TO [db_sp_exec]
    AS [dbo];

