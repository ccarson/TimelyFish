-- =============================================================================
-- Author:		Brian Cesafsky
-- Create date: 11/05/2009
-- Description:	Selects Farms associated with a Pig Flow
-- =============================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_FLOW_FARM_SELECT_BY_FLOW_ID]
(
	@PigFlowID		int
)
AS
BEGIN
	SELECT cft_PIG_FLOW_FARM.PigFlowFarmID
		, cft_PIG_FLOW_FARM.PigFlowID
		, cft_PIG_FLOW_FARM.ContactID
		, Contact.ContactName
	FROM dbo.cft_PIG_FLOW_FARM cft_PIG_FLOW_FARM (NOLOCK)
	LEFT JOIN [$(CentralData)].dbo.Contact Contact (NOLOCK)
		ON Contact.ContactID=cft_PIG_FLOW_FARM.ContactID  
	WHERE PigFlowID = @PigFlowID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_FARM_SELECT_BY_FLOW_ID] TO [db_sp_exec]
    AS [dbo];

