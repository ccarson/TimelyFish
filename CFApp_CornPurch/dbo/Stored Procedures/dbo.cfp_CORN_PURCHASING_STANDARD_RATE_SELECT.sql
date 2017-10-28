
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects all CommissionRate records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_STANDARD_RATE_SELECT]
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
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_STANDARD_RATE_SELECT] TO [db_sp_exec]
    AS [dbo];

