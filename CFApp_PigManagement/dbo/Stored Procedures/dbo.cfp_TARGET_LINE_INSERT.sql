-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 10/16/2009
-- Description:	Creates a Target Line record
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_TARGET_LINE_INSERT]
(	
	@TargetLineTypeID				int 
	,@TargetLineValue				decimal(10, 3)
	,@PICWeek						smallint
	,@PICYear						smallint
	,@PigFlowID						int 
	,@CreatedBy						varchar(50) 
)
AS
BEGIN
	INSERT INTO dbo.cft_TARGET_LINE
	(
		TargetLineTypeID
		,TargetLineValue
		,PICWeek
		,PICYear
		,PigFlowID
		,CreatedBy
	)
	VALUES 
	(
		@TargetLineTypeID
		,@TargetLineValue
		,@PICWeek
		,@PICYear
		,@PigFlowID
		,@CreatedBy
	)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TARGET_LINE_INSERT] TO [db_sp_exec]
    AS [dbo];

