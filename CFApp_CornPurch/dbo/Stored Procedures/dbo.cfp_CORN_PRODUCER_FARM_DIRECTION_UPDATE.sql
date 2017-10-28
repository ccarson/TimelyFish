-- ====================================================================
-- Author:		Brian Cesafsky
-- Create date: 04/03/2008
-- Description:	Updates a record in cft_CORN_PRODUCER_FARM_DIRECTIONS
-- ====================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PRODUCER_FARM_DIRECTION_UPDATE]
(
		@CornProducerFarmDirectionID	int
		,@CornProducerFarmID			int
		,@FeedMillID					char(10)
		,@DirectionToFeedMill			varchar(3500)
		,@DirectionFromFeedMill			varchar(3500)
		,@UpdatedBy						varchar(50)
)
AS
BEGIN

UPDATE dbo.cft_CORN_PRODUCER_FARM_DIRECTIONS
   SET [DirectionToFeedMill] = @DirectionToFeedMill
		,[DirectionFromFeedMill] = @DirectionFromFeedMill
		,[UpdatedBy] = @UpdatedBy

 WHERE 
	[CornProducerFarmDirectionID] = @CornProducerFarmDirectionID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PRODUCER_FARM_DIRECTION_UPDATE] TO [db_sp_exec]
    AS [dbo];

