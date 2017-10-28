
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Creates new Promotion record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_PROMOTION_RATE_INSERT]
(
    @PromotionID	int	OUT,
    @FeedMillID	varchar(10),
    @Active	bit,
    @DateEstablishedFrom	datetime,
    @DateEstablishedTo	datetime,
    @DeliveryDateFrom	datetime,
    @DeliveryDateTo	datetime,
    @CreatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_PROMOTION_RATE
  (
      [FeedMillID],
      [Active],
      [DateEstablishedFrom],
      [DateEstablishedTo],
      [DeliveryDateFrom],
      [DeliveryDateTo],
      [CreatedBy]
  )
  VALUES
  (
      @FeedMillID,
      @Active,
      @DateEstablishedFrom,
      @DateEstablishedTo,
      @DeliveryDateFrom,
      @DeliveryDateTo,
      @CreatedBy
  )

  SELECT @PromotionID = PromotionID
  FROM dbo.cft_PROMOTION_RATE
  WHERE PromotionID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_PROMOTION_RATE_INSERT] TO [db_sp_exec]
    AS [dbo];

