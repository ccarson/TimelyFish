


-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/15/2008
-- Description:	Selects DailyPriceDetail records for DailyPriceReport.
-- ===================================================================
/* 
======================================================================== 
Change Log: 
Date        Who           	   Change 
----------- ------------------ ----------------------------------------- 
2013-10-09  Nick Honetschlager Altered to grab new delivery date columns 
                               & changed to Order By DeliveryDateFrom                 
========================================================================
*/
CREATE PROCEDURE [dbo].[cfp_DAILY_PRICE_REPORT_DAILY_PRICE_DETAIL_SELECT]
(
   @DailyPriceID int
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
       DPD.DeliveryDateFrom,					--added 10-9-13 NJH
       DPD.DeliveryDateTo						--added 10-9-13 NJH
FROM dbo.cft_DAILY_PRICE_DETAIL DPD
INNER JOIN dbo.cft_FINANCIAL_MONTH FM ON FM.FinancialMonthID = DPD.OptionMonth
WHERE DailyPriceID = @DailyPriceID
ORDER BY DeliveryDateFrom, DailyPriceDetailID	--added 10-9-13 NJH

END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DAILY_PRICE_REPORT_DAILY_PRICE_DETAIL_SELECT] TO [db_sp_exec]
    AS [dbo];

