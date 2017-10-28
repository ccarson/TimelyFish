-- =======================================================
-- Author:		<Brian Cesafsky>
-- Create date: <12/28/2007>
-- Description:	<Inserts a Market Schedule Status record>
-- =======================================================
CREATE PROCEDURE [dbo].[cfp_MARKET_SCHEDULE_STATUS_INSERT]
(
	@CompanyID					        char(10),
	@CreatedDateTime					smalldatetime,
	@CreatedProgram						char(8),
	@CreatedUser						char(10),
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
	INSERT INTO [$(SolomonApp)].dbo.cftPMWeekStatus
	(
		[CpnyID],
		[Crtd_DateTime],
		[Crtd_Prog],
		[Crtd_User],
		[Lupd_DateTime],
		[Lupd_Prog],
		[Lupd_User],
		[PigSystemID],
		[PMStatusID],
		[PMTypeID],
		[WeekOfDate]
	)
	VALUES 
	(	
		@CompanyID,
		@CreatedDateTime,
		@CreatedProgram,
		@CreatedUser,
		@UpdatedDateTime,
		@UpdatedProgram,
		@UpdatedUser,
		@PigSystemID,
		@StatusID,
		@TypeID,
		@SundayDate
	)
END






GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_SCHEDULE_STATUS_INSERT] TO [db_sp_exec]
    AS [dbo];

