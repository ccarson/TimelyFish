-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 01/18/2008
-- Description:	Selects a record from the table cftPMStatus
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKET_SCHEDULE_STATUS_SELECT]
(
	@SundayDate				smalldatetime,
	@PigSystemID			char(2),
	@StatusID				char(2),
	@MarketTypeID			char(2)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT PMStatusID
		   , PMTypeID
	FROM [$(SolomonApp)].dbo.cftPMWeekStatus (NOLOCK)
	where WeekOfDate = @SundayDate
	and PigSystemID = @PigSystemID
	and PMTypeID = @MarketTypeID
END






GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_SCHEDULE_STATUS_SELECT] TO [db_sp_exec]
    AS [dbo];

