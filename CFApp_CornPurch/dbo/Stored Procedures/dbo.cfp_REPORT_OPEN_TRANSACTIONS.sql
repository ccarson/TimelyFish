-- =============================================
-- Author:	Andrey Derco
-- Create date: 10/13/2008
-- Description:	Select data for Delivery Detail Report
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_OPEN_TRANSACTIONS]
(
  @FeedMillIDs 		varchar(1000),
  @CornProducerID	char(15)
)

AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @FeedMills TABLE (FeedMillID char(10))

  INSERT @FeedMills   
  SELECT Value
  FROM dbo.cffn_SPLIT_STRING(@FeedMillIDs, ',')
  
	SELECT	'Deferred Dry Bushels' AS Classification,
		FM.Name AS FeedMillName,
		PT.TicketNumber,
		PT.DryBushels,
		PT.DryBushels * dbo.cffn_CORN_PURCHASING_GET_CORN_PRICE_FOR_TICKET(PT.PartialTicketID) AS Value
	FROM dbo.cft_PARTIAL_TICKET PT
		INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
		INNER JOIN @FeedMills F ON F.FeedMillID = FT.FeedMillID
		INNER JOIN dbo.cft_CONTRACT C ON C.ContractID = PT.ContractID
		INNER JOIN dbo.cft_CONTRACT_TYPE CT ON CT.ContractTypeID = C.ContractTypeID
		INNER JOIN dbo.cft_FEED_MILL FM ON FM.FeedMillID = FT.FeedMillID
		INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = PT.CornProducerID
	WHERE PT.SentToAccountsPayable <> 1 
		AND CT.DeferredPayment = 1
		AND PT.CornProducerID = @CornProducerID

	UNION ALL


	SELECT	'On Hold Bushels' AS Classification,
		FM.Name AS FeedMillName,
		PT.TicketNumber,
		PT.DryBushels,
		PT.DryBushels * dbo.cffn_CORN_PURCHASING_GET_CORN_PRICE_FOR_TICKET(PT.PartialTicketID) AS Value
	FROM dbo.cft_PARTIAL_TICKET PT
		INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
		INNER JOIN @FeedMills F ON F.FeedMillID = FT.FeedMillID
		INNER JOIN dbo.cft_FEED_MILL FM ON FM.FeedMillID = FT.FeedMillID
		LEFT JOIN dbo.cft_CONTRACT C ON C.ContractID = PT.ContractID
		LEFT JOIN dbo.cft_CONTRACT_TYPE CT ON CT.ContractTypeID = C.ContractTypeID
	WHERE PT.SentToAccountsPayable <> 1 
		AND ISNULL(CT.DeferredPayment, 0) <> 1 
		AND (PT.PaymentTypeID = 1 OR (PT.PaymentTypeID = 2 AND PT.ContractID IS NOT NULL AND ISNULL(CT.PriceLater, 0) <> 1)) 
		AND PT.CornProducerID = @CornProducerID

	UNION ALL


	SELECT	'UnPriced Bushels' AS Classification,
		FM.Name AS FeedMillName,
		PT.TicketNumber,
		PT.DryBushels,
		PT.DryBushels * dbo.cffn_CORN_PURCHASING_GET_CORN_PRICE_FOR_TICKET(PT.PartialTicketID) AS Value
	FROM dbo.cft_PARTIAL_TICKET PT
		INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
		INNER JOIN @FeedMills F ON F.FeedMillID = FT.FeedMillID
		INNER JOIN dbo.cft_FEED_MILL FM ON FM.FeedMillID = FT.FeedMillID
		LEFT JOIN dbo.cft_CONTRACT C ON C.ContractID = PT.ContractID
		LEFT JOIN dbo.cft_CONTRACT_TYPE CT ON CT.ContractTypeID = C.ContractTypeID
	WHERE PT.SentToAccountsPayable <> 1 
		AND ISNULL(CT.DeferredPayment, 0) <> 1 
		AND NOT (PT.PaymentTypeID = 1 OR (PT.PaymentTypeID = 2 AND PT.ContractID IS NOT NULL AND ISNULL(CT.PriceLater, 0) <> 1)) 
		AND PT.CornProducerID = @CornProducerID
  

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_OPEN_TRANSACTIONS] TO [db_sp_exec]
    AS [dbo];

