
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects GpaShrinkDeductionDetail record by date,range and feed mill id
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_GPA_SHRINK_DEDUCTION_DETAIL_SELECT_BY_DATE_AND_RANGE
(
    @Date	datetime,
    @Range	decimal(5,2),
    @FeedMillID	char(10)
)
AS
BEGIN
SET NOCOUNT ON;

IF EXISTS (SELECT 1
           FROM dbo.cft_GPA_SHRINK_DEDUCTION_DETAIL SDD
           INNER JOIN dbo.cft_GPA_SHRINK_DEDUCTION SD ON SD.GPAShrinkDeductionID = SDD.GPAShrinkDeductionID
           WHERE SD.Active = 1 
                 AND SD.[Default] = 0 
                 AND SD.FeedMillID = @FeedMillID
                 AND @Date BETWEEN SD.EffectiveDateFrom AND SD.EffectiveDateTo
                 AND @Range BETWEEN SDD.RangeFrom AND SDD.RangeTo
          )          
BEGIN

SELECT SDD.[GPAShrinkDeductionDetailID],
       SDD.[GPAShrinkDeductionID],
       SDD.[Increment],
       SDD.[RangeFrom],
       SDD.[RangeTo],
       SDD.[Value],
       SDD.[CreatedDateTime],
       SDD.[CreatedBy],
       SDD.[UpdatedDateTime],
       SDD.[UpdatedBy]
FROM dbo.cft_GPA_SHRINK_DEDUCTION_DETAIL SDD
INNER JOIN dbo.cft_GPA_SHRINK_DEDUCTION SD ON SD.GPAShrinkDeductionID = SDD.GPAShrinkDeductionID
WHERE SD.Active = 1 
      AND SD.[Default] = 0 
      AND SD.FeedMillID = @FeedMillID
      AND @Date BETWEEN SD.EffectiveDateFrom AND SD.EffectiveDateTo
      AND @Range BETWEEN SDD.RangeFrom AND SDD.RangeTo

END ELSE BEGIN

SELECT SDD.[GPAShrinkDeductionDetailID],
       SDD.[GPAShrinkDeductionID],
       SDD.[Increment],
       SDD.[RangeFrom],
       SDD.[RangeTo],
       SDD.[Value],
       SDD.[CreatedDateTime],
       SDD.[CreatedBy],
       SDD.[UpdatedDateTime],
       SDD.[UpdatedBy]
FROM dbo.cft_GPA_SHRINK_DEDUCTION_DETAIL SDD
INNER JOIN dbo.cft_GPA_SHRINK_DEDUCTION SD ON SD.GPAShrinkDeductionID = SDD.GPAShrinkDeductionID
WHERE SD.Active = 1 
      AND SD.[Default] = 1 
      AND SD.FeedMillID = @FeedMillID
      AND @Date BETWEEN SD.EffectiveDateFrom AND isnull(SD.EffectiveDateTo,'12/31/2099')
      AND @Range BETWEEN SDD.RangeFrom AND SDD.RangeTo

END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_SHRINK_DEDUCTION_DETAIL_SELECT_BY_DATE_AND_RANGE] TO [db_sp_exec]
    AS [dbo];

