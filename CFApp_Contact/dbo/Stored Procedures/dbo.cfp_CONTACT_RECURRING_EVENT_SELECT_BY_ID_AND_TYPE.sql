-- =======================================================
-- Author:		Brian Cesafsky
-- Create date: 05/072008
-- Description:	Returns recurring event for a contact
-- =======================================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_RECURRING_EVENT_SELECT_BY_ID_AND_TYPE]
(
	@ContactID				int,
	@EventType				int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT RecurringEventID
		,ContactID
		,EventType
		,Recurring
		,RecurringWeeklyDay
		,RecurringMonthlyDay
		,RecurringNumberOfBushels
		,SingleEventDate
		,Comments
	FROM dbo.cft_CONTACT_RECURRING_EVENT (NOLOCK)
	WHERE ContactID = @ContactID
		AND EventType = @EventType
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_RECURRING_EVENT_SELECT_BY_ID_AND_TYPE] TO [db_sp_exec]
    AS [dbo];

