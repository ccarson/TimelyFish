
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 05/01/2008
-- Description:	Selects all PartialTicket records
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_PARTIAL_TICKET_SELECT_CANNOT_BE_RELEASED
(
  @FeedMillID	char(10)
)
AS
BEGIN
SET NOCOUNT ON;

SELECT PT.PartialTicketID,
	   PT.PartialTicketStatusID,
       PT.TicketNumber,
       PT.FullTicketID,
       PT.ContractID,
       PT.CornProducerID,
       PT.DeliveryCornProducerID, 
       PT.DeliveryDate,
       PT.DryBushels,
       PT.MoistureRateAdj,
       PT.ForeignMaterialRateAdj,
       PT.TestWeightRateAdj,
       PT.DryingRateAdj,
       PT.HandlingRateAdj,
       PT.DeferredPaymentRateAdj,
       PT.MiscAdj,
       PT.MiscAdjNote,
       PT.TicketAdjNote, 
       PT.ContractAdjustmentRate,
       PT.PaymentTypeID,
       PT.QuoteID,
       PT.PaymentTermsID,
       PT.CreatedDateTime,
       PT.CreatedBy,
       PT.UpdatedDateTime,
       PT.UpdatedBy,
       PT.ReadyToBeReleased,
       PT.SentToInventory,
       PT.SentToAccountsPayable,
       C.ContractNumber,
       V.RemitName AS CornProducerName,
       CT.Name AS ContractTypeName,
       PT.WetBushels,
       0 AS CanBeReleasedForPayment,
		CASE WHEN EXISTS( SELECT 1 FROM dbo.cft_FSA_OFFICE_CORN_PRODUCER FOCP 
						  WHERE FOCP.CornProducerID = PT.CornProducerID AND FOCP.FsaPaymentAmount IS NULL)
			THEN 0 ELSE 1 
		END AS IsFsaPaymentAmountFilled,
		CASE WHEN EXISTS( SELECT 1 FROM dbo.cft_FSA_OFFICE_CORN_PRODUCER FOCP 
						  WHERE FOCP.CornProducerID = PT.CornProducerID)
			THEN 1 ELSE 0 
		END AS IsFsaExist
FROM dbo.cft_PARTIAL_TICKET PT
INNER JOIN [$(SolomonApp)].dbo.Vendor V ON PT.CornProducerID = V.VendID
LEFT OUTER JOIN dbo.cft_CONTRACT C ON PT.ContractID = C.ContractID
LEFT OUTER JOIN dbo.cft_CONTRACT_TYPE CT ON CT.ContractTypeID = C.ContractTypeID
INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
WHERE  FT.FeedMillID = @FeedMillID AND (	PT.PaymentTypeID IN (3,4) 
                 							OR PT.ContractID IS NOT NULL AND (C.DeferredPaymentDate IS NOT NULL AND C.DeferredPaymentDate > getdate())
                 							OR PT.ContractID IS NOT NULL AND ISNULL(C.Cash,0) = 0 
                 							OR ((PT.PaymentTypeID = 2) AND (PT.ContractID IS NULL)) )
AND PT.SentToAccountsPayable <> 1

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_PARTIAL_TICKET_SELECT_CANNOT_BE_RELEASED] TO [db_sp_exec]
    AS [dbo];

