
-- =============================================
-- Author:	mdawson
-- Create date: 11/12/2007
-- Description:	selects load crew information
-- =============================================
CREATE PROCEDURE [dbo].[cfp_LOAD_CREW_SITES_SELECT_BY_CREW_ID]
(
	@LoadCrewID int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT	LoadCrewSites.AssignedFromDate
			,LoadCrewSites.AssignedToDate
			,Contact.ContactID
			,Contact.ContactName
	FROM 		dbo.cft_LOAD_CREW_SITES LoadCrewSites (NOLOCK)
	INNER JOIN	[$(CentralData)].dbo.Contact Contact (NOLOCK)
		ON	Contact.ContactID = LoadCrewSites.ContactID
	WHERE	LoadCrewSites.LoadCrewID = @LoadCrewID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_LOAD_CREW_SITES_SELECT_BY_CREW_ID] TO [db_sp_exec]
    AS [dbo];

