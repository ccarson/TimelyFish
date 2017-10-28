
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Updates the GpaHandlingCharge record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_HANDLING_CHARGE_UPDATE]
(
    @GPAHandlingChargeID	int,
    @FeedMillID	varchar(10),
    @HandlingCharge	decimal(14,6),
    @EffectiveDateFrom	datetime,
    @EffectiveDateTo	datetime,
    @FreeDelayedPricingLength	int,
    @ChargesBeginDate	datetime,
    @Default	bit,
    @Active	bit,
    @UpdatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_GPA_HANDLING_CHARGE SET
    [FeedMillID] = @FeedMillID,
    [HandlingCharge] = @HandlingCharge,
    [EffectiveDateFrom] = @EffectiveDateFrom,
    [EffectiveDateTo] = @EffectiveDateTo,
    [FreeDelayedPricingLength] = @FreeDelayedPricingLength,
    [ChargesBeginDate] = @ChargesBeginDate,
    [Default] = @Default,
    [Active] = @Active,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE GPAHandlingChargeID = @GPAHandlingChargeID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_HANDLING_CHARGE_UPDATE] TO [db_sp_exec]
    AS [dbo];

