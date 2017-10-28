-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 11/05/2009
-- Description:	Updates a Pig Flow record
-- ============================================================
/* 
==============================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ -----------------------------------------------
06/05/2017	nhonetschlager	   Added FlowMgrContactID
==============================================================================
*/
CREATE PROCEDURE [dbo].[cfp_PIG_FLOW_UPDATE]
(
	 @PigFlowID [int] 
	,@PigFlowFromDate [datetime]
	,@PigFlowToDate [datetime]
	,@UpdatedBy [varchar](50) 
	,@ReportingGroupID [int] 
	,@FlowMgrContactID [int]								-- NJH 06/05/17
)
AS
BEGIN
	UPDATE dbo.cft_PIG_FLOW 
	SET PigFlowFromDate = @PigFlowFromDate
		,PigFlowToDate = @PigFlowToDate
		,UpdatedDateTime = getdate()
		,UpdatedBy = @UpdatedBy
		,ReportingGroupID = @ReportingGroupID
		,FlowMgrContactID = @FlowMgrContactID				-- NJH 06/05/17
	WHERE PigFlowID = @PigFlowID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_UPDATE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_UPDATE] TO [db_sp_exec]
    AS [dbo];

