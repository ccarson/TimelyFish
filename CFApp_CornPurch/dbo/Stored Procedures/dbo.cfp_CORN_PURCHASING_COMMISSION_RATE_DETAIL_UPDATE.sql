
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Updates the CommissionRateDetail record.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_COMMISSION_RATE_DETAIL_UPDATE
(
    @CommissionRateDetailID	int,
    @CommissionRateID	int,
    @RangeFrom	money,
    @RangeTo	money,
    @Value	decimal(20,6),
    @UpdatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_COMMISSION_RATE_DETAIL SET
    [CommissionRateID] = @CommissionRateID,
    [RangeFrom] = @RangeFrom,
    [RangeTo] = @RangeTo,
    [Value] = @Value,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE CommissionRateDetailID = @CommissionRateDetailID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMISSION_RATE_DETAIL_UPDATE] TO [db_sp_exec]
    AS [dbo];

