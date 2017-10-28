-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 10/16/2009
-- Description:	Updates an Target Line record
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_TARGET_LINE_UPDATE]
(
	@TargetLineID					int 
	,@TargetLineTypeID				int 
	,@TargetLineValue				decimal(10, 3)
	,@PICWeek						smallint
	,@PICYear						smallint
	,@PigFlowID						int 
	,@UpdatedBy						varchar(50) 
)
AS
BEGIN
	UPDATE dbo.cft_TARGET_LINE
	SET TargetLineTypeID = @TargetLineTypeID
		,TargetLineValue = @TargetLineValue
		,PICWeek = @PICWeek
		,PICYear = @PICYear
		,PigFlowID = @PigFlowID
		,UpdatedDateTime = getdate()
		,UpdatedBy = @UpdatedBy
	WHERE TargetLineID = @TargetLineID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TARGET_LINE_UPDATE] TO [db_sp_exec]
    AS [dbo];

