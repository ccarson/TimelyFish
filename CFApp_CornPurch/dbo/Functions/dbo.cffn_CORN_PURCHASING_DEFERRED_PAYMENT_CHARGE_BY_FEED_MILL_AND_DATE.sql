
-- ================================================================================
-- Author:	Nick Honetschlager
-- Create date: 03/09/2015
-- Description:	Selects Deferred Payment Amount by feed mill id and effective dates
-- ================================================================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_DEFERRED_PAYMENT_CHARGE_BY_FEED_MILL_AND_DATE]
(
	@Date	datetime,
    @FeedMillID	char(10),    
    @DeferredPaymentRateAdj money,
    @ContractID varchar(72)
)
RETURNS decimal(18,4)
BEGIN

DECLARE @DeferredPaymentCharge		decimal(18,4),
		@DeferredPaymentAmount		decimal(14,6),
		@ContractTypeChangeDate		datetime,
		@FinalDeliveryDate			datetime,
		@DeferredPaymentScheduleID	int,		
		@LastContractTypeID			int,
		@PriceLater					int,
		@DeferredPayment			int,
		@ContractTypeID				int,
		@LCPriceLater				int,
		@LCDeferredPayment			int

IF @ContractID IS NULL BEGIN
	SET @DeferredPaymentCharge = 0
END

IF @DeferredPaymentRateAdj IS NOT NULL BEGIN
	SET @DeferredPaymentCharge = @DeferredPaymentRateAdj
END
ELSE BEGIN
	SET @DeferredPaymentScheduleID = dbo.cffn_CORN_PURCHASING_GPA_DEFERRED_PAYMENT_ID_BY_FEED_MILL_AND_DATE(@FeedMillID, @Date)

	SELECT @DeferredPaymentAmount = Amount
	FROM cft_GPA_DEFERRED_PAYMENT
	WHERE GPADeferredPaymentID = @DeferredPaymentScheduleID

	SELECT @LastContractTypeID = c.LastContractTypeID, @PriceLater = ct.PriceLater, @DeferredPayment = ct.DeferredPayment, @ContractTypeChangeDate = c.ContractTypeChangeDate, @ContractTypeID = c.ContractTypeID
	FROM cft_CONTRACT c (NOLOCK)
	JOIN cft_CONTRACT_TYPE ct (NOLOCK) ON c.ContractTypeID = ct.ContractTypeID
	WHERE c.ContractID = @ContractID
		
	SELECT @LCPriceLater = PriceLater, @LCDeferredPayment = DeferredPayment
	FROM  cft_CONTRACT_TYPE (NOLOCK)
	WHERE ContractTypeID = @LastContractTypeID 
		
	IF @DeferredPayment = 0 AND @LastContractTypeID IS NOT NULL AND @LCPriceLater = 1 BEGIN
		SET @DeferredPaymentCharge = 0
	END
	ELSE IF @LCPriceLater = 1 OR (@LCDeferredPayment = 1 AND @LastContractTypeID IS NOT NULL AND @LCPriceLater = 1) BEGIN
		IF @ContractTypeChangeDate IS NOT NULL BEGIN
			IF ABS(DATEDIFF(d, GETDATE(), @ContractTypeChangeDate)) > 0 BEGIN
				SET @DeferredPaymentCharge = (ABS(DATEDIFF(d, GETDATE(), @ContractTypeChangeDate))) * (@DeferredPaymentAmount * 12)/365
			END
		END
	END
	ELSE IF @DeferredPayment = 1 BEGIN
		
		SELECT TOP 1 @FinalDeliveryDate = DeliveryDate
		FROM dbo.cft_PARTIAL_TICKET
		WHERE ContractID = @ContractID
		ORDER BY DeliveryDate DESC
		
		IF ABS(DATEDIFF(d, GETDATE(), @FinalDeliveryDate)) > 0 BEGIN
			SET @DeferredPaymentCharge = (ABS(DATEDIFF(d, GETDATE(), @FinalDeliveryDate))) * (@DeferredPaymentAmount * 12)/365
		END
	END
	ELSE BEGIN
		SET @DeferredPaymentCharge = 0
	END
END
RETURN @DeferredPaymentCharge

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_DEFERRED_PAYMENT_CHARGE_BY_FEED_MILL_AND_DATE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_DEFERRED_PAYMENT_CHARGE_BY_FEED_MILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];

