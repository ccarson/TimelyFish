
-- ===================================================================
-- Author:	Nick Honetschlager
-- Create date: 03/04/2015
-- Description:	Calculates the test weight discount
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_FOREIGN_MATERIAL_DISCOUNT_BY_FEEDMILL_AND_DATE]
(
	@Date datetime,
    @Moisture decimal(5,2),
    @FeedmillID char(10),
    @ForeignMaterial decimal(18,4),
    @ForeignMaterialRateAdj money,
    @MoistureValuationMethod int,
    @ContractID varchar(72)
)
RETURNS decimal(18,4)
AS
BEGIN

DECLARE @GPAForeignMaterialID int,
		@RangeToForZeroAdjustment decimal (5,2),
		@Value decimal(14,6),
		@Increment decimal(5,2),
		@ForeignMaterialDiscount decimal(18,4)
		
IF @ForeignMaterialRateAdj IS NOT NULL BEGIN
	SET @ForeignMaterialDiscount = @ForeignMaterialRateAdj
END
ELSE IF @ForeignMaterial IS NOT NULL BEGIN
	SET @GPAForeignMaterialID = dbo.cffn_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_ID_SELECT_BY_DATE_AND_RANGE(@Date, @Moisture, @FeedmillID)
	
	SELECT @RangeToForZeroAdjustment = RangeTo
	FROM dbo.cft_GPA_FOREIGN_MATERIAL_DETAIL
	WHERE GPAForeignMaterialID = @GPAForeignMaterialID
	AND Value = 0
	
	SELECT @Value = Value, @Increment = Increment
	FROM dbo.cft_GPA_FOREIGN_MATERIAL_DETAIL
	WHERE GPAForeignMaterialID = @GPAForeignMaterialID
	AND @ForeignMaterial BETWEEN RangeFrom AND RangeTo
	
	SET @ForeignMaterialDiscount = @Value * (@ForeignMaterial - @RangeToForZeroAdjustment)/ @Increment
	
END
ELSE BEGIN
	SET @ForeignMaterialDiscount = 0
END

RETURN @ForeignMaterialDiscount

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_FOREIGN_MATERIAL_DISCOUNT_BY_FEEDMILL_AND_DATE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_FOREIGN_MATERIAL_DISCOUNT_BY_FEEDMILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];

