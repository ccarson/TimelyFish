
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 11/05/2009
-- Description:	Creates new Pig Flow record and returns it's ID.
-- ===================================================================
/* 
==============================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ -----------------------------------------------
06/05/2017	nhonetschlager	   Added FlowMgrContactID
==============================================================================
*/
CREATE PROCEDURE dbo.cfp_PIG_FLOW_INSERT
(
	@PigFlowID							int		OUT,
	@PigFlowDescription					varchar(100),
	@PigFlowFromDate					smalldatetime,
	@CreatedBy							varchar(50),
	@ReportingGroupID							int,
	@FlowMgrContactID							int			  -- NJH 06/05/17
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT dbo.cft_PIG_FLOW
	(
		PigFlowDescription	
		,PigFlowFromDate
		,CreatedBy
		,ReportingGroupID
		,FlowMgrContactID
	) 
	VALUES 
	(
		@PigFlowDescription
		,@PigFlowFromDate
		,@CreatedBy
		,@ReportingGroupID
		,@FlowMgrContactID									-- NJH 06/05/17
	)
	set @PigFlowID = @@identity
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_INSERT] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_INSERT] TO [db_sp_exec]
    AS [dbo];

