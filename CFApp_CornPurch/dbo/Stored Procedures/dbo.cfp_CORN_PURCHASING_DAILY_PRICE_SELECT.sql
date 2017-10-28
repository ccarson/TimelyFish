
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/04/2008
-- Description:	Selects all DailyPrice records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_SELECT]
AS
BEGIN
SET NOCOUNT ON;

SELECT DailyPriceID,
       Date,
       FeedMillID,
       Approved,
       CreatedDateTime,
       CreatedBy,
       UpdatedDateTime,
       UpdatedBy
FROM dbo.cft_DAILY_PRICE
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_SELECT] TO [db_sp_exec]
    AS [dbo];

