-- ===============================================================
-- Author:		Brian Cesafsky
-- Create date: 04/28/2008
-- Description:	Updates a record in cft_CORN_PRODUCER_FARM
-- ===============================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PRODUCER_FARM_UPDATE]
(
		@CornProducerFarmID		int
		,@RoadRestrictionWeight		int
		,@Active					bit
		,@Comments					varchar(2000)
		,@UpdatedBy					varchar(50)
)
AS
BEGIN

UPDATE dbo.cft_CORN_PRODUCER_FARM
   SET [RoadRestrictionWeight] = @RoadRestrictionWeight
		,[Active] = @Active
		,[Comments] = @Comments
		,[UpdatedBy] = @UpdatedBy

 WHERE 
	[CornProducerFarmID] = @CornProducerFarmID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PRODUCER_FARM_UPDATE] TO [db_sp_exec]
    AS [dbo];

