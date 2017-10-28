
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Creates new GpaMoistureChargeDetail record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_CHARGE_DETAIL_INSERT]
(
    @GPAMoistureChargeDetailID	int	OUT,
    @GPAMoistureChargeID	int,
    @Increment	money,
    @RangeFrom	money,
    @RangeTo	money,
    @Value	decimal(14,6),
    @CreatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_GPA_MOISTURE_CHARGE_DETAIL
  (
      [GPAMoistureChargeID],
      [Increment],
      [RangeFrom],
      [RangeTo],
      [Value],
      [CreatedBy]
  )
  VALUES
  (
      @GPAMoistureChargeID,
      @Increment,
      @RangeFrom,
      @RangeTo,
      @Value,
      @CreatedBy
  )

  SELECT @GPAMoistureChargeDetailID = GPAMoistureChargeDetailID
  FROM dbo.cft_GPA_MOISTURE_CHARGE_DETAIL
  WHERE GPAMoistureChargeDetailID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_CHARGE_DETAIL_INSERT] TO [db_sp_exec]
    AS [dbo];

