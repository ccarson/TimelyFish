
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Updates the GpaDeferredPayment record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_DEFERRED_PAYMENT_UPDATE]
(
    @GPADeferredPaymentID	int,
    @FeedMillID	varchar(10),
    @Amount	decimal(14,6),
    @EffectiveDateFrom	datetime,
    @EffectiveDateTo	datetime,
    @Default	bit,
    @Active	bit,
    @UpdatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_GPA_DEFERRED_PAYMENT SET
    [FeedMillID] = @FeedMillID,
    [Amount] = @Amount,
    [EffectiveDateFrom] = @EffectiveDateFrom,
    [EffectiveDateTo] = @EffectiveDateTo,
    [Default] = @Default,
    [Active] = @Active,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE GPADeferredPaymentID = @GPADeferredPaymentID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_DEFERRED_PAYMENT_UPDATE] TO [db_sp_exec]
    AS [dbo];

