
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Creates new GpaDeferredPayment record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_DEFERRED_PAYMENT_INSERT]
(
    @GPADeferredPaymentID	int	OUT,
    @FeedMillID	varchar(10),
    @Amount	decimal(14,6),
    @EffectiveDateFrom	datetime,
    @EffectiveDateTo	datetime,
    @Default	bit,
    @Active	bit,
    @CreatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_GPA_DEFERRED_PAYMENT
  (
      [FeedMillID],
      [Amount],
      [EffectiveDateFrom],
      [EffectiveDateTo],
      [Default],
      [Active],
      [CreatedBy]
  )
  VALUES
  (
      @FeedMillID,
      @Amount,
      @EffectiveDateFrom,
      @EffectiveDateTo,
      @Default,
      @Active,
      @CreatedBy
  )

  SELECT @GPADeferredPaymentID = GPADeferredPaymentID
  FROM dbo.cft_GPA_DEFERRED_PAYMENT
  WHERE GPADeferredPaymentID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_DEFERRED_PAYMENT_INSERT] TO [db_sp_exec]
    AS [dbo];

