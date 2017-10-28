-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 11/14/2008
-- Description:	CENTRAL DATA - Returns all contacts by contact type 
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_CD_CONTACT_SELECT_BY_CONTACT_TYPE]
(
	@ContactTypeID		int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Contact.ContactID
		,Contact.ContactName
	FROM [$(CentralData)].dbo.Contact Contact (NOLOCK)
	LEFT JOIN [$(CentralData)].dbo.ContactRoleType ContactRoleType (NOLOCK)
		ON ContactRoleType.ContactID=Contact.ContactID 
	WHERE ContactTypeID = @ContactTypeID
	AND StatusTypeID = 1
	ORDER BY ContactName

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_CONTACT_SELECT_BY_CONTACT_TYPE] TO [db_sp_exec]
    AS [dbo];

