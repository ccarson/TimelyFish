
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 07/25/2008
-- Description:	Selects CornTicket records by feed mill
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_CORN_TICKET_SELECT_BY_FEED_MILL
(
   @FeedMillID 		char(10),
   @TicketStatusID	int,
   @FromDate		datetime,
   @ToDate		datetime
)
AS
BEGIN
SET NOCOUNT ON;

SELECT DISTINCT
       CT.TicketID,
       CT.TicketNumber,
       CT.CornProducerID,
       CT.DeliveryDate,
       CT.SourceFarm,
       CT.SourceFarmBin,
       CT.DestinationFarmBin,
       CT.TicketStatusID,
       CT.PaymentTypeID,
       CT.Commodity,
       CT.CommodityID,
       CT.Moisture,
       CT.ForeignMaterial,
       CT.OilContent,
       CT.TestWeight,
       CT.Gross,
       CT.Net,
       CT.Comments,
       CT.ManuallyEntered,
       CT.SentToDryer,
       CT.TicketReminderNote,
       CT.CornProducerComments,
       CT.CreatedDateTime,
       CT.CreatedBy,
       CT.UpdatedDateTime,
       CT.UpdatedBy,
       ISNULL(FTA.GroupName, '100.00% ' + rtrim(V.RemitName)) AS CornProducerName,
       CASE WHEN CT.TicketStatusID <> 3 THEN 'Not Sent' ELSE 'Sent' END AS SentToPartial
FROM dbo.cft_CORN_TICKET CT
INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = CT.CornProducerID
INNER JOIN dbo.cft_COMMODITY CO ON CO.Name = CT.Commodity -- display only WEM tickets that have a commodity type equal to one of the commodities in the Commodity table
LEFT OUTER JOIN dbo.cft_FULL_TICKET_ASSIGNMENT FTA ON CT.TicketID = FTA.TicketID
WHERE CT.FeedMillID = @FeedMillID
  AND CT.TicketStatusID = @TicketStatusID
  AND CT.DeliveryDate BETWEEN @FromDate AND @ToDate

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CORN_TICKET_SELECT_BY_FEED_MILL] TO [db_sp_exec]
    AS [dbo];

