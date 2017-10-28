

-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 02/21/2008
-- Description:	Returns all Load Crew Sites by Load Crew ID
-- for a specific date.
-- 2012-08-27 sripley added nolock hints to the table references
-- =============================================
CREATE PROCEDURE [dbo].[cfp_LOAD_CREW_SITES_SELECT_BY_DATE]
(
	@MovementDate Datetime
	, @LoadCrewID int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	distinct
	pm.sourcecontactid,
	Contact.ContactName 
FROM 
	[$(SolomonApp)].dbo.cftPM pm WITH (nolock)
	inner join dbo.cft_LOAD_CREW_SITES LoadCrewSites WITH (nolock) on LoadCrewSites.contactid = pm.SourceContactID
	inner join [$(CentralData)].dbo.Contact Contact WITH (nolock) on Contact.ContactID = pm.SourceContactID
Where
	MovementDate = @MovementDate
	and (transubtypeid like '%M' or transubtypeid like '%T')
	and LoadCrewSites.LoadCrewID = @LoadCrewID
END






GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_LOAD_CREW_SITES_SELECT_BY_DATE] TO [db_sp_exec]
    AS [dbo];

