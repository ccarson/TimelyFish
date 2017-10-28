
-- =============================================================================
-- Author:	Nick Honetschlager
-- Create date: 03/04/2015
-- Description:	Selects GpaHandlingCharge Start Date by feed mill id and effective dates
-- =============================================================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_GPA_HANDLING_START_DATE_BY_FEED_MILL_AND_DATE]
(
	@Date		datetime,
    @FeedMillID	char(10),
    @ContractID varchar(72)
    )
RETURNS datetime
BEGIN

DECLARE	  @GPAHandlingChargeID		int 
		, @LastContractTypeID		int
		, @StartDate				datetime
		, @FreeDelayedPricingLength int
		, @ChargesBeginDate			datetime
		, @PriceLater				int
		, @LCPriceLater				int
		, @Deferred					int
		
SET @GPAHandlingChargeID = dbo.cffn_CORN_PURCHASING_GPA_HANDLING_CHARGE_ID_BY_FEED_MILL_AND_DATE(@FeedMillID, @Date)

SELECT @LastContractTypeID = LastContractTypeID, @PriceLater = ct.PriceLater, @Deferred = ct.DeferredPayment
FROM cft_CONTRACT c (NOLOCK)
JOIN cft_CONTRACT_TYPE ct (NOLOCK) ON c.ContractTypeID = ct.ContractTypeID
WHERE ContractID LIKE @ContractID
	
SELECT @LCPriceLater = PriceLater
FROM  cft_CONTRACT_TYPE (NOLOCK)
WHERE ContractTypeID = @LastContractTypeID 

--Deferred, Price Later or Standard
IF (@LastContractTypeID IS NOT NULL AND @LCPriceLater = 1) OR (@PriceLater = 1 OR (@Deferred = 0 AND @PriceLater = 0 AND @LastContractTypeID IS NOT NULL AND @LCPriceLater = 1)) BEGIN--@LastContractTypeID IN (21, 47)) BEGIN 
	
	SELECT @ChargesBeginDate = ChargesBeginDate, @FreeDelayedPricingLength = FreeDelayedPricingLength
	FROM cft_GPA_HANDLING_CHARGE
	WHERE GPAHandlingChargeID = @GPAHandlingChargeID
	
	IF @ChargesBeginDate IS NOT NULL BEGIN
		SET @StartDate = @ChargesBeginDate
	END
	ELSE BEGIN
		SET @StartDate = DATEADD(DAY, @FreeDelayedPricingLength, @Date)
	END
END 
ELSE BEGIN
	SET @StartDate = NULL	
END
RETURN @StartDate
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_HANDLING_START_DATE_BY_FEED_MILL_AND_DATE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_HANDLING_START_DATE_BY_FEED_MILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];

