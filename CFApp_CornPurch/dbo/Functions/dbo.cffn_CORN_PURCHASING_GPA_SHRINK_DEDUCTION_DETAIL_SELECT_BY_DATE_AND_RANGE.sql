
-- ===================================================================
-- Author:	Nick Honetschlager
-- Create date: 02/16/2015
-- Description:	Returns shrink schedule ID
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_GPA_SHRINK_DEDUCTION_DETAIL_SELECT_BY_DATE_AND_RANGE]
(
    @Date	datetime,
    @Range	decimal(5,2),
    @FeedMillID	char(10)
)
RETURNS int
AS
BEGIN

DECLARE @ShrinkDeductionID int

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

SELECT @ShrinkDeductionID = SDD.[GPAShrinkDeductionID]
FROM dbo.cft_GPA_SHRINK_DEDUCTION_DETAIL SDD
INNER JOIN dbo.cft_GPA_SHRINK_DEDUCTION SD ON SD.GPAShrinkDeductionID = SDD.GPAShrinkDeductionID
WHERE SD.Active = 1 
      AND SD.[Default] = 0 
      AND SD.FeedMillID = @FeedMillID
      AND @Date BETWEEN SD.EffectiveDateFrom AND SD.EffectiveDateTo
      AND @Range BETWEEN SDD.RangeFrom AND SDD.RangeTo

END ELSE BEGIN

SELECT @ShrinkDeductionID = SDD.[GPAShrinkDeductionID]
FROM dbo.cft_GPA_SHRINK_DEDUCTION_DETAIL SDD
INNER JOIN dbo.cft_GPA_SHRINK_DEDUCTION SD ON SD.GPAShrinkDeductionID = SDD.GPAShrinkDeductionID
WHERE SD.Active = 1 
      AND SD.[Default] = 1 
      AND SD.FeedMillID = @FeedMillID
      AND @Date BETWEEN SD.EffectiveDateFrom AND isnull(SD.EffectiveDateTo,'12/31/2099')
      AND @Range BETWEEN SDD.RangeFrom AND SDD.RangeTo

END

RETURN @ShrinkDeductionID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_SHRINK_DEDUCTION_DETAIL_SELECT_BY_DATE_AND_RANGE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_SHRINK_DEDUCTION_DETAIL_SELECT_BY_DATE_AND_RANGE] TO [db_sp_exec]
    AS [dbo];

