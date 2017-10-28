
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/04/2008
-- Description:	Selects DailyPrice record by id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_SELECT_BY_ID]
(
    @DailyPriceID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT Date,
       FeedMillID,
       Approved,
       CreatedDateTime,
       CreatedBy,
       UpdatedDateTime,
       UpdatedBy
FROM dbo.cft_DAILY_PRICE
WHERE DailyPriceID = @DailyPriceID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

