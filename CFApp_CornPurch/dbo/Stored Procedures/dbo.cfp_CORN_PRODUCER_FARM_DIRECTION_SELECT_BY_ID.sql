-- ======================================================================
-- Author:		Brian Cesafsky
-- Create date: 05/08/2008
-- Description:	Returns all directions to and from a farm to a feed mill
-- ======================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PRODUCER_FARM_DIRECTION_SELECT_BY_ID]
(
	@CornProducerFarmID		int
	,@FeedMillID			char(10)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT CornProducerFarmDirections.CornProducerFarmDirectionID
	    ,CornProducerFarmDirections.CornProducerFarmID
		,CornProducerFarmDirections.FeedMillID
		,CornProducerFarmDirections.DirectionToFeedMill
		,CornProducerFarmDirections.DirectionFromFeedMill
FROM dbo.cft_CORN_PRODUCER_FARM_DIRECTIONS  CornProducerFarmDirections
	LEFT JOIN dbo.cft_FEED_MILL FeedMill ON FeedMill.FeedMillID = CornProducerFarmDirections.FeedMillID
WHERE CornProducerFarmDirections.CornProducerFarmID = @CornProducerFarmID
	AND CornProducerFarmDirections.FeedMillID = @FeedMillID
Order By FeedMill.Name
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PRODUCER_FARM_DIRECTION_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

