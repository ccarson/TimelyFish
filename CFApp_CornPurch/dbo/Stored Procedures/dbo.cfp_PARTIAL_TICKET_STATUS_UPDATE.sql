-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 08/21/2008
-- Description:	Updates a record in cft_PARTIAL_TICKET
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_PARTIAL_TICKET_STATUS_UPDATE]
(
		@PartialTicketStatusID					int
		,@TicketNumber									varchar(20)
		,@UpdatedBy								varchar(50)
)
AS
BEGIN

UPDATE dbo.cft_PARTIAL_TICKET
   SET [PartialTicketStatusID] = @PartialTicketStatusID
		,[UpdatedBy] = @UpdatedBy

 WHERE 
	[TicketNumber] = @TicketNumber

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PARTIAL_TICKET_STATUS_UPDATE] TO [db_sp_exec]
    AS [dbo];

