
-- =============================================
-- Author:	Brian Cesafsky
-- Create date: 02/21/2008
-- Description:	selects load crew information by contactID
-- =============================================
CREATE PROCEDURE [dbo].[cfp_LOAD_CREW_SELECT_BY_CONTACTID]
(
	@ContactID int
	,@MovementDate Datetime
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT	
		LoadCrew.LoadCrewID,
		LoadCrew.LoadCrewName
	FROM  dbo.cft_LOAD_CREW LoadCrew (NOLOCK)
	INNER JOIN	dbo.cft_LOAD_CREW_SITES LoadCrewSites (NOLOCK)
		ON	LoadCrew.LoadCrewID = LoadCrewSites.LoadCrewID
	WHERE LoadCrewSites.ContactID = @ContactID
	AND @MovementDate between LoadCrewSites.AssignedFromDate and ISNULL(LoadCrewSites.AssignedToDate,'1/1/3000')
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_LOAD_CREW_SELECT_BY_CONTACTID] TO [db_sp_exec]
    AS [dbo];

