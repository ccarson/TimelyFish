-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 03/22/2008
-- Description:	Returns all contacts by contact type
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_SELECT_BY_CONTACT_TYPE]
(
	@ContactTypeID		int
)
AS
BEGIN
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
		,Contact.DefaultContactMethodID
		,Contact.StatusTypeID
		,Contact.SolomonContactID
		,Contact.ShortName
	FROM dbo.cft_CONTACT Contact (NOLOCK)
	WHERE Contact.ContactTypeID = @ContactTypeID
	ORDER BY Contact.ContactName
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_SELECT_BY_CONTACT_TYPE] TO [db_sp_exec]
    AS [dbo];

