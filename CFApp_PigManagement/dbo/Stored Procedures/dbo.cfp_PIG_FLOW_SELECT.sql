-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 11/04/2009
-- Description:	Selects Active Pig Flows
-- ============================================================
/* 
===========================================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ ------------------------------------------------------------ 
06/05/2017	nhonetschlager	   Added FlowMgrContactID
===========================================================================================
*/
CREATE PROCEDURE [dbo].[cfp_PIG_FLOW_SELECT]
(
    @Active		bit
)
AS
BEGIN
	IF @Active = 1
	BEGIN
		SELECT [PigFlowID]
			 , [PigFlowDescription]
			 , [PigFlowFromDate]
			 , [PigFlowToDate]
			 , [CreatedDateTime]
			 , [CreatedBy]
			 , [UpdatedDateTime]
			 , [UpdatedBy] 
			 , [ReportingGroupID]
			 , [FlowMgrContactID]										-- NJH 06/05/17
		FROM dbo.cft_PIG_FLOW (NOLOCK)
		WHERE PigFlowToDate IS NULL
			OR PigFlowToDate >= dateadd(d,-1,getdate())
		ORDER BY PigFlowDescription asc
	END
	ELSE
	BEGIN
		SELECT [PigFlowID]
			 , [PigFlowDescription]
			 , [PigFlowFromDate]
			 , [PigFlowToDate]
			 , [CreatedDateTime]
			 , [CreatedBy]
			 , [UpdatedDateTime]
			 , [UpdatedBy] 
			 , [ReportingGroupID]
			 , [FlowMgrContactID]										-- NJH 06/05/17
		FROM dbo.cft_PIG_FLOW (NOLOCK)
		WHERE PigFlowToDate IS NOT NULL
		and PigFlowToDate  <= dateadd(d,-1,getdate())
		ORDER BY PigFlowDescription asc
	END
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_SELECT] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_SELECT] TO [db_sp_exec]
    AS [dbo];

