
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 05/23/2008
-- Description:	Deletes PartialTicket record.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_PARTIAL_TICKET_DELETE
(
    @PartialTicketID	int
)
AS
BEGIN
  SET NOCOUNT ON


  DELETE dbo.cft_PARTIAL_TICKET
  WHERE PartialTicketID = @PartialTicketID


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_PARTIAL_TICKET_DELETE] TO [db_sp_exec]
    AS [dbo];

