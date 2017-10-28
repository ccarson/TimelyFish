
-- =============================================================================
-- Author:	Nick Honetschlager
-- Create date: 10/12/2015
-- Description:	Based on cfp_REPORT_DAILY_PRICE_DETAIL_COMPETITOR_SELECT
-- =============================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_DAILY_PRICE_DETAIL_COMPETITOR_BASIS_SELECT]
(
   @FeedMillID	char(10),
   @Date	datetime
)
AS
BEGIN
SET NOCOUNT ON;

--Main part
SELECT C.Name AS CompetitorName,
       C.CompetitorID,
       DPD.DailyPriceDetailID,
       ISNULL(DPDC.Price,0) AS Price,
       DPD.DeliveryDateFrom,																	
       DPD.DeliveryDateTo,																		
       DPD.CBOTCornClose																					
FROM dbo.cft_COMPETITOR C
CROSS JOIN dbo.cft_DAILY_PRICE_DETAIL DPD
INNER JOIN dbo.cft_DAILY_PRICE DP ON DPD.DailyPriceID  = DP.DailyPriceID AND DP.FeedMillID = C.FeedMillID
LEFT JOIN dbo.cft_DAILY_PRICE_DETAIL_COMPETITOR DPDC ON DPDC.CompetitorID = C.CompetitorID AND DPDC.DailyPriceDetailID = DPD.DailyPriceDetailID
WHERE C.ShowOnReport = 1 AND C.Inactive = 0 AND DP.FeedMillID = @FeedMillID AND DP.Date = @Date

ORDER BY DPD.DeliveryDateFrom, DPD.DailyPriceDetailID, C.CompetitorID					


END




