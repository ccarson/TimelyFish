
-- =============================================
-- Author:	mdawson
-- Create date: 11/12/2007
-- Description:	selects load crew information
-- =============================================
CREATE PROCEDURE [dbo].[cfp_LOAD_CREW_SELECT]	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT	
		LoadCrewID,
		LoadCrewName
	FROM 	dbo.cft_LOAD_CREW (nolock)
	ORDER BY 
		LoadCrewName
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_LOAD_CREW_SELECT] TO [db_sp_exec]
    AS [dbo];

