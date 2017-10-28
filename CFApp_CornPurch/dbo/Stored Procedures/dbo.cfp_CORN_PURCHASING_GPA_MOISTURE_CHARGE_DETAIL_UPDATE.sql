
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Updates the GpaMoistureChargeDetail record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_CHARGE_DETAIL_UPDATE]
(
    @GPAMoistureChargeDetailID	int,
    @GPAMoistureChargeID	int,
    @Increment	money,
    @RangeFrom	money,
    @RangeTo	money,
    @Value	decimal(14,6),
    @UpdatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_GPA_MOISTURE_CHARGE_DETAIL SET
    [GPAMoistureChargeID] = @GPAMoistureChargeID,
    [Increment] = @Increment,
    [RangeFrom] = @RangeFrom,
    [RangeTo] = @RangeTo,
    [Value] = @Value,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE GPAMoistureChargeDetailID = @GPAMoistureChargeDetailID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_CHARGE_DETAIL_UPDATE] TO [db_sp_exec]
    AS [dbo];

