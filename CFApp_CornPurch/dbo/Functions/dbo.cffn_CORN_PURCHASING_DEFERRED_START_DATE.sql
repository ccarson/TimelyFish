
-- ===================================================================
-- Author:	Nick Honetschlager
-- Create date: 03/11/2015
-- Description:	Selects final delivery date for a contract.
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_DEFERRED_START_DATE]
(
    @ContractID		int
)
RETURNS datetime
BEGIN

DECLARE	 @FinalDeliveryDate			datetime
		,@ContractTypeChangeDate	datetime
		,@LastContractTypeID		int		
		,@LCPriceLater				int

SELECT @LastContractTypeID = LastContractTypeID, @ContractTypeChangeDate = ContractTypeChangeDate
FROM cft_CONTRACT c (NOLOCK)
JOIN cft_CONTRACT_TYPE ct (NOLOCK) ON c.ContractTypeID = ct.ContractTypeID
WHERE ContractID LIKE @ContractID

SELECT @LCPriceLater = PriceLater
FROM  cft_CONTRACT_TYPE (NOLOCK)
WHERE ContractTypeID = @LastContractTypeID 

IF @LastContractTypeID IS NOT NULL AND @LCPriceLater = 1 BEGIN
	SET @FinalDeliveryDate = @ContractTypeChangeDate
END 
ELSE BEGIN
	SELECT TOP 1 @FinalDeliveryDate = DeliveryDate
	FROM dbo.cft_PARTIAL_TICKET
	WHERE ContractID = @ContractID
	ORDER BY DeliveryDate DESC 
END

RETURN @FinalDeliveryDate

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_DEFERRED_START_DATE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_DEFERRED_START_DATE] TO [db_sp_exec]
    AS [dbo];

