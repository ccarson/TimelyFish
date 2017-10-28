CREATE FUNCTION 
	dbo.cff_tvf_CORN_PURCHASING_GET_CORN_PRICE_FOR_TICKET( 
		@PartialTicketID AS int ) 
RETURNS TABLE 
AS 

RETURN

SELECT 
	CornPrice 	=	CASE 
						WHEN pTicket.PaymentTypeID = 2 AND contract.Futures IS NOT NULL AND contract.PricedBasis IS NOT NULL THEN contract.Futures + contract.PricedBasis
						WHEN pTicket.QuoteID IS NOT NULL THEN quote.Price
						ELSE dailyPrice.CornPrice 
					END 
FROM 
	dbo.cft_PARTIAL_TICKET AS pTicket 
INNER JOIN 
	dbo.cft_CORN_TICKET AS fullTicket 
		ON fullTicket.TicketID = pTicket.FullTicketID
LEFT JOIN 
	dbo.cft_CONTRACT AS contract 
		ON contract.ContractID = pTicket.ContractID
LEFT JOIN 
	dbo.cft_QUOTE AS quote 
		ON quote.QuoteID = pTicket.QuoteID
CROSS APPLY( 
	SELECT TOP 1 
		CornPrice	=	pDetail.Price 
	FROM 
		dbo.cft_DAILY_PRICE_DETAIL AS pDetail
	INNER JOIN
		dbo.cft_DAILY_PRICE AS dPrice 
			ON dPrice.DailyPriceID = pDetail.DailyPriceID 
	WHERE CAST( pTicket.DeliveryDate AS DATE ) >= dPrice.Date 
		AND dPrice.Approved = 1 
		AND dPrice.FeedMillID = fullTicket.FeedMillID
	ORDER BY 
		dPrice.Date DESC, pDetail.DailyPriceDetailID ) AS dailyPrice
WHERE 
	pTicket.PartialTicketID = @PartialTicketID ;