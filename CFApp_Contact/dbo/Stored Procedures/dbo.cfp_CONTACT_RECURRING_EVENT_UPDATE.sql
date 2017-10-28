-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 04/03/2008
-- Description:	Updates a record in cft_CONTACT_RECURRING_EVENT
-- ============================================================
CREATE PROCEDURE dbo.cfp_CONTACT_RECURRING_EVENT_UPDATE
(
		@RecurringEventID				int
		,@ContactID						int
		,@EventType						int
		,@Recurring						bit
		,@RecurringWeeklyDay			int
		,@RecurringMonthlyDay			int
		,@RecurringNumberOfBushels		int
		,@SingleEventDate				smalldatetime
		,@Comments						varchar(2000)
		,@UpdatedBy						varchar(50)
)
AS
BEGIN

UPDATE dbo.cft_CONTACT_RECURRING_EVENT
   SET [Recurring] = @Recurring
		,[RecurringWeeklyDay] = @RecurringWeeklyDay
		,[RecurringMonthlyDay] = @RecurringMonthlyDay
		,[RecurringNumberOfBushels] = @RecurringNumberOfBushels
		,[SingleEventDate] = @SingleEventDate
		,[Comments] = @Comments
		,[UpdatedBy] = @UpdatedBy

 WHERE 
	[RecurringEventID] = @RecurringEventID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_RECURRING_EVENT_UPDATE] TO [db_sp_exec]
    AS [dbo];

