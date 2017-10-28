
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 09/22/2008
-- Description:	Selects CornTicket records' groups
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_CORN_TICKET_SELECT_GROUPS
(
   @FeedMillID char(10)
)
AS
BEGIN
SET NOCOUNT ON;





SELECT CT.CornProducerID,
       CT.TicketStatusID,
       ISNULL(FTA.GroupName, '100.00% ' + rtrim(V.RemitName)) AS CornProducerName
FROM dbo.cft_CORN_TICKET CT
INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = CT.CornProducerID
INNER JOIN dbo.cft_COMMODITY CO ON CO.Name = CT.Commodity -- display only WEM tickets that have a commodity type equal to one of the commodities in the Commodity table
LEFT OUTER JOIN dbo.cft_FULL_TICKET_ASSIGNMENT FTA ON CT.TicketID = FTA.TicketID
WHERE CT.FeedMillID = @FeedMillID
GROUP BY CT.CornProducerID,
         CT.TicketStatusID,
         ISNULL(FTA.GroupName, '100.00% ' + rtrim(V.RemitName))


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_CORN_TICKET_SELECT_GROUPS] TO [db_sp_exec]
    AS [dbo];

