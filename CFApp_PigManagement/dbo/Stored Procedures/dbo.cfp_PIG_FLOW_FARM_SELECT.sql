

-- =============================================================================
-- Author:		Brian Cesafsky
-- Create date: 11/05/2009
-- Description:	Selects Active OR Inactive Farms associated with a Pig Flow(s)3
-- =============================================================================
-- Update 		
-- Author:		Nick Honetschlager
-- Date:		09/04/2015
-- Description:	Changed Left Join to Inner Join to avoid null PigFlowIDs.
-- =============================================================================
-- Update 		
-- Author:		Nick Honetschlager
-- Date:		06/24/2017
-- Description:	Added union for bringing in grow-finish flow farms
-- =============================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_FLOW_FARM_SELECT]
(
	  @Active			bit
    , @ContactID		int
)
AS
BEGIN
	IF @Active = 1
	BEGIN
		SELECT cft_PIG_FLOW.PigFlowID
			, cft_PIG_FLOW.PigFlowDescription
			, cft_PIG_FLOW.PigFlowFromDate 
			, cft_PIG_FLOW.PigFlowToDate 
			, Contact.ContactName
		FROM dbo.cft_PIG_FLOW_FARM cft_PIG_FLOW_FARM (NOLOCK)
		INNER JOIN dbo.cft_PIG_FLOW cft_PIG_FLOW (NOLOCK)						-- 09/04/2015 NJH
			ON cft_PIG_FLOW.PigFlowID=cft_PIG_FLOW_FARM.PigFlowID
		LEFT JOIN [$(CentralData)].dbo.Contact Contact (NOLOCK)
			ON Contact.ContactID=cft_PIG_FLOW_FARM.ContactID  
		WHERE cft_PIG_FLOW_FARM.ContactID = @ContactID
		AND cft_PIG_FLOW.PigFlowToDate IS NULL

		UNION

		SELECT cft_PIG_FLOW.PigFlowID
			, cft_PIG_FLOW.PigFlowDescription
			, cft_PIG_FLOW.PigFlowFromDate 
			, cft_PIG_FLOW.PigFlowToDate 
			, Contact.ContactName
		FROM dbo.cft_PIG_FLOW_FARM_GROW_FINISH cft_PIG_FLOW_FARM_GROW_FINISH (NOLOCK)
		INNER JOIN dbo.cft_PIG_FLOW cft_PIG_FLOW (NOLOCK)						-- 09/04/2015 NJH
			ON cft_PIG_FLOW.PigFlowID=cft_PIG_FLOW_FARM_GROW_FINISH.PigFlowID
		LEFT JOIN [$(CentralData)].dbo.Contact Contact (NOLOCK)
			ON Contact.ContactID=cft_PIG_FLOW_FARM_GROW_FINISH.ContactID  
		WHERE cft_PIG_FLOW_FARM_GROW_FINISH.ContactID = @ContactID
		AND cft_PIG_FLOW.PigFlowToDate IS NULL
		AND cft_PIG_FLOW_FARM_GROW_FINISH.PigFlowToDate IS NULL
	END
	ELSE
	BEGIN
		SELECT cft_PIG_FLOW.PigFlowID
			, cft_PIG_FLOW.PigFlowDescription
			, cft_PIG_FLOW.PigFlowFromDate 
			, cft_PIG_FLOW.PigFlowToDate 
			, Contact.ContactName
		FROM dbo.cft_PIG_FLOW_FARM cft_PIG_FLOW_FARM (NOLOCK)
		LEFT JOIN dbo.cft_PIG_FLOW cft_PIG_FLOW (NOLOCK)
			ON cft_PIG_FLOW.PigFlowID=cft_PIG_FLOW_FARM.PigFlowID 
		LEFT JOIN [$(CentralData)].dbo.Contact Contact (NOLOCK)
			ON Contact.ContactID=cft_PIG_FLOW_FARM.ContactID 
		WHERE cft_PIG_FLOW_FARM.ContactID = @ContactID
		AND cft_PIG_FLOW.PigFlowToDate IS NOT NULL

		UNION

		SELECT cft_PIG_FLOW.PigFlowID
			, cft_PIG_FLOW.PigFlowDescription
			, cft_PIG_FLOW.PigFlowFromDate 
			, cft_PIG_FLOW.PigFlowToDate 
			, Contact.ContactName
		FROM dbo.cft_PIG_FLOW_FARM_GROW_FINISH cft_PIG_FLOW_FARM_GROW_FINISH (NOLOCK)
		LEFT JOIN dbo.cft_PIG_FLOW cft_PIG_FLOW (NOLOCK)
			ON cft_PIG_FLOW.PigFlowID=cft_PIG_FLOW_FARM_GROW_FINISH.PigFlowID 
		LEFT JOIN [$(CentralData)].dbo.Contact Contact (NOLOCK)
			ON Contact.ContactID=cft_PIG_FLOW_FARM_GROW_FINISH.ContactID 
		WHERE cft_PIG_FLOW_FARM_GROW_FINISH.ContactID = @ContactID
		AND cft_PIG_FLOW.PigFlowToDate IS NOT NULL
		AND cft_PIG_FLOW_FARM_GROW_FINISH.PigFlowToDate IS NOT NULL
		ORDER BY cft_PIG_FLOW.PigFlowFromDate DESC
	END
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_FARM_SELECT] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_FARM_SELECT] TO [db_sp_exec]
    AS [dbo];

