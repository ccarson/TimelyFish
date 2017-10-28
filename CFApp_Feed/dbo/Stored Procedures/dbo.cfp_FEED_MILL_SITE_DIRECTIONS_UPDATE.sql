
-- ===================================================================
-- Author:	Matt Dawson
-- Create date: 11/13/2008
-- Description:	Updates the Site Directions record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_FEED_MILL_SITE_DIRECTIONS_UPDATE]
(
	@SiteDirectionsID int
,	@ContactID int
,	@RoadRestrictions bit
,	@Active bit
,	@Directions varchar(4000)
,	@UpdatedBy varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON

	UPDATE cft_FEED_MILL_SITE_DIRECTIONS
	SET	ContactID = @ContactID
	,	RoadRestrictions = @RoadRestrictions
	,	Active = @Active
	,	Directions = @Directions
	,	UpdatedBy = @UpdatedBy
	,	UpdatedDateTime = GETDATE()
	WHERE SiteDirectionsID = @SiteDirectionsID


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FEED_MILL_SITE_DIRECTIONS_UPDATE] TO [db_sp_exec]
    AS [dbo];

