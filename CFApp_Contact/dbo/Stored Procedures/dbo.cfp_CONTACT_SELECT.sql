-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 04/30/2008
-- Description:	Returns all contacts
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_SELECT]
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
		--,Contact.DefaultContactMethodID
		,Contact.StatusTypeID
		,Contact.SolomonContactID
		,Contact.ShortName
	FROM [$(CentralData)].dbo.Contact Contact (NOLOCK)
	ORDER BY Contact.ContactName
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_SELECT] TO [db_sp_exec]
    AS [dbo];

