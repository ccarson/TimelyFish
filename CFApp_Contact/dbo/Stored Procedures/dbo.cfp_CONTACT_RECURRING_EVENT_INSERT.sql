-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 04/03/2008
-- Description:	Inserts a record into cft_CONTACT_RECURRING_EVENT
-- ============================================================
CREATE PROCEDURE dbo.cfp_CONTACT_RECURRING_EVENT_INSERT
(
		@RecurringEventID				int		OUT
		,@ContactID						int
		,@EventType						int
		,@Recurring						bit
		,@RecurringWeeklyDay			int
		,@RecurringMonthlyDay			int
		,@RecurringNumberOfBushels		int
		,@SingleEventDate				smalldatetime
		,@Comments						varchar(2000)
		,@CreatedBy						varchar(50)
)
AS
BEGIN
INSERT INTO [cft_CONTACT_RECURRING_EVENT]
(
		[ContactID]
	   ,[EventType]
	   ,[Recurring]
	   ,[RecurringWeeklyDay]
	   ,[RecurringMonthlyDay]
	   ,[RecurringNumberOfBushels]
	   ,[SingleEventDate]
	   ,[Comments]
	   ,[CreatedBy]
)
VALUES
(
		@ContactID
		,@EventType
		,@Recurring
		,@RecurringWeeklyDay
		,@RecurringMonthlyDay
		,@RecurringNumberOfBushels
		,@SingleEventDate
		,@Comments
		,@CreatedBy
	)
	set @RecurringEventID = @@identity
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_RECURRING_EVENT_INSERT] TO [db_sp_exec]
    AS [dbo];

