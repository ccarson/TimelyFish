
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects Promotion record by feed mill id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_PROMOTION_RATE_SELECT_BY_FEED_MILL]
(
    @FeedMillID	char(10)
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [PromotionID],
       [Active],
       [DateEstablishedFrom],
       [DateEstablishedTo],
       [DeliveryDateFrom],
       [DeliveryDateTo],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_PROMOTION_RATE
WHERE FeedMillID = @FeedMillID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_PROMOTION_RATE_SELECT_BY_FEED_MILL] TO [db_sp_exec]
    AS [dbo];

