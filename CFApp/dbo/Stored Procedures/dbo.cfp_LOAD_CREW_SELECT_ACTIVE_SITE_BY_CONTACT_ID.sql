
-- =================================================
-- Author:	Brian Cesafsky
-- Create date: 10/15/2008
-- Description:	selects load crew site information
-- =================================================
CREATE PROCEDURE [dbo].[cfp_LOAD_CREW_SELECT_ACTIVE_SITE_BY_CONTACT_ID]
(
	@ContactID int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--	SELECT	LoadCrewSites.LoadCrewID
--			,LoadCrewSites.AssignedFromDate
--			,LoadCrewSites.AssignedToDate
--			,Contact.ContactID
--			,Contact.ContactName
--	FROM 		dbo.cft_LOAD_CREW_SITES LoadCrewSites (NOLOCK)
--	INNER JOIN	[$(CentralData)].dbo.Contact Contact (NOLOCK)
--		ON	Contact.ContactID = LoadCrewSites.ContactID
--	WHERE	LoadCrewSites.ContactID = @ContactID
	SELECT	LoadCrew.LoadCrewID
			,LoadCrew.LoadCrewName
			,LoadCrewSites.AssignedFromDate
			,LoadCrewSites.AssignedToDate
	FROM 		dbo.cft_LOAD_CREW LoadCrew (NOLOCK)
	INNER JOIN	dbo.cft_LOAD_CREW_SITES LoadCrewSites (NOLOCK)
		ON	LoadCrewSites.LoadCrewID = LoadCrew.LoadCrewID
	WHERE	LoadCrewSites.ContactID = @ContactID
	AND		(LoadCrewSites.AssignedToDate is null or LoadCrewSites.AssignedToDate >= getdate())
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_LOAD_CREW_SELECT_ACTIVE_SITE_BY_CONTACT_ID] TO [db_sp_exec]
    AS [dbo];

