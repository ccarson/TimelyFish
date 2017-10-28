-- =======================================================================
-- Author:		Brian Cesafsky
-- Create date: 07/15/2009
-- Description:	CENTRAL DATA - Returns all contacts (NOT including SITES)
-- =======================================================================
CREATE PROCEDURE [dbo].[cfp_CD_CONTACT_SELECT]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Contact.ContactID
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
		  ,Title.TitleDescription
	FROM [$(CentralData)].dbo.Contact Contact (NOLOCK)
	LEFT JOIN [$(CentralData)].dbo.Title Title (NOLOCK)
		ON Title.TitleID=Contact.Title 
	--WHERE ContactTypeID <> 4 --Do NOT include Sites
	ORDER BY ContactName
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_CONTACT_SELECT] TO [db_sp_exec]
    AS [dbo];

