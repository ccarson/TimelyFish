
-- ===================================================================
-- Author:	Sergey Neskin
-- Create date: 04/08/2008
-- Description:	Selects CommissionRate record by promotion identifier
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_COMMISSION_RATE_SELECT_BY_PROMOTION]
(
    @PromotionID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [CommissionRateTypeID],
	   [FeedMillID],
       [CommissionRateID],
       [EffectiveDateFrom],
       [EffectiveDateTo],
       [PromotionID],
       [Active],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_COMMISSION_RATE
WHERE Promotionid = @PromotionID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMISSION_RATE_SELECT_BY_PROMOTION] TO [db_sp_exec]
    AS [dbo];

