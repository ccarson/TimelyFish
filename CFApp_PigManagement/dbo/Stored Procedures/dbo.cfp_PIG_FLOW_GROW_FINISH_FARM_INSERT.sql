

-- ======================================================================================================
-- Author:	Nick Honetschlager
-- Create date: 06/23/2017
-- Description:	Creates new Pig Flow Farm record and returns it's ID. Based on cfp_PIG_FLOW_FARM_INSERT
-- ======================================================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_FLOW_GROW_FINISH_FARM_INSERT]
(
	@PigFlowFarmID						int		OUT,
	@PigFlowFromDate					datetime,
	@PigFlowID							int,
	@ContactID							int,
	@CreatedBy							varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT dbo.cft_PIG_FLOW_FARM_GROW_FINISH
	(
		PigFlowID
		,PigFlowFromDate
		,ContactID
		,CreatedBy
	) 
	VALUES 
	(
		@PigFlowID
		,@PigFlowFromDate
		,@ContactID
		,@CreatedBy
	)
	set @PigFlowFarmID = @@identity
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_GROW_FINISH_FARM_INSERT] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_GROW_FINISH_FARM_INSERT] TO [db_sp_exec]
    AS [dbo];

