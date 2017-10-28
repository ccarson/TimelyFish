
-- ======================================================================================================
-- Author:		Nick Honetschlager
-- Create date: 06/21/2017
-- Description:	Selects grow finish sites associated with a Pig Flow. Based on [cfp_PIG_FLOW_FARM_SELECT_BY_FLOW_ID]
-- ======================================================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_FLOW_FARM_GROW_FINISH_SELECT_BY_FLOW_ID]
(
	@PigFlowID		int
)
AS
BEGIN
	SELECT pff.PigFlowFarmID
		, pff.PigFlowID
		, pff.ContactID
		, c.ContactName
		, s.FacilityTypeID
	FROM dbo.cft_PIG_FLOW_FARM_GROW_FINISH pff (NOLOCK)
	LEFT JOIN [$(CentralData)].dbo.Contact c (NOLOCK) ON c.ContactID = pff.ContactID  
	LEFT JOIN [$(CentralData)].dbo.Site s (NOLOCK) ON c.ContactID = s.ContactID
	WHERE PigFlowID = @PigFlowID
	AND PigFlowToDate IS NULL
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_FARM_GROW_FINISH_SELECT_BY_FLOW_ID] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_FARM_GROW_FINISH_SELECT_BY_FLOW_ID] TO [db_sp_exec]
    AS [dbo];

