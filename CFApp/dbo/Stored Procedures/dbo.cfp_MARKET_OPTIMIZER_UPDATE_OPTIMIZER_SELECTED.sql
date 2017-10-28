-- ===========================================================================
-- Author:		Brian Cesafsky
-- Create date: 09/28/2010
-- Description:	Updates the OptimizerSelected column in cft_MARKET_OPTIMIZER
-- ===========================================================================
CREATE PROCEDURE dbo.cfp_MARKET_OPTIMIZER_UPDATE_OPTIMIZER_SELECTED
(
		@LoadID						int
		,@CalculatingOptionID		int
		,@ContactID					int
		,@OptimizerSelected			bit
)
AS
BEGIN

	UPDATE dbo.cft_MARKET_OPTIMIZER
	SET OptimizerSelected = @OptimizerSelected
	WHERE LoadID = @LoadID
	AND CalculatingOptionID = @CalculatingOptionID
	AND ContactID = @ContactID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_OPTIMIZER_UPDATE_OPTIMIZER_SELECTED] TO [db_sp_exec]
    AS [dbo];

