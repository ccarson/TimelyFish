
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 04/29/2008
-- Description: Deletes FullTicketAssignment records for given ticket.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_FULL_TICKET_ASSIGNMENT_DELETE]
(
    @TicketID int
)
AS
BEGIN
  SET NOCOUNT ON

  DELETE dbo.cft_FULL_TICKET_ASSIGNMENT
  WHERE TicketID = @TicketID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_FULL_TICKET_ASSIGNMENT_DELETE] TO [db_sp_exec]
    AS [dbo];

