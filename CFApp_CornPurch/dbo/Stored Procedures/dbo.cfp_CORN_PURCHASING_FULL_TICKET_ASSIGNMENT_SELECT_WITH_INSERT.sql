
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 05/01/2008
-- Description:	Selects all FullTicketAssignment records for given ticket
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_FULL_TICKET_ASSIGNMENT_SELECT_WITH_INSERT
(
    @TicketID int
)
AS
BEGIN
SET NOCOUNT ON;

IF NOT EXISTS (SELECT 1 
               FROM dbo.cft_FULL_TICKET_ASSIGNMENT 
               WHERE TicketID = @TicketID)
BEGIN
  --return fake assignment, 100% to ticket's CornProducer
  SELECT 0 AS FullTicketAssignmentID,
         CT.CornProducerID,
         100.00 AS Assignment,
         getdate() AS CreatedDateTime,
         CT.CreatedBy,
         NULL AS UpdatedDateTime,
         NULL AS UpdatedBy
  FROM dbo.cft_CORN_TICKET CT
  INNER JOIN dbo.cft_CORN_PRODUCER CP ON CP.CornProducerID = CT.CornProducerID
  INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = CT.CornProducerID
  WHERE CT.TicketID = @TicketID

END ELSE BEGIN

  SELECT FullTicketAssignmentID, 
         CornProducerID,
         Assignment,
         CreatedDateTime,
         CreatedBy,
         UpdatedDateTime,
         UpdatedBy
  FROM dbo.cft_FULL_TICKET_ASSIGNMENT
  WHERE TicketID = @TicketID
END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_FULL_TICKET_ASSIGNMENT_SELECT_WITH_INSERT] TO [db_sp_exec]
    AS [dbo];

