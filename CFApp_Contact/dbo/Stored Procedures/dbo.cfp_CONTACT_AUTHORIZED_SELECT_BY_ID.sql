-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 05/14/2008
-- Description:	Returns all authorized contacts
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_AUTHORIZED_SELECT_BY_ID]
(
	@ContactID		int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
        ContactAuthorized.ContactID
        ,ContactAuthorized.AuthorizedContactID
		,Contact.ContactID
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
      FROM dbo.cft_CONTACT_AUTHORIZED ContactAuthorized (NOLOCK)
      LEFT JOIN dbo.cft_CONTACT Contact (NOLOCK)
            ON ContactAuthorized.AuthorizedContactID=Contact.ContactID 
      WHERE   (ContactAuthorized.ContactID = @ContactID)
      ORDER BY Contact.ContactName

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_AUTHORIZED_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

