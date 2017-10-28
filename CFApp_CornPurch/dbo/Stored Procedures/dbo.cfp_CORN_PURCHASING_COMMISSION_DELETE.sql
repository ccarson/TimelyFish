
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 10/02/2008
-- Description:	Deletes partial ticket commission records
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_COMMISSION_DELETE
(
    @PartialTicketID		int
)
AS
BEGIN
SET NOCOUNT ON;

  DELETE dbo.cft_COMMISSION
  WHERE PartialTicketID = @PartialTicketID


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMISSION_DELETE] TO [db_sp_exec]
    AS [dbo];

