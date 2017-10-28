

-- ============================================================
-- Author:		Nick Honetschlager
-- Create date: 06/24/2017
-- Description:	Updates all end dates for a particular flow
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_PIG_FLOW_GROW_FINISH_FARM_UPDATE_BY_FLOW_ID]
(
	@PigFlowToDate [datetime]
	,@PigFlowID [int] 
	,@UpdatedBy [varchar](50) 
)
AS
BEGIN
	UPDATE dbo.cft_PIG_FLOW_FARM_GROW_FINISH
	SET PigFlowToDate = @PigFlowToDate
		,UpdatedDateTime = getdate()
		,UpdatedBy = @UpdatedBy
	WHERE PigFlowID = @PigFlowID
	AND PigFlowToDate IS NULL
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_GROW_FINISH_FARM_UPDATE_BY_FLOW_ID] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_GROW_FINISH_FARM_UPDATE_BY_FLOW_ID] TO [db_sp_exec]
    AS [dbo];

