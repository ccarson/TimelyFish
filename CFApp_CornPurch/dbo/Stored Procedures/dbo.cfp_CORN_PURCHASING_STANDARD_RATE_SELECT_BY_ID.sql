
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects CommissionRate record by id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_STANDARD_RATE_SELECT_BY_ID]
(
    @CommissionRateID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [CommissionRateTypeID],
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
WHERE CommissionRateID = @CommissionRateID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_STANDARD_RATE_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

