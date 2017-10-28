-- ========================================================
-- Author:		Brian Cesafsky
-- Create date: 12/26/2007
-- Description:	Deletes matching records by movement date
-- ========================================================
CREATE PROCEDURE [dbo].[cfp_MARKET_OPTIMIZER_DELETE]
(
	@MovementStartDate			SmallDateTime,
	@MovementEndDate			SmallDateTime,
	@CalculatingOptionID		int
)
AS
BEGIN

	DELETE FROM dbo.cft_MARKET_OPTIMIZER
	WHERE MovementDate between @MovementStartDate and @MovementEndDate
	AND CalculatingOptionID = @CalculatingOptionID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_OPTIMIZER_DELETE] TO [db_sp_exec]
    AS [dbo];

