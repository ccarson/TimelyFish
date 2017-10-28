
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 11/05/2009
-- Description:	Creates new Pig Flow Farm record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_PIG_FLOW_FARM_INSERT
(
	@PigFlowFarmID						int		OUT,
	@PigFlowID							int,
	@ContactID							int,
	@CreatedBy							varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT dbo.cft_PIG_FLOW_FARM
	(
		PigFlowID
		,ContactID
		,CreatedBy
	) 
	VALUES 
	(
		@PigFlowID
		,@ContactID
		,@CreatedBy
	)
	set @PigFlowFarmID = @@identity
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_FARM_INSERT] TO [db_sp_exec]
    AS [dbo];

