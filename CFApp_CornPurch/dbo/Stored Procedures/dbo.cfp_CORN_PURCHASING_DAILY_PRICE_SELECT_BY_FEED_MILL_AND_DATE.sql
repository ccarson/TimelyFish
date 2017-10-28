
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/09/2008
-- Description:	Selects DailyPrice record by Feed Mill and Date
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_SELECT_BY_FEED_MILL_AND_DATE]
(
    @FeedMillID	char(10),
    @Date	datetime
)
AS
BEGIN
SET NOCOUNT ON;

SELECT DailyPriceID,
       Approved,
       CreatedDateTime,
       CreatedBy,
       UpdatedDateTime,
       UpdatedBy
FROM dbo.cft_DAILY_PRICE
WHERE FeedMillID = @FeedMIllID AND Date = @Date
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_SELECT_BY_FEED_MILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];

