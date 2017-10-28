-- ======================================================================
-- Author:		Brian Cesafsky
-- Create date: 05/08/2008
-- Description:	Inserts a record into cft_CORN_PRODUCER_FARM_DIRECTIONS
-- ======================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PRODUCER_FARM_DIRECTION_INSERT]
(
		@CornProducerFarmID			int
		,@FeedMillID				char(10)
		,@DirectionToFeedMill		varchar(3500)
		,@DirectionFromFeedMill		varchar(3500)
		,@CreatedBy					varchar(50)
)
AS
BEGIN
INSERT INTO cft_CORN_PRODUCER_FARM_DIRECTIONS
(
		[CornProducerFarmID]
	   ,[FeedMillID]
	   ,[DirectionToFeedMill]
	   ,[DirectionFromFeedMill]
	   ,[CreatedBy]
)
VALUES
(
		@CornProducerFarmID
		,@FeedMillID
		,@DirectionToFeedMill
		,@DirectionFromFeedMill
		,@CreatedBy
)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PRODUCER_FARM_DIRECTION_INSERT] TO [db_sp_exec]
    AS [dbo];

