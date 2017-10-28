-- ===========================================================================
-- Author:		Brian Cesafsky
-- Create date: 11/14/2008
-- Description:	CENTRAL DATA - Returns all contacts that share the same phone
-- ===========================================================================
CREATE PROCEDURE [dbo].[cfp_CD_CONTACT_SELECT_BY_PHONE_ID]
(
	@PhoneID		int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Distinct 
		Contact.ContactID
		,Contact.ContactName
	FROM [$(CentralData)].dbo.Contact Contact (NOLOCK)
	LEFT JOIN [$(CentralData)].dbo.ContactPhone ContactPhone (NOLOCK)
		ON ContactPhone.ContactID = Contact.ContactID
	WHERE ContactPhone.PhoneID = @PhoneID
	AND Contact.StatusTypeID = 1
	ORDER BY ContactName

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_CONTACT_SELECT_BY_PHONE_ID] TO [db_sp_exec]
    AS [dbo];

