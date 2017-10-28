-- =============================================================================
-- Author:		Brian Cesafsky
-- Create date: 11/19/2009
-- Description:	Selects Pig Flows associated with a Farm
-- =============================================================================
/* 
===========================================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ ------------------------------------------------------------ 
06/05/2017	nhonetschlager	   Added FlowMgrContactID
===========================================================================================
*/
CREATE PROCEDURE [dbo].[cfp_PIG_FLOW_SELECT_BY_CONTACT_ID]
(
	@ContactID		int
)
AS
BEGIN
	SELECT cft_PIG_FLOW.PigFlowID
		 , cft_PIG_FLOW.PigFlowDescription
		 , cft_PIG_FLOW.PigFlowFromDate
		 , cft_PIG_FLOW.PigFlowToDate
		 , cft_PIG_FLOW.ReportingGroupID
		 , cft_PIG_FLOW.FlowMgrContactID									-- NJH 06/05/17
	FROM dbo.cft_PIG_FLOW cft_PIG_FLOW (NOLOCK)
	LEFT JOIN dbo.cft_PIG_FLOW_FARM cft_PIG_FLOW_FARM (NOLOCK)
		ON cft_PIG_FLOW_FARM.PigFlowID=cft_PIG_FLOW.PigFlowID  
	WHERE cft_PIG_FLOW_FARM.ContactID = @ContactID 
	ORDER BY cft_PIG_FLOW.PigFlowFromDate DESC
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_SELECT_BY_CONTACT_ID] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_SELECT_BY_CONTACT_ID] TO [db_sp_exec]
    AS [dbo];

