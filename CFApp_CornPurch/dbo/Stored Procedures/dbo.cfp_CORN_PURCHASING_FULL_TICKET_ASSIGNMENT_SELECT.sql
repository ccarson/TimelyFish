
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 05/01/2008
-- Description:	Selects all FullTicketAssignment records
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_FULL_TICKET_ASSIGNMENT_SELECT
(
    @TicketID int
)
AS
BEGIN
SET NOCOUNT ON;


SELECT FTA.FullTicketAssignmentID, 
       FTA.CornProducerID,
       V.RemitNAme AS CornProducerName,
       FTA.Assignment,
       FTA.CreatedDateTime,
       FTA.CreatedBy,
       FTA.UpdatedDateTime,
       FTA.UpdatedBy
FROM dbo.cft_FULL_TICKET_ASSIGNMENT FTA
INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = FTA.CornProducerID
WHERE TicketID = @TicketID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_FULL_TICKET_ASSIGNMENT_SELECT] TO [db_sp_exec]
    AS [dbo];

