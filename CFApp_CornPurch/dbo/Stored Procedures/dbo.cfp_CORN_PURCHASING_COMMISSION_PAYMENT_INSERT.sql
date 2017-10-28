
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 11/232/2008
-- Description:	Inserts commission payment record.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_COMMISSION_PAYMENT_INSERT
(
    @PartialTicketID		int,
    @CommissionRateTypeID	int,
    @CommissionRate			decimal(20,6),
    @CreatedBy			varchar(50),
    @MarketerID			tinyint,
    @MarketerPercent			decimal(18,4),
    @MarketerDryBushels		decimal(20,6)
)
AS
BEGIN
SET NOCOUNT ON;

  INSERT dbo.cft_COMMISSION_PAYMENT
  (
      [PartialTicketID],
      [CommissionRateTypeID],
      [CommissionRate],
      [CreatedBy],
      [MarketerID],
      [MarketerPercent],
      [MarketerDryBushels],
      [CornProducerID],
      [TicketNumber],
      [TotalCommissionPayment],
      [FeedMillID],
      [DeliveryDate],
      [ContractNumber]

  )

  SELECT
      @PartialTicketID,
      @CommissionRateTypeID,
      @CommissionRate,
      @CreatedBy,
      @MarketerID,
      @MarketerPercent,
      @MarketerDryBushels,
      ISNULL(PT.DeliveryCornProducerID,PT.CornProducerID),
      PT.TicketNumber,
      @MarketerDryBushels * @MarketerPercent / 100,
      FT.FeedMillID,
      FT.DeliveryDate,
      C.ContractNumber
  FROM dbo.cft_PARTIAL_TICKET PT
  INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
  LEFT OUTER JOIN dbo.cft_CONTRACT C ON C.ContractID = PT.ContractID
  WHERE PT.PartialTicketID = @PartialTicketID

 


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMISSION_PAYMENT_INSERT] TO [db_sp_exec]
    AS [dbo];

