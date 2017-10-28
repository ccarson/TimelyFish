
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Creates new CommissionRateDetail record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_COMMISSION_RATE_DETAIL_INSERT
(
    @CommissionRateDetailID	int	OUT,
    @CommissionRateID	int,
    @RangeFrom	money,
    @RangeTo	money,
    @Value	decimal(20,6),
    @CreatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_COMMISSION_RATE_DETAIL
  (
      [CommissionRateID],
      [RangeFrom],
      [RangeTo],
      [Value],
      [CreatedBy]
  )
  VALUES
  (
      @CommissionRateID,
      @RangeFrom,
      @RangeTo,
      @Value,
      @CreatedBy
  )

  SELECT @CommissionRateDetailID = CommissionRateDetailID
  FROM dbo.cft_COMMISSION_RATE_DETAIL
  WHERE CommissionRateDetailID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMISSION_RATE_DETAIL_INSERT] TO [db_sp_exec]
    AS [dbo];

