
-- =============================================
-- Author:		Sergey Neskin
-- Create date: 09/10/2008
-- Description:	Select data for Purchases Clearing Reconciliation Report
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_PURCHASES_CLEARING_RECONCILIATION_legacy]
	@FeedMillID char(10),
	@DeliveryDateStart datetime, 
	@DeliveryDateEnd datetime
AS
BEGIN
	SET NOCOUNT ON;

    SELECT 1 AS ClassificationID,
		'Deferred Dry Bushels' AS Classification,
		FM.Name AS FeedMillName,
		V.RemitName AS CornProducerName,
		V.VendId AS VendorID,
		SUM(PT.DryBushels) AS Bushels,
		SUM(PT.DryBushels * dbo.cffn_CORN_PURCHASING_GET_CORN_PRICE_FOR_TICKET(PT.PartialTicketID)) AS Value,
		SUM(PT.DryBushels * IB.ValuePrice) AS ValueAtInventory,
		SUM(PT.DryBushels * dbo.cffn_CORN_PURCHASING_GET_CORN_PRICE_FOR_TICKET(PT.PartialTicketID)) - SUM(PT.DryBushels * IB.ValuePrice) AS 'Difference'
	FROM dbo.cft_PARTIAL_TICKET PT
		INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
		INNER JOIN dbo.cft_CONTRACT C ON C.ContractID = PT.ContractID
		INNER JOIN dbo.cft_CONTRACT_TYPE CT ON CT.ContractTypeID = C.ContractTypeID
		INNER JOIN dbo.cft_FEED_MILL FM ON FM.FeedMillID = FT.FeedMillID
		INNER JOIN dbo.cft_VENDOR V ON V.VendId = PT.CornProducerID
		LEFT JOIN dbo.cft_INVENTORY_BATCH IB ON IB.PartialTicketID = PT.PartialTicketID
	WHERE PT.SentToAccountsPayable <> 1 AND CT.DeferredPayment = 1
		AND (@FeedMillID ='%' OR FM.FeedMillID = @FeedMillID)
		AND PT.DeliveryDate BETWEEN @DeliveryDateStart AND @DeliveryDateEnd
	GROUP BY FM.Name, V.RemitName, V.VendId

	UNION ALL

	SELECT 2 AS ClassificationID,
		'On Hold Bushels' AS Classification,
		FM.Name AS FeedMillName,
		V.RemitName AS CornProducerName,
		V.VendId AS VendorID,
		SUM(PT.DryBushels) AS Bushels,
		SUM(PT.DryBushels * dbo.cffn_CORN_PURCHASING_GET_CORN_PRICE_FOR_TICKET(PT.PartialTicketID)) AS Value,
		SUM(PT.DryBushels * IB.ValuePrice) AS ValueAtInventory,
		SUM(PT.DryBushels * dbo.cffn_CORN_PURCHASING_GET_CORN_PRICE_FOR_TICKET(PT.PartialTicketID)) - SUM(PT.DryBushels * IB.ValuePrice) AS 'Difference'
	FROM dbo.cft_PARTIAL_TICKET PT
		INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
		INNER JOIN dbo.cft_FEED_MILL FM ON FM.FeedMillID = FT.FeedMillID
		INNER JOIN dbo.cft_VENDOR V ON V.VendId = PT.CornProducerID
		LEFT JOIN dbo.cft_CONTRACT C ON C.ContractID = PT.ContractID
		LEFT JOIN dbo.cft_CONTRACT_TYPE CT ON CT.ContractTypeID = C.ContractTypeID
		LEFT JOIN dbo.cft_INVENTORY_BATCH IB ON IB.PartialTicketID = PT.PartialTicketID
	WHERE PT.SentToAccountsPayable <> 1 AND ISNULL(CT.DeferredPayment, 0) <> 1 AND (PT.PaymentTypeID = 1 OR (PT.PaymentTypeID = 2 AND PT.ContractID IS NOT NULL AND ISNULL(CT.PriceLater, 0) <> 1)) 
		AND (@FeedMillID ='%' OR FM.FeedMillID = @FeedMillID)
		AND PT.DeliveryDate BETWEEN @DeliveryDateStart AND @DeliveryDateEnd
	GROUP BY FM.Name, V.RemitName, V.VendId

	UNION ALL


	SELECT 4 AS ClassificationID,
		'UnPriced Bushels' AS Classification,
		FM.Name AS FeedMillName,
		V.RemitName AS CornProducerName,
		V.VendId AS VendorID,
		SUM(PT.DryBushels) AS Bushels,
		SUM(PT.DryBushels * dbo.cffn_CORN_PURCHASING_GET_CORN_PRICE_FOR_TICKET(PT.PartialTicketID)) AS Value,
		SUM(PT.DryBushels * IB.ValuePrice) AS ValueAtInventory,
		SUM(PT.DryBushels * dbo.cffn_CORN_PURCHASING_GET_CORN_PRICE_FOR_TICKET(PT.PartialTicketID)) - SUM(PT.DryBushels * IB.ValuePrice) AS 'Difference'
	FROM dbo.cft_PARTIAL_TICKET PT
		INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
		INNER JOIN dbo.cft_FEED_MILL FM ON FM.FeedMillID = FT.FeedMillID
		INNER JOIN dbo.cft_VENDOR V ON V.VendId = PT.CornProducerID
		LEFT JOIN dbo.cft_CONTRACT C ON C.ContractID = PT.ContractID
		LEFT JOIN dbo.cft_CONTRACT_TYPE CT ON CT.ContractTypeID = C.ContractTypeID
		LEFT JOIN dbo.cft_INVENTORY_BATCH IB ON IB.PartialTicketID = PT.PartialTicketID
	WHERE PT.SentToAccountsPayable <> 1 AND ISNULL(CT.DeferredPayment, 0) <> 1 AND NOT (PT.PaymentTypeID = 1 OR (PT.PaymentTypeID = 2 AND PT.ContractID IS NOT NULL AND ISNULL(CT.PriceLater, 0) <> 1)) 
		AND (@FeedMillID = '%' OR FM.FeedMillID = @FeedMillID)
		AND PT.DeliveryDate BETWEEN @DeliveryDateStart AND @DeliveryDateEnd
	GROUP BY FM.Name, V.RemitName, V.VendId
END
