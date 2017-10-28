
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Creates new GpaShrinkDeductionDetail record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_SHRINK_DEDUCTION_DETAIL_INSERT]
(
    @GPAShrinkDeductionDetailID	int	OUT,
    @GPAShrinkDeductionID	int,
    @Increment	money,
    @RangeFrom	money,
    @RangeTo	money,
    @Value	decimal(14,6),
    @CreatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_GPA_SHRINK_DEDUCTION_DETAIL
  (
      [GPAShrinkDeductionID],
      [Increment],
      [RangeFrom],
      [RangeTo],
      [Value],
      [CreatedBy]
  )
  VALUES
  (
      @GPAShrinkDeductionID,
      @Increment,
      @RangeFrom,
      @RangeTo,
      @Value,
      @CreatedBy
  )

  SELECT @GPAShrinkDeductionDetailID = GPAShrinkDeductionDetailID
  FROM dbo.cft_GPA_SHRINK_DEDUCTION_DETAIL
  WHERE GPAShrinkDeductionDetailID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_SHRINK_DEDUCTION_DETAIL_INSERT] TO [db_sp_exec]
    AS [dbo];

