



-- ===================================================================
-- Author:  Nick Honetschlager
-- Create date: 08/19/2013
-- Description: Deletes DailyPriceDetail and Competitor records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_DETAIL_DELETE]
(
    @DailyPriceDetailID	int
)

AS
BEGIN

SET NOCOUNT ON;

BEGIN TRAN

DELETE cft_DAILY_PRICE_DETAIL_COMPETITOR
WHERE DailyPriceDetailID = @DailyPriceDetailID

DELETE cft_DAILY_PRICE_DETAIL
WHERE DailyPriceDetailID = @DailyPriceDetailID

COMMIT TRAN

END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_DAILY_PRICE_DETAIL_DELETE] TO [db_sp_exec]
    AS [dbo];

