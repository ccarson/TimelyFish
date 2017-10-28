-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 11/04/2009
-- Description:	CENTRAL DATA - Returns all sites by facility type 
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_CD_SITE_SELECT_BY_FACILITY_TYPE]
(
	@FacilityTypeID		int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Contact.ContactID
		,Contact.ContactName
	FROM [$(CentralData)].dbo.Contact Contact (NOLOCK)
	LEFT JOIN [$(CentralData)].dbo.Site Site (NOLOCK)
		ON Site.ContactID=Contact.ContactID 
	WHERE Site.FacilityTypeID = @FacilityTypeID
	AND StatusTypeID = 1 -- Active
	ORDER BY Contact.ContactName
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_SITE_SELECT_BY_FACILITY_TYPE] TO [db_sp_exec]
    AS [dbo];

