
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 06/26/2008
-- Description: Selects DailyPriceDetail record by feed mill id and date
-- UPDATE: Only retrieve rows within custom delivery date range - nhonetschlager 2/4/14
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_DETAIL_SELECT_BY_FEED_MILL_AND_DATE]
(
    @FeedMillID	char(10),
    @Date	datetime
)
AS
BEGIN
SET NOCOUNT ON;

SELECT DPD.[DailyPriceDetailID],
       DPD.[DailyPriceID],
       DPD.[DeliveryMonth],
       DPD.[DeliveryYear],
       DPD.[OptionMonth],
       DPD.[NonClassicalTrade],
       DPD.[CBOTCornClose],
       DPD.[CBOTChange],
       DPD.[CompetitorBasis],
       DPD.[CompetitorFreight],
       DPD.[Adj],
       DPD.[NoBid],
       DPD.[DeliveryDate],
       DPD.[CreatedDateTime],
       DPD.[CreatedBy],
       DPD.[UpdatedDateTime],
       DPD.[UpdatedBy]
FROM dbo.cft_DAILY_PRICE_DETAIL DPD
INNER JOIN ( SELECT TOP 1 DailyPriceID 
             FROM dbo.cft_DAILY_PRICE
             WHERE FeedMillID = @FeedMillID AND Date <= @Date AND Approved = 1
             ORDER BY Date DESC
           )  DP ON DP.DailyPriceID = DPD.DailyPriceID
WHERE DPD.DeliveryMonth = month(@Date) 
AND DPD.DeliveryYear = year(@Date)
AND DAY(@Date) >= DAY(DPD.DeliveryDateFrom)		--added 2/4/14
AND DAY(@Date) <= DAY(DPD.DeliveryDateTo)		--added 2/4/14
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_DETAIL_SELECT_BY_FEED_MILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];

