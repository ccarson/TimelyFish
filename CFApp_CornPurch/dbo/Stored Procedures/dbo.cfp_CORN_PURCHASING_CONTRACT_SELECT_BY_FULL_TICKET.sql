
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 05/29/2008
-- Description:	Selects contract records by full ticket (contractc can be found through partial tickets) 
-- ===================================================================
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-07-31  Doran Dahle Added SubProducerName,HTAContract to the results.
						

===============================================================================
*/
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_CONTRACT_SELECT_BY_FULL_TICKET]
(
    @TicketID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT C.ContractID,
       C.FeedMillID,
       C.CornProducerID,
       C.ContractNumber,
       C.SequenceNumber,
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
       CAST(
         CASE WHEN 
           EXISTS(SELECT TOP 1 1 
                  FROM dbo.CFT_CONTRACT C1 
                  WHERE C1.FeedMillID = C.FeedMillID 
                        AND C1.SequenceNumber = C.SequenceNumber 
                        AND C1.SubsequenceNumber IS NOT NULL
                        AND C.SubsequenceNumber IS NULL) 
         THEN 1 ELSE 0 END
       AS bit) AS HasSubcontracts,
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
INNER JOIN dbo.cft_PARTIAL_TICKET PT ON  PT.ContractID = C.ContractID
INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
WHERE FT.TicketID = @TicketID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CONTRACT_SELECT_BY_FULL_TICKET] TO [db_sp_exec]
    AS [dbo];

