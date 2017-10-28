
-- ========================================================================
-- Author:  Brian Cesafsky
-- Create date: 08/26/2009
-- Description: Updates the CBOTCornClose and CBOTChange values in the DB.
-- ========================================================================
CREATE PROCEDURE dbo.cfp_DAILY_PRICE_CBOT_UPDATE
(
		@FeedMillID					varchar(10)
		,@DeliveryMonth				int
		,@DeliveryYear				int
		,@CBOTCornClose				decimal(20,4)
		,@CBOTChange				decimal(20,4)
)
AS
BEGIN


SET NOCOUNT ON;

DECLARE @DailyPriceDetailID int

--First get the MAX DailyPriceDetailID based on the Month, Year, and FeedMill
	SELECT @DailyPriceDetailID = max(DailyPriceDetailID)
	FROM dbo.cft_DAILY_PRICE_DETAIL cft_DAILY_PRICE_DETAIL
	LEFT JOIN dbo.cft_DAILY_PRICE cft_DAILY_PRICE 
		ON cft_DAILY_PRICE.DailyPriceID = cft_DAILY_PRICE_DETAIL.DailyPriceID
	WHERE DeliveryMonth = @DeliveryMonth  --get from XML
	AND DeliveryYear = @DeliveryYear --get from XML
	AND cft_DAILY_PRICE.FeedMillID = @FeedMillID


--Use the DailyPriceDetailID from the select statement above to update the values
	UPDATE dbo.cft_DAILY_PRICE_DETAIL
	SET CBOTCornClose = @CBOTCornClose 
	  , CBOTChange = @CBOTChange 
	WHERE DailyPriceDetailID = @DailyPriceDetailID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DAILY_PRICE_CBOT_UPDATE] TO [db_sp_exec]
    AS [dbo];

