

-- ===================================================================
-- Author:  Andrey Derco
-- Create date: 11/12/2008
-- Description: Selects data for Settlement Detail report
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SETTLEMENT_DETAIL]
(
	@FeedMillID 	varchar(10),
	@Origination	varchar(8),
	@CornProducerID	varchar(15),
	@StartDate 	datetime,
	@EndDate 	datetime
)
AS
BEGIN
SET NOCOUNT ON;

  SELECT FM.Name AS FeedMillName,
         V.RemitName AS CornProducerName,
         FT.TicketNumber,
         SUM(PT.DryBushels) AS DryBushels,
         FT.DeliveryDate,
         S.PaymentDate,
         S.NetPaymentPerBushel / PT.DryBushels AS NetPaymentPerBushel
  FROM dbo.cft_SETTLEMENT S
    INNER JOIN dbo.cft_PARTIAL_TICKET PT ON S.PartialTicketID = PT.PartialTicketID
    INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
    INNER JOIN dbo.cft_FEED_MILL FM ON FM.FeedMillID = FT.FeedMillID
    INNER JOIN dbo.cft_CORN_PRODUCER CP ON CP.CornProducerID = ISNULL(PT.DeliveryCornProducerID, PT.CornProducerID)
    INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = CP.CornProducerID
    LEFT OUTER JOIN dbo.cft_CONTRACT C ON C.ContractID = PT.ContractID
    LEFT OUTER JOIN dbo.cft_CONTRACT_TYPE CT ON CT.ContractTypeID = C.ContractTypeID
WHERE FT.FeedMillID LIKE @FeedMillID
  AND PT.CornProducerID LIKE @CornProducerID
  AND S.PaymentDate BETWEEN @StartDate AND @EndDate
  AND ( @Origination = 'All' 
        OR (@Origination = 'Producer' AND (CT.CRM = 1 OR ISNULL(CP.Elevator,0) = 0)) 
        OR (@Origination = 'Elevator' AND ISNULL(CT.CRM,0) = 0 AND CP.Elevator = 1)
      )
GROUP BY FM.Name,
         V.RemitName,
         FT.TicketNumber,
         FT.DeliveryDate,
         S.PaymentDate,
         S.NetPaymentPerBushel  / PT.DryBushels
ORDER BY 5,3

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SETTLEMENT_DETAIL] TO [db_sp_exec]
    AS [dbo];

