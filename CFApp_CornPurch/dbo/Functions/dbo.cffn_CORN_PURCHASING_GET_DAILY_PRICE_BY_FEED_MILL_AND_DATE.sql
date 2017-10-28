
-- =============================================
-- Author:	Andrey Derco
-- Create date: 09/26/2008
-- Description:	Returns value from daily price for given feed mill and date
-- =============================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_GET_DAILY_PRICE_BY_FEED_MILL_AND_DATE]
(
    @FeedMillID		char(10),
    @Date		datetime,
    @DeliveryYear	int 		= NULL,
    @DeliveryMonth	int		= NULL,
    @OptionMonth	int		= NULL
)
RETURNS decimal(20,4)
AS
BEGIN

  DECLARE @Result decimal(18,4)
  SELECT @Result = DPD.Price
  FROM dbo.cft_DAILY_PRICE_DETAIL DPD 
  INNER JOIN ( SELECT TOP 1 DailyPriceID 
             FROM dbo.cft_DAILY_PRICE
             WHERE FeedMillID = @FeedMillID AND Date <= @Date AND Approved = 1
             ORDER BY Date DESC
           )  DP ON DP.DailyPriceID = DPD.DailyPriceID
  WHERE dbo.cffn_GET_FINANCIAL_MONTH_ID(DPD.DeliveryMonth) = COALESCE(dbo.cffn_GET_FINANCIAL_MONTH_ID(@DeliveryMonth), @OptionMonth, dbo.cffn_GET_FINANCIAL_MONTH_ID(month(@Date))) 
        AND DPD.DeliveryYear = ISNULL(@DeliveryYear, year(@Date))

  RETURN @Result
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GET_DAILY_PRICE_BY_FEED_MILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];

