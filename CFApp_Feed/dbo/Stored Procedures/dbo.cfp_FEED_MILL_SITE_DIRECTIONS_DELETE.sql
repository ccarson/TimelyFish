
-- ===================================================================
-- Author:	Matt Dawson
-- Create date: 11/13/2008
-- Description:	Deletes the Site Directions record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_FEED_MILL_SITE_DIRECTIONS_DELETE]
(
	@SiteDirectionsID int
)
AS
BEGIN
	SET NOCOUNT ON

	DELETE cft_FEED_MILL_SITE_DIRECTIONS
	WHERE SiteDirectionsID = @SiteDirectionsID


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FEED_MILL_SITE_DIRECTIONS_DELETE] TO [db_sp_exec]
    AS [dbo];

