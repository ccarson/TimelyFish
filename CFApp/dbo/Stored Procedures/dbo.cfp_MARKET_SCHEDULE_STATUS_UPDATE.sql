-- =======================================================
-- Author:		<Brian Cesafsky>
-- Create date: <12/28/2007>
-- Description:	<Updates a Market Schedule Status record>
-- =======================================================
CREATE PROCEDURE [dbo].[cfp_MARKET_SCHEDULE_STATUS_UPDATE]
(
	@UpdatedDateTime					smalldatetime,
	@UpdatedProgram						char(8),
	@UpdatedUser						char(10),
	@PigSystemID						char(2),
	@StatusID							char(2),
	@TypeID								char(2),
	@SundayDate							smalldatetime
)	
AS
BEGIN
	Update [$(SolomonApp)].dbo.cftPMWeekStatus 
	set PMStatusID = @StatusID
		, Lupd_DateTime = @UpdatedDateTime
		, Lupd_Prog = @UpdatedProgram
		, Lupd_User = @UpdatedUser
	where WeekOfDate = @SundayDate 
	and PigSystemID = @PigSystemID
	and PMTypeID = @TypeID 
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_SCHEDULE_STATUS_UPDATE] TO [db_sp_exec]
    AS [dbo];

