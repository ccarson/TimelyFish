
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Creates new GpaDryingChargeDetail record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_DRYING_CHARGE_DETAIL_INSERT]
(
    @GPADryingChargeDetailID	int	OUT,
    @GPADryingChargeID	int,
    @Increment	money,
    @RangeFrom	money,
    @RangeTo	money,
    @Value	decimal(14,6),
    @CreatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_GPA_DRYING_CHARGE_DETAIL
  (
      [GPADryingChargeID],
      [Increment],
      [RangeFrom],
      [RangeTo],
      [Value],
      [CreatedBy]
  )
  VALUES
  (
      @GPADryingChargeID,
      @Increment,
      @RangeFrom,
      @RangeTo,
      @Value,
      @CreatedBy
  )

  SELECT @GPADryingChargeDetailID = GPADryingChargeDetailID
  FROM dbo.cft_GPA_DRYING_CHARGE_DETAIL
  WHERE GPADryingChargeDetailID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_DRYING_CHARGE_DETAIL_INSERT] TO [db_sp_exec]
    AS [dbo];

