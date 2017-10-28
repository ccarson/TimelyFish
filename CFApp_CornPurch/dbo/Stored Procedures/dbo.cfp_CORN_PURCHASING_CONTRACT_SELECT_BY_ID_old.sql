

-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 03/07/2008
-- Description:	Selects contract record by id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_CONTRACT_SELECT_BY_ID_old]
(
    @ContractID		int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT C.FeedMillID,
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
                        AND C.SubsequenceNumber IS NULL
                 ) 

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
       C.UpdatedBy 
FROM dbo.cft_CONTRACT C
INNER JOIN dbo.cft_CONTRACT_TYPE CT ON C.ContractTypeID = CT.ContractTypeID
WHERE C.ContractID = @ContractID
END

