
-- ===================================================================
-- Author:	Nick Honetschlager
-- Create date: 02/16/2015
-- Description:	Calculates the shrink discount
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_SHRINK_DEDUCTION_BY_FEEDMILL_AND_DATE]
(
    @Date datetime,
    @Moisture decimal(5,2),
    @FeedmillID char(10),
    @SentToDryer int  
)
RETURNS decimal(18,4)
AS
BEGIN

DECLARE @GPAShrinkDeductionID int,
		@RangeToForZeroAdjustment decimal (5,2),
		@Value decimal(14,6),
		@Increment decimal(5,2),
		@ShrinkDiscount decimal(18,4)
		
IF @SentToDryer = 1 BEGIN
		
SET @GPAShrinkDeductionID = dbo.cffn_CORN_PURCHASING_GPA_SHRINK_DEDUCTION_DETAIL_SELECT_BY_DATE_AND_RANGE(@Date, @Moisture, @FeedmillID)

SELECT @RangeToForZeroAdjustment = RangeTo
FROM dbo.cft_GPA_SHRINK_DEDUCTION_DETAIL
WHERE GPAShrinkDeductionID = @GPAShrinkDeductionID
AND Value = 0

SELECT @Value = Value, @Increment = Increment
FROM dbo.cft_GPA_SHRINK_DEDUCTION_DETAIL
WHERE GPAShrinkDeductionID = @GPAShrinkDeductionID
AND @Moisture BETWEEN RangeFrom AND RangeTo

SET @ShrinkDiscount = @Value * (@Moisture - @RangeToForZeroAdjustment)/@Increment

END ELSE BEGIN
SET @ShrinkDiscount = 0
END 

RETURN @ShrinkDiscount

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_SHRINK_DEDUCTION_BY_FEEDMILL_AND_DATE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_SHRINK_DEDUCTION_BY_FEEDMILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];

