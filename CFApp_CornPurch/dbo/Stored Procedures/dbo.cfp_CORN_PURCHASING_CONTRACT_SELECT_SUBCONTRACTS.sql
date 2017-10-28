
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 03/11/2008
-- Description:	Selects subcontracts for given contract. 
-- ===================================================================
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-07-31  Doran Dahle Added SubProducerName, HTAContract to the results.
						

===============================================================================
*/
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_CONTRACT_SELECT_SUBCONTRACTS]
(
    @FeedMillID		char(10),
    @SequenceNumber	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT C.ContractID,
       C.CornProducerID,
       C.ContractNumber,
       C.CommodityID,
       C.Priority,
       C.DateEstablished,
	   C.PricingStartDate,
       C.DueDateFrom,
       C.DueDateTo,
       C.Bushels,
       C.Cash,
       C.Premium_Deduct,
       C.PricedBasis,
       C.FuturesBasis,
       C.Comments,
       C.PayToCornProducerID,
       C.Returned,
       C.ContractStatusID,
       C.ContractTypeID,
       C.Futures,
       C.BasisYear,
       C.BasisMonth,
       C.FuturesYear,
       C.FuturesMonth,
       C.CrmContractID,
       CAST(0 AS bit) AS HasSubcontracts,
       C._RowVersion,
       CT.Name AS ContractTypeName,
       C.ChangeReasonID,
       C.ContractAdjustment,
       C.SettlementDate,
       C.Offer,
       C.DeferredPaymentDate,
       C.LastContractTypeID,
       C.ContractTypeChangeDate,
       C.OriginalContractNumber,
       C.CreatedDateTime,
       C.CreatedBy,
       C.UpdatedDateTime,
       C.UpdatedBy,
       C.HTAContract,
       C.SubProducerName  
FROM dbo.cft_CONTRACT C
INNER JOIN dbo.cft_CONTRACT_TYPE CT ON C.ContractTypeID = CT.ContractTypeID
WHERE C.FeedMillID = @FeedMillID AND C.SubsequenceNumber IS NOT NULL AND C.SequenceNumber = @SequenceNumber
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CONTRACT_SELECT_SUBCONTRACTS] TO [db_sp_exec]
    AS [dbo];

