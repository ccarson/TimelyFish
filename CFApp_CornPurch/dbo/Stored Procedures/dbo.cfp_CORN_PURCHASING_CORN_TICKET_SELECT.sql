
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 04/28/2008
-- Description:	Selects all CornTicket records
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_CORN_TICKET_SELECT
AS
BEGIN
SET NOCOUNT ON;

SELECT DISTINCT 
       CT.TicketID,
       CT.TicketNumber,
       CT.FeedMillID,
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
       CASE WHEN PT.PartialTicketID IS NULL THEN 'Not Sent' ELSE 'Sent' END AS SentToPartial
FROM dbo.cft_CORN_TICKET CT
INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = CT.CornProducerID
INNER JOIN dbo.cft_COMMODITY CO ON CO.Name = CT.Commodity -- display only WEM tickets that have a commodity type equal to one of the commodities in the Commodity table
LEFT OUTER JOIN dbo.cft_FULL_TICKET_ASSIGNMENT FTA ON CT.TicketID = FTA.TicketID
LEFT OUTER JOIN dbo.cft_PARTIAL_TICKET PT ON PT.FullTicketID = CT.TicketID


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CORN_TICKET_SELECT] TO [db_sp_exec]
    AS [dbo];

