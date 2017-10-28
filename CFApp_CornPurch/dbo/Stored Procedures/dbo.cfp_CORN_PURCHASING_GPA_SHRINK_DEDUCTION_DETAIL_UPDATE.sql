
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Updates the GpaShrinkDeductionDetail record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_SHRINK_DEDUCTION_DETAIL_UPDATE]
(
    @GPAShrinkDeductionDetailID	int,
    @GPAShrinkDeductionID	int,
    @Increment	money,
    @RangeFrom	money,
    @RangeTo	money,
    @Value	decimal(14,6),
    @UpdatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_GPA_SHRINK_DEDUCTION_DETAIL SET
    [GPAShrinkDeductionID] = @GPAShrinkDeductionID,
    [Increment] = @Increment,
    [RangeFrom] = @RangeFrom,
    [RangeTo] = @RangeTo,
    [Value] = @Value,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE GPAShrinkDeductionDetailID = @GPAShrinkDeductionDetailID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_SHRINK_DEDUCTION_DETAIL_UPDATE] TO [db_sp_exec]
    AS [dbo];

