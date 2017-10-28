
-- ===================================================================
-- Author:	Nick Honetschlager
-- Create date: 02/17/2015
-- Description:	Calculates the drying charge
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_DEDUCTION_BY_FEEDMILL_AND_DATE]
(
	@GPAMoistureValuationMethodID int,
    @Date datetime,
    @Moisture decimal(5,2),
    @FeedmillID char(10)
)
RETURNS decimal(18,4)
AS
BEGIN

DECLARE @GPADryingChargeID int,
		@RangeToForZeroAdjustment decimal (5,2),
		@Value decimal(14,6),
		@Increment decimal(5,2),
		@DryingChargeDiscount decimal(18,4)
	
SET @GPADryingChargeID = dbo.cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_ID_BY_DATE_AND_RANGE(@GPAMoistureValuationMethodID, @Date, @Moisture, @FeedmillID)

SELECT @RangeToForZeroAdjustment = RangeTo
FROM dbo.cft_GPA_DRYING_CHARGE_DETAIL
WHERE GPADryingChargeID = @GPADryingChargeID
AND Value = 0

SET @Value = dbo.cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_BY_DATE_AND_RANGE(@Date, @Moisture, @FeedMillID)

SELECT @Increment = Increment
FROM dbo.cft_GPA_DRYING_CHARGE_DETAIL
WHERE GPADryingChargeID = @GPADryingChargeID
AND @Moisture BETWEEN RangeFrom AND RangeTo

SET @DryingChargeDiscount = @Value * (@Moisture - @RangeToForZeroAdjustment)/@Increment

RETURN @DryingChargeDiscount

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_DEDUCTION_BY_FEEDMILL_AND_DATE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_DEDUCTION_BY_FEEDMILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];

