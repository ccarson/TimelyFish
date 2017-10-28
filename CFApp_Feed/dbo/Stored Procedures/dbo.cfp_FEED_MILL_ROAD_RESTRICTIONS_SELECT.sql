-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 11/24/2008
-- Description:	Selects the Road Restrictions On/Off flag.
-- =============================================
CREATE PROCEDURE [dbo].[cfp_FEED_MILL_ROAD_RESTRICTIONS_SELECT]
	@FeedMillID CHAR(10)
AS
BEGIN

SELECT  RoadRestrictions
FROM	dbo.cft_FEED_MILL_ROAD_RESTRICTIONS (NOLOCK)
WHERE	RTRIM(FeedMillID) = @FeedMillID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FEED_MILL_ROAD_RESTRICTIONS_SELECT] TO [db_sp_exec]
    AS [dbo];

