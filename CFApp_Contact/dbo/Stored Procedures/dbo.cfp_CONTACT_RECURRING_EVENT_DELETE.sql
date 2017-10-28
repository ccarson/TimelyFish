
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 04/17/2008
-- Description:	Deletes a recurring event record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CONTACT_RECURRING_EVENT_DELETE
(
	@RecurringEventID				int
)
AS
BEGIN
	DELETE dbo.cft_CONTACT_RECURRING_EVENT
	WHERE	RecurringEventID = @RecurringEventID				
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_RECURRING_EVENT_DELETE] TO [db_sp_exec]
    AS [dbo];

