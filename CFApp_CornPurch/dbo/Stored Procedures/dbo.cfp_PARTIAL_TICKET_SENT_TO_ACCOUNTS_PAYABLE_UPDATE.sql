-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 08/21/2008
-- Description:	Updates a record in cft_PARTIAL_TICKET
-- ============================================================
CREATE PROCEDURE dbo.cfp_PARTIAL_TICKET_SENT_TO_ACCOUNTS_PAYABLE_UPDATE
(
		@SentToAccountsPayable					bit
		,@PartialTicketID						int
		,@UpdatedBy								varchar(50)
)
AS
BEGIN

UPDATE dbo.cft_PARTIAL_TICKET
	SET [SentToAccountsPayable] = @SentToAccountsPayable
		,[UpdatedBy] = @UpdatedBy

	WHERE [PartialTicketID] = @PartialTicketID
	AND ReadyToBeReleased = 1

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PARTIAL_TICKET_SENT_TO_ACCOUNTS_PAYABLE_UPDATE] TO [db_sp_exec]
    AS [dbo];

