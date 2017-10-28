

-- ==================================================
-- Author:	mdawson
-- Create date: 11/5/2007
-- Description:	Deletes Sites associated with Load Crews
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_LOAD_CREW_SITES_DELETE]
(
	@LoadCrewID				int,
	@ContactID				int
)	
AS
BEGIN
	DELETE dbo.cft_LOAD_CREW_SITES
	WHERE	LoadCrewID = @LoadCrewID
	AND	ContactID = @ContactID
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_LOAD_CREW_SITES_DELETE] TO [db_sp_exec]
    AS [dbo];

