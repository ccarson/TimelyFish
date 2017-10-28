
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Updates the Promotion record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_PROMOTION_UPDATE]
(
    @PromotionID	int,
    @FeedMillID	varchar(10),
    @Active	bit,
    @DateEstablishedFrom	datetime,
    @DateEstablishedTo	datetime,
    @DeliveryDateFrom	datetime,
    @DeliveryDateTo	datetime,
    @UpdatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_PROMOTION SET
    [FeedMillID] = @FeedMillID,
    [Active] = @Active,
    [DateEstablishedFrom] = @DateEstablishedFrom,
    [DateEstablishedTo] = @DateEstablishedTo,
    [DeliveryDateFrom] = @DeliveryDateFrom,
    [DeliveryDateTo] = @DeliveryDateTo,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE PromotionID = @PromotionID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_PROMOTION_UPDATE] TO [db_sp_exec]
    AS [dbo];

