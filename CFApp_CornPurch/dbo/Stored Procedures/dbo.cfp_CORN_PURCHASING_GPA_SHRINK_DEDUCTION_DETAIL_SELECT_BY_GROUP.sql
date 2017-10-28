
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects GpaShrinkDeductionDetail record by group id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_SHRINK_DEDUCTION_DETAIL_SELECT_BY_GROUP]
(
    @GPAShrinkDeductionID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [GPAShrinkDeductionDetailID],
       [Increment],
       [RangeFrom],
       [RangeTo],
       [Value],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_GPA_SHRINK_DEDUCTION_DETAIL
WHERE GPAShrinkDeductionID = @GPAShrinkDeductionID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_SHRINK_DEDUCTION_DETAIL_SELECT_BY_GROUP] TO [db_sp_exec]
    AS [dbo];

