
-- =============================================================================
-- Author:	Nick Honetschlager
-- Create date: 03/04/2015
-- Description:	Selects GpaHandlingCharge ID by feed mill id and effective dates
-- =============================================================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_GPA_HANDLING_CHARGE_BY_FEED_MILL_AND_DATE]
(
	@Date	datetime,
    @FeedMillID	char(10),    
    @HandlingRateAdj money,
    @ContractID varchar(72)
)
RETURNS decimal(18,6)
BEGIN

DECLARE @GPAHandlingChargeID int,
		@RangeToForZeroAdjustment decimal (5,2),
		@Value decimal(14,6),
		@Increment decimal(5,2),
		@HandlingCharge decimal(18,6),
		@StartDate datetime,
		@FreeDelayedPricingLength int,
		@ChargesBeginDate datetime,
		@HandlingChargeRate decimal(14,6),
		@PriceLater int, 
		@DeferredPayment int,
		@LastContractTypeID int,
		@ContractTypeChangeDate datetime,
		@ContractTypeID int
		
SET @GPAHandlingChargeID = dbo.cffn_CORN_PURCHASING_GPA_HANDLING_CHARGE_ID_BY_FEED_MILL_AND_DATE(@FeedMillID, @Date)

IF @HandlingRateAdj IS NOT NULL BEGIN
	SET @HandlingCharge = @HandlingRateAdj
END
ELSE BEGIN
	SET @StartDate = dbo.cffn_CORN_PURCHASING_GPA_HANDLING_START_DATE_BY_FEED_MILL_AND_DATE(@Date, @FeedMillID, @ContractID)

	SELECT @HandlingChargeRate = HandlingCharge, @FreeDelayedPricingLength = FreeDelayedPricingLength, @ChargesBeginDate = ChargesBeginDate
	FROM cft_GPA_HANDLING_CHARGE
	WHERE GPAHandlingChargeID = @GPAHandlingChargeID

	SELECT @LastContractTypeID = c.LastContractTypeID, @PriceLater = ct.PriceLater, @DeferredPayment = ct.DeferredPayment, @ContractTypeChangeDate = c.ContractTypeChangeDate, @ContractTypeID = c.ContractTypeID
	FROM cft_CONTRACT c (NOLOCK)
	JOIN cft_CONTRACT_TYPE ct (NOLOCK) ON c.ContractTypeID = ct.ContractTypeID
	WHERE c.ContractID = @ContractID

	IF @PriceLater = 1 BEGIN
		IF @StartDate IS NOT NULL AND ((GETDATE() > @StartDate AND @FreeDelayedPricingLength IS NOT NULL) OR (GETDATE() >= @StartDate) AND @ChargesBeginDate IS NOT NULL) BEGIN
			SET @HandlingCharge = @HandlingChargeRate * 12.0/365.0 * (DATEDIFF(d, @StartDate, GETDATE())) * -1.0
		END
	END

	SELECT @PriceLater = PriceLater, @DeferredPayment = DeferredPayment
	FROM  cft_CONTRACT_TYPE (NOLOCK)
	WHERE ContractTypeID = @LastContractTypeID

	IF ((@LastContractTypeID IS NOT NULL AND @PriceLater = 1 AND ((@ContractTypeChangeDate > @StartDate AND @FreeDelayedPricingLength IS NOT NULL) OR ((@ContractTypeChangeDate >= @StartDate) AND @ChargesBeginDate IS NOT NULL))) 
		OR @PriceLater = 1) BEGIN
		IF @StartDate IS NOT NULL BEGIN
			IF @StartDate < @ContractTypeChangeDate BEGIN
				SET @HandlingCharge = @HandlingChargeRate * 12 / 365 * (DATEDIFF(d, @StartDate, @ContractTypeChangeDate)) * -1.0
			END
		END
	END

	IF @HandlingCharge IS NULL BEGIN
		SET @HandlingCharge = 0
	END
END

RETURN @HandlingCharge

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_HANDLING_CHARGE_BY_FEED_MILL_AND_DATE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_HANDLING_CHARGE_BY_FEED_MILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];

