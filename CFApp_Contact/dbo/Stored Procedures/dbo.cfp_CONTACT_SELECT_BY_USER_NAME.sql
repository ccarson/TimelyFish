-- =====================================================================
-- Author:		Brian Cesafsky
-- Create date: 06/30/2008
-- Description:	Returns a contact record
-- =====================================================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_SELECT_BY_USER_NAME]
(
	@UserID		varchar(20)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT	
		Contact.ContactID
		,Contact.ContactName
		,Contact.ContactTypeID
		,Contact.Title
		,Contact.ContactFirstName
		,Contact.ContactMiddleName
		,Contact.ContactLastName	
		,Contact.EMailAddress
		,Contact.TranSchedMethodTypeID
		,Contact.StatusTypeID
		,Contact.SolomonContactID
		,Contact.ShortName
	FROM [$(CentralData)].dbo.Contact Contact (NOLOCK)
	LEFT OUTER JOIN [$(CentralData)].dbo.Employee Employee (NOLOCK)
		ON cast(Employee.ContactID as int) = cast(Contact.ContactID as int) 
	WHERE rtrim(Employee.UserID) = @UserID	
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_SELECT_BY_USER_NAME] TO [db_sp_exec]
    AS [dbo];

