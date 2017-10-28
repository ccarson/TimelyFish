
-- ===================================================================
-- Author:	Nick Honetschlager
-- Create date: 02/17/2015
-- Description:	Calculates the moisture discount
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_MOISTURE_DEDUCTION_BY_FEEDMILL_AND_DATE]
(
    @Date datetime,
    @Moisture decimal(5,2),
    @FeedmillID char(10),
    @SentToDryer int,
    @MoistureRateAdj money
)
RETURNS decimal(18,4)
AS
BEGIN

DECLARE @GPAMoistureChargeID int,
		@RangeToForZeroAdjustment decimal (5,2),
		@Value decimal(14,6),
		@Increment decimal(5,2),
		@MoistureDiscount decimal(18,4)
		
IF @MoistureRateAdj IS NOT NULL BEGIN
	SET @MoistureDiscount = @MoistureRateAdj
END
ELSE IF @SentToDryer = 1 BEGIN
	SET @MoistureDiscount = 0
END
ELSE BEGIN
		
	SET @GPAMoistureChargeID = dbo.cffn_CORN_PURCHASING_MOISTURE_DEDUCTION_DETAIL_SELECT_BY_DATE_AND_RANGE(@Date, @Moisture, @FeedmillID)

	SELECT @RangeToForZeroAdjustment = RangeTo
	FROM dbo.cft_GPA_MOISTURE_CHARGE_DETAIL
	WHERE GPAMoistureChargeID = @GPAMoistureChargeID
	AND Value = 0

	SELECT @Value = Value, @Increment = Increment
	FROM dbo.cft_GPA_MOISTURE_CHARGE_DETAIL
	WHERE GPAMoistureChargeID = @GPAMoistureChargeID
	AND @Moisture BETWEEN RangeFrom AND RangeTo

	SET @MoistureDiscount = @Value * (@Moisture - @RangeToForZeroAdjustment)/@Increment
END

RETURN @MoistureDiscount

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_MOISTURE_DEDUCTION_BY_FEEDMILL_AND_DATE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_MOISTURE_DEDUCTION_BY_FEEDMILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];

