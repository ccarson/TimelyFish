
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Updates the CommissionRate record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_STANDARD_RATE_UPDATE]
(
    @CommissionRateID	int,
    @CommissionRateTypeID	int,
    @FeedMillID	varchar(10),
    @EffectiveDateFrom	datetime,
    @EffectiveDateTo	datetime,
    @Active	bit,
    @UpdatedBy	varchar(50),
    @PromotionID	int
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_STANDARD_RATE SET
    [CommissionRateTypeID] = @CommissionRateTypeID,
    [FeedMillID] = @FeedMillID,
    [EffectiveDateFrom] = @EffectiveDateFrom,
    [EffectiveDateTo] = @EffectiveDateTo,
    [Active] = @Active,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate(),
    [PromotionID] = @PromotionID
  WHERE CommissionRateID = @CommissionRateID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_STANDARD_RATE_UPDATE] TO [db_sp_exec]
    AS [dbo];

