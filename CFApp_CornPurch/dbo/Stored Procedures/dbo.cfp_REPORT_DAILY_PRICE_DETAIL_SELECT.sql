


-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 10/09/2008
-- Description:	Selects DailyPriceDetail records for DailyPriceReport.
-- ===================================================================
/* 
======================================================================== 
Change Log: 
Date        Who           	   Change 
----------- ------------------ ----------------------------------------- 
2013-10-09  Nick Honetschlager Altered to grab new delivery date columns.                                                
========================================================================
*/
CREATE PROCEDURE [dbo].[cfp_REPORT_DAILY_PRICE_DETAIL_SELECT]
(
   @FeedMillID	char(10),
   @Date	datetime
)
AS
BEGIN
SET NOCOUNT ON;

SELECT RIGHT(FM.Name,1) AS OptionMonthName,
       DPD.DeliveryDate,
       DPD.CBOTCornClose,
       DPD.CBOTChange,
       DPD.CompetitorBasis,
       DPD.CompetitorFreight,
       DPD.Adj,
       DPD.NonClassicalTrade,
       DPD.NoBid,
       DPD.DeliveryDateFrom,		-- added 10/10/13 NJH
       DPD.DeliveryDateTo			-- added 10/10/13 NJH
FROM dbo.cft_DAILY_PRICE_DETAIL DPD
INNER JOIN dbo.cft_FINANCIAL_MONTH FM ON FM.FinancialMonthID = DPD.OptionMonth
INNER JOIN dbo.cft_DAILY_PRICE DP ON DP.DailyPriceID = DPD.DailyPriceID
WHERE DP.FeedMillID = @FeedMillID AND DP.Date = @Date
ORDER BY DPD.DeliveryDateFrom, DailyPriceDetailID

END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_DAILY_PRICE_DETAIL_SELECT] TO [db_sp_exec]
    AS [dbo];

