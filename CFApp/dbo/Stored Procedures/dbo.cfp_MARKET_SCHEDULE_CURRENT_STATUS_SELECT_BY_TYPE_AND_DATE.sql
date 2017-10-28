-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 01/18/2008
-- Description:	Selects current status of schedule
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKET_SCHEDULE_CURRENT_STATUS_SELECT_BY_TYPE_AND_DATE]
(
	@MarketTypeID			char(2),
	@MovementSundayDate		smalldatetime
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--current status
	SELECT top 1 cftPMStatus.PMStatusID,
				 cftPMStatus.Description
	FROM [$(SolomonApp)].dbo.cftPMWeekStatus cftPMWeekStatus (NOLOCK)
	JOIN [$(SolomonApp)].dbo.cftPMStatus cftPMStatus (NOLOCK) 
				on cftPMStatus.PMStatusID = cftPMWeekStatus.PMStatusID
				and cftPMStatus.PMTypeID = cftPMWeekStatus.PMTypeID
	WHERE WeekOfDate = @MovementSundayDate
	AND cftPMStatus.PMTypeID = @MarketTypeID
	ORDER BY cftPMWeekStatus.Lupd_DateTime DESC
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_SCHEDULE_CURRENT_STATUS_SELECT_BY_TYPE_AND_DATE] TO [db_sp_exec]
    AS [dbo];

