
-- ===================================================================
-- Author:	Sergey Neskin
-- Create date: 04/08/2008
-- Description:	Selects CommissionRateDetail records by promotion identifier
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_STANDARD_RATE_SELECT_BY_PROMOTION]
(
    @PromotionID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [CommissionRateID],
       [CommissionRateTypeID],
       [FeedMillID],
       [EffectiveDateFrom],
       [EffectiveDateTo],
       [Active],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy],
       [PromotionID]
FROM dbo.cft_STANDARD_RATE
WHERE PromotionID = @PromotionID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_STANDARD_RATE_SELECT_BY_PROMOTION] TO [db_sp_exec]
    AS [dbo];

