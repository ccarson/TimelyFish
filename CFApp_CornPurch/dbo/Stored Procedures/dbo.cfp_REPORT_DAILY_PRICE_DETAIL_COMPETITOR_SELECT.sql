



-- =============================================================================
-- Author:	Andrew Derco
-- Create date: 10/09/2008
-- Description:	Selects DailyPriceDetailCompetitor records for DailyPriceReport.
-- =============================================================================
/* 
================================================================================ 
Change Log: 
Date        Who           	   Change 
----------- ------------------ ------------------------------------------------- 
2013-10-09  Nick Honetschlager Altered to grab new delivery date columns 
                               & changed to Order By DeliveryDateFrom   
2014-10-13  Nick Honetschlager Changed SELECT so competitor basis is correct.              
================================================================================
*/
CREATE PROCEDURE [dbo].[cfp_REPORT_DAILY_PRICE_DETAIL_COMPETITOR_SELECT]
(
   @FeedMillID	char(10),
   @Date	datetime
)
AS
BEGIN
SET NOCOUNT ON;

--Header
SELECT C.Name AS CompetitorName,
       C.CompetitorID, 
       0 AS DailyPriceDetailID,
       - ISNULL(DPD.CBOTCornClose,0) + ISNULL(DPDC.Price,0) AS Price,
       DPD.DeliveryDateFrom,																	--added 10-9-13 NJH
       DPD.DeliveryDateTo,																		--added 10-9-13 NJH
       1 SortOrder																				--added 10-9-13 NJH
FROM dbo.cft_COMPETITOR C
CROSS JOIN dbo.cft_DAILY_PRICE_DETAIL DPD
INNER JOIN dbo.cft_DAILY_PRICE DP ON DPD.DailyPriceID  = DP.DailyPriceID AND DP.FeedMillID = C.FeedMillID
INNER JOIN ( 
              SELECT TOP 1 DailyPriceDetailID													--added 10-13-14 NJH
              FROM dbo.cft_DAILY_PRICE_DETAIL _DPD
              INNER JOIN dbo.cft_DAILY_PRICE _DP ON _DP.DailyPriceID = _DPD.DailyPriceID
              WHERE _DP.FeedMillID = @FeedMillID AND _DP.Date = @Date
              ORDER BY DeliveryDateFrom															--added 10-13-14 NJH
           ) DPD1 ON DPD.DailyPriceDetailID = DPD1.DailyPriceDetailID
LEFT JOIN dbo.cft_DAILY_PRICE_DETAIL_COMPETITOR DPDC ON DPDC.CompetitorID = C.CompetitorID AND DPDC.DailyPriceDetailID = DPD.DailyPriceDetailID
WHERE C.ShowOnReport = 1 AND C.Inactive = 0 AND DP.FeedMillID = @FeedMillID AND DP.Date = @Date

UNION ALL

--Main part
SELECT C.Name AS CompetitorName,
       C.CompetitorID,
       DPD.DailyPriceDetailID,
       ISNULL(DPDC.Price,0),
       DPD.DeliveryDateFrom,																	--added 10-9-13 NJH
       DPD.DeliveryDateTo,																		--added 10-9-13 NJH
       2																						--added 10-9-13 NJH
FROM dbo.cft_COMPETITOR C
CROSS JOIN dbo.cft_DAILY_PRICE_DETAIL DPD
INNER JOIN dbo.cft_DAILY_PRICE DP ON DPD.DailyPriceID  = DP.DailyPriceID AND DP.FeedMillID = C.FeedMillID
LEFT JOIN dbo.cft_DAILY_PRICE_DETAIL_COMPETITOR DPDC ON DPDC.CompetitorID = C.CompetitorID AND DPDC.DailyPriceDetailID = DPD.DailyPriceDetailID
WHERE C.ShowOnReport = 1 AND C.Inactive = 0 AND DP.FeedMillID = @FeedMillID AND DP.Date = @Date

ORDER BY SortOrder, DPD.DeliveryDateFrom, DailyPriceDetailID, C.CompetitorID					--added 10-9-13 NJH


END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_DAILY_PRICE_DETAIL_COMPETITOR_SELECT] TO [db_sp_exec]
    AS [dbo];

