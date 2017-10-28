
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects CommissionRate record by feed mill id
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_STANDARD_RATE_SELECT_BY_FEED_MILL
(
    @FeedMillID	char(10)
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [CommissionRateTypeID],
       [CommissionRateID],
       [EffectiveDateFrom],
       [EffectiveDateTo],
       [Active],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy],
       [PromotionID]
FROM dbo.cft_STANDARD_RATE
WHERE FeedMillID = @FeedMillID AND CommissionRateTypeID = 1
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_STANDARD_RATE_SELECT_BY_FEED_MILL] TO [db_sp_exec]
    AS [dbo];

