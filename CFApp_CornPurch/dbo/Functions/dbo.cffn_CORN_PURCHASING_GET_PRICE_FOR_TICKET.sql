
-- =============================================
-- Author:	Andrey Derco
-- Create date: 09/26/2008
-- Description:	Returns priced value(per bushel) for given partial ticket
-- =============================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_GET_PRICE_FOR_TICKET]
(
    @PartialTicketID	int
)
RETURNS decimal(18,4)
AS
BEGIN

  DECLARE @Result decimal(18,4)
  SELECT @Result = CASE 
           WHEN PT.PaymentTypeID = 2 AND C.Futures IS NOT NULL AND C.PricedBasis IS NOT NULL 
                THEN C.Futures + C.Pricedbasis
           WHEN PT.QuoteID IS NOT NULL 
                THEN Q.Price
           ELSE dbo.cffn_CORN_PURCHASING_GET_DAILY_PRICE_BY_FEED_MILL_AND_DATE(FT.FeedMillID, PT.DeliveryDate, DEFAULT, DEFAULT, DEFAULT)
         END
  FROM dbo.cft_PARTIAL_TICKET PT
  INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
  LEFT JOIN dbo.cft_CONTRACT C ON C.ContractID = PT.ContractID
  LEFT JOIN dbo.cft_QUOTE Q ON Q.QuoteID = PT.QuoteID
  WHERE PT.PartialTicketID = @PartialTicketID

  RETURN @Result
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GET_PRICE_FOR_TICKET] TO [db_sp_exec]
    AS [dbo];

