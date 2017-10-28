-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 04/28/2008
-- Description:	Inserts a record into cft_CORN_PRODUCER_FARM
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PRODUCER_FARM_INSERT]
(
		@CornProducerID				varchar(15)
		,@ContactID					int
		,@RoadRestrictionWeight		int
		,@Active					bit
		,@Comments					varchar(2000)
		,@CreatedBy					varchar(50)
)
AS
BEGIN
INSERT INTO [cft_CORN_PRODUCER_FARM]
(
		[CornProducerID]
	   ,[ContactID]
	   ,[RoadRestrictionWeight]
	   ,[Active]
	   ,[Comments]
	   ,[CreatedBy]
)
VALUES
(
		@CornProducerID
		,@ContactID
		,@RoadRestrictionWeight
		,@Active
		,@Comments
		,@CreatedBy
)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PRODUCER_FARM_INSERT] TO [db_sp_exec]
    AS [dbo];

