
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/15/2008
-- Description:	Selects DailyPrice record for DailyPriceReport.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_DAILY_PRICE_REPORT_DAILY_PRICE_SELECT]
(
   @DailyPriceID int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT DP.DailyPriceID, 
       DP.FeedMillID, 
       FM.Name AS FeedMillName, 
       DP.Date
FROM dbo.cft_DAILY_PRICE DP 
INNER JOIN dbo.cft_FEED_MILL FM ON FM.FeedMillID = DP.FeedMillID
WHERE DP.DailyPriceID = @DailyPriceID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DAILY_PRICE_REPORT_DAILY_PRICE_SELECT] TO [db_sp_exec]
    AS [dbo];

