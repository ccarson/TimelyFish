
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Updates the GpaDryingChargeDetail record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_DRYING_CHARGE_DETAIL_UPDATE]
(
    @GPADryingChargeDetailID	int,
    @GPADryingChargeID	int,
    @Increment	money,
    @RangeFrom	money,
    @RangeTo	money,
    @Value	decimal(14,6),
    @UpdatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_GPA_DRYING_CHARGE_DETAIL SET
    [GPADryingChargeID] = @GPADryingChargeID,
    [Increment] = @Increment,
    [RangeFrom] = @RangeFrom,
    [RangeTo] = @RangeTo,
    [Value] = @Value,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE GPADryingChargeDetailID = @GPADryingChargeDetailID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_DRYING_CHARGE_DETAIL_UPDATE] TO [db_sp_exec]
    AS [dbo];

