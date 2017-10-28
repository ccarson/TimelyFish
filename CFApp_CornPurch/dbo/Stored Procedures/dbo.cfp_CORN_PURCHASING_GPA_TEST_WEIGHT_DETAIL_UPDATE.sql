
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Updates the GpaTestWeightDetail record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_TEST_WEIGHT_DETAIL_UPDATE]
(
    @GPATestWeightDetailID	int,
    @GPATestWeightID	int,
    @Increment	money,
    @RangeFrom	money,
    @RangeTo	money,
    @Value	decimal(14,6),
    @UpdatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_GPA_TEST_WEIGHT_DETAIL SET
    [GPATestWeightID] = @GPATestWeightID,
    [Increment] = @Increment,
    [RangeFrom] = @RangeFrom,
    [RangeTo] = @RangeTo,
    [Value] = @Value,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE GPATestWeightDetailID = @GPATestWeightDetailID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_TEST_WEIGHT_DETAIL_UPDATE] TO [db_sp_exec]
    AS [dbo];

