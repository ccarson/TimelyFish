
-- ===================================================================
-- Author:	Nick Honetschlager
-- Create date: 03/03/2015
-- Description:	Calculates the test weight discount
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_TOTAL_TEST_WEIGHT_DISCOUNT_BY_FEEDMILL_AND_DATE]
(
	@Date datetime,
    @Moisture decimal(5,2),
    @FeedmillID char(10),
    @TestWeight decimal(18,4),
    @TestWeightRateAdj money,
    @MoistureValuationMethod int,
    @ContractID varchar(72)
)
RETURNS decimal(18,4)
AS
BEGIN

DECLARE @GPATestWeightChargeID int,
		@GPATestWeightChargeDetailID int,
		@RangeFromForZeroAdjustment decimal (5,2),
		@Value decimal(14,6),
		@Increment decimal(5,2),
		@TestWeightDiscount decimal(18,4)
		
IF @TestWeightRateAdj IS NOT NULL BEGIN
	SET @TestWeightDiscount = @TestWeightRateAdj
END 
ELSE IF @TestWeight IS NOT NULL BEGIN
	
	SET @GPATestWeightChargeID = dbo.cffn_CORN_PURCHASING_GPA_TEST_WEIGHT_ID_BY_DATE_AND_RANGE(@Date, @Moisture, @FeedmillID)

	SELECT @RangeFromForZeroAdjustment = RangeFrom
	FROM dbo.cft_GPA_TEST_WEIGHT_DETAIL
	WHERE GPATestWeightID = @GPATestWeightChargeID
	AND Value = 0
	
	IF @TestWeight < @RangeFromForZeroAdjustment BEGIN
	
		SELECT @Value = Value, @Increment = Increment
		FROM dbo.cft_GPA_TEST_WEIGHT_DETAIL
		WHERE GPATestWeightID = @GPATestWeightChargeID
		AND @TestWeight BETWEEN RangeFrom AND RangeTo
	
		SET @TestWeightDiscount = @Value * (@RangeFromForZeroAdjustment - @TestWeight)/@Increment
	END 
	ELSE BEGIN
		SET @TestWeightDiscount = 0
	END
		
END
ELSE BEGIN
SET @TestWeightDiscount = 0
END

RETURN @TestWeightDiscount

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_TOTAL_TEST_WEIGHT_DISCOUNT_BY_FEEDMILL_AND_DATE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_TOTAL_TEST_WEIGHT_DISCOUNT_BY_FEEDMILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];

