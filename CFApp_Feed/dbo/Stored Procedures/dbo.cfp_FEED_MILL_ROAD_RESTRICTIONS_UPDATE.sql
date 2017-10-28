
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 11/24/2008
-- Description:	Updates the Road Restrictions On/Off flag.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_FEED_MILL_ROAD_RESTRICTIONS_UPDATE]
(
	@FeedMillID			char(10)
   ,@RoadRestrictions	bit
   ,@UpdatedBy			varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON

	UPDATE cft_FEED_MILL_ROAD_RESTRICTIONS
	SET	RoadRestrictions = @RoadRestrictions
		,UpdatedBy = @UpdatedBy
		,UpdatedDateTime = GETDATE()
	WHERE FeedMillID = @FeedMillID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FEED_MILL_ROAD_RESTRICTIONS_UPDATE] TO [db_sp_exec]
    AS [dbo];

