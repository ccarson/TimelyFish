

-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 05/01/2008
-- Description:	Selects contract records by corn producer ordering them in required way for ticket splitting
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_CONTRACT_SELECT_BY_CORN_PRODUCER_FOR_SPLIT_old]
(
    @CornProducerID	varchar(15),
    @FeedMillID		char(10)
)
AS
BEGIN
SET NOCOUNT ON;

DECLARE @MaxPriority int
SET @MaxPriority = 999999999

SELECT C.ContractID,
       C.FeedMillID,
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
       C.UpdatedBy 
FROM dbo.cft_CONTRACT C
INNER JOIN dbo.cft_CONTRACT_TYPE CT ON C.ContractTypeID = CT.ContractTypeID
LEFT OUTER JOIN (SELECT C1.ContractID,
                        YEAR(C1.DueDateFrom) AS DeliveryYear,
                        MONTH(C1.DueDateFrom) AS DeliveryMonth,
                        ISNULL(C1.Priority, @MaxPriority) AS Priority,
                        C1.DateEstablished,
                        C1.ContractNumber,
                        C1.FeedMillID,
                        C1.SequenceNumber
                 FROM dbo.cft_CONTRACT C1 
                 WHERE C1.SubsequenceNumber IS NULL
                ) AS PC ON PC.FeedMillID = C.FeedMillID 
                       AND PC.SequenceNumber = C.SequenceNumber 

WHERE C.CornProducerID = @CornProducerID AND C.ContractStatusID = 1 AND C.FeedMillID  = @FeedmillID
ORDER BY PC.DeliveryYear,
         PC.DeliveryMonth,
         PC.Priority,
         PC.DateEstablished,
         PC.ContractNumber,
         CASE WHEN PC.ContractID <> C.ContractID THEN 0 ELSE 1 END,
         MONTH(C.DueDateFrom),
         ISNULL(C.Priority, @MaxPriority),
         C.DateEstablished,
         C.ContractNumber
END

