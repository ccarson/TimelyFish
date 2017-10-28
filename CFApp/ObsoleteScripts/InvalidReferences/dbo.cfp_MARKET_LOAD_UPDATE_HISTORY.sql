-- ========================================================================
-- Author:		<Brian Cesafsky>
-- Create date: <02/26/2008>
-- Description:	<Updates cft_PM_HISTORY records based on date/time range>
-- ========================================================================
CREATE PROCEDURE [dbo].[cfp_MARKET_LOAD_UPDATE_HISTORY]
(
      @FromDate                     smalldatetime,
      @ThroughDate                  smalldatetime,
      @CheckDate                    datetime
)
AS
BEGIN
      UPDATE cft_PM_HISTORY
      SET 
            SentChanges = 1
      FROM dbo.cft_PM_HISTORY cft_PM_HISTORY
      INNER JOIN dbo.cftPM cftPM
            ON cftPM.PMLoadID = cft_PM_HISTORY.PMLoadID
            AND cftPM.PMID = cft_PM_HISTORY.PMID
      WHERE cftPM.MovementDate BETWEEN @FromDate AND @ThroughDate
      AND cft_PM_HISTORY.CreatedDateTime >= @CheckDate
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_LOAD_UPDATE_HISTORY] TO [db_sp_exec]
    AS [dbo];

