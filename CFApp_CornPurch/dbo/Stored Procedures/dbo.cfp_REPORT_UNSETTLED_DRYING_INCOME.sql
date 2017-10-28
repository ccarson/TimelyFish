-- =============================================
-- Author:		Sergey Neskin
-- Create date: 09/15/2008
-- Description:	Select data for Unsettled Drying Income Report
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_UNSETTLED_DRYING_INCOME]
	@FeedMillID char(10),
	@StartDate datetime,
	@EndDate datetime
AS
BEGIN
  SET NOCOUNT ON;

SELECT FM.Name AS FeedMill,
       ---SUM(DCD.Value) AS Value
       SUM(PT.DryBushels * ISNULL(PT.DryingRateAdj, dbo.cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_BY_DATE_AND_RANGE(PT.DeliveryDate, CT.Moisture, @FeedMillID))) AS Value
FROM dbo.cft_FEED_MILL FM 
INNER JOIN dbo.cft_CORN_TICKET CT ON CT.FeedMillID = FM.FeedMillID
INNER JOIN dbo.cft_PARTIAL_TICKET PT ON PT.FullTicketID = CT.TicketID
WHERE PT.SentToAccountsPayable = 0
      AND FM.FeedMillID = @FeedMillID
      AND PT.DeliveryDate BETWEEN @StartDate AND @EndDate
GROUP BY FM.Name
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_UNSETTLED_DRYING_INCOME] TO [db_sp_exec]
    AS [dbo];

