
-- ===================================================================
-- Author:	Nick Honetschlager
-- Create date: 02/16/2015
-- Description:	Calculates the drying discount
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_TOTAL_DRYING_DISCOUNT_BY_FEEDMILL_AND_DATE]
(
	@Date datetime,
    @Moisture decimal(5,2),
    @FeedmillID char(10),
    @SentToDryer int,
    @DryingRateAdj money,
    @MoistureValuationMethod int,
    @ContractID varchar(72)
)
RETURNS decimal(18,4)
AS
BEGIN

DECLARE @GPADryingChargeID int,
		@GPADryingChargeDetailID int,
		@RangeToForZeroAdjustment decimal (5,2),
		@Value decimal(14,6),
		@Increment decimal(5,2),
		@DryingDiscount decimal(18,4),
		@WeightAvg decimal(18,4)
DECLARE @TempTable TABLE(GPADryingChargeDetailID int null, GPADryingChargeID int, Moisture decimal(5,2) null, FeedMillID char(10) null, DryBushels decimal(18,4) null, WetBushels decimal(20,4) null, ContractID varchar(72) null)
		
IF @DryingRateAdj IS NOT NULL BEGIN

	SET @DryingDiscount = @DryingRateAdj

END 
ELSE IF @SentToDryer = 1 BEGIN

	IF @ContractID IS NOT NULL BEGIN
	
		--SET @GPADryingChargeID = dbo.cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_ID_BY_DATE_AND_RANGE(@MoistureValuationMethod, @Date, @Moisture, @FeedmillID)
	
		IF @MoistureValuationMethod = 1 BEGIN 
			SET @DryingDiscount = dbo.cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_DEDUCTION_BY_FEEDMILL_AND_DATE(@MoistureValuationMethod, @Date, @Moisture, @FeedmillID)
		END
		ELSE IF @MoistureValuationMethod = 2 BEGIN
					
			SELECT @WeightAvg = (SUM(ct.Moisture * pt.WetBushels))/(SUM(pt.WetBushels))
			FROM cft_PARTIAL_TICKET pt (NOLOCK)
			JOIN cft_CORN_TICKET ct (NOLOCK) ON pt.FullTicketID = ct.TicketID
			WHERE SentToAccountsPayable <> 1
			AND ContractID IS NOT NULL AND ContractID = @ContractID
			GROUP BY ContractID
			
			SET @DryingDiscount = dbo.cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_DEDUCTION_BY_FEEDMILL_AND_DATE(@MoistureValuationMethod, @Date, @WeightAvg, @FeedmillID)			
			RETURN @DryingDiscount			
		END
		ELSE IF @MoistureValuationMethod = 3 BEGIN		
		
			SET @GPADryingChargeDetailID = dbo.cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_DETAIL_ID_BY_DATE_AND_RANGE(@MoistureValuationMethod, @Date, @Moisture, @FeedmillID)
			SET @GPADryingChargeID = dbo.cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_ID_BY_DATE_AND_RANGE(@MoistureValuationMethod, @Date, @Moisture, @FeedmillID)
			
			INSERT INTO @TempTable(GPADryingChargeDetailID, GPADryingChargeID, Moisture, FeedMillID, DryBushels, WetBushels, ContractID)
			SELECT dbo.cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_DETAIL_ID_BY_DATE_AND_RANGE(dbo.cffn_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_FOR_FEED_MILL_AND_DATE(ct.FeedMillID, ct.DeliveryDate), ct.DeliveryDate, ct.Moisture, ct.FeedMillID) AS 'GPADryingChargeDetailID', dbo.cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_ID_BY_DATE_AND_RANGE(dbo.cffn_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_FOR_FEED_MILL_AND_DATE(ct.FeedMillID, ct.DeliveryDate), ct.DeliveryDate, ct.Moisture, ct.FeedMillID) AS 'GPADryingChargeID', ct.Moisture, ct.FeedMillID, pt.DryBushels, pt.WetBushels, pt.ContractID
			FROM cft_PARTIAL_TICKET pt (NOLOCK)
			JOIN cft_CORN_TICKET ct (NOLOCK) ON pt.FullTicketID = ct.TicketID
			WHERE SentToAccountsPayable <> 1
			AND ContractID IS NOT NULL AND ContractID = 16386
			
			SELECT @WeightAvg = (SUM(Moisture * WetBushels))/(SUM(WetBushels))
			FROM @TempTable
			WHERE GPADryingChargeDetailID = @GPADryingChargeDetailID
			AND GPADryingChargeID = @GPADryingChargeID
						
			SET @DryingDiscount = dbo.cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_DEDUCTION_BY_FEEDMILL_AND_DATE(@MoistureValuationMethod, @Date, @WeightAvg, @FeedmillID)			
			RETURN @DryingDiscount	
		END
		
	END
END
ELSE
BEGIN
SET @DryingDiscount = 0
END

RETURN @DryingDiscount

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_TOTAL_DRYING_DISCOUNT_BY_FEEDMILL_AND_DATE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_TOTAL_DRYING_DISCOUNT_BY_FEEDMILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];

