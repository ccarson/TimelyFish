-- ==========================================================================
-- Author:		Brian Cesafsky
-- Create date: 01/15/2010
-- Description:	Creates a set-up record for finisher detail mortality report
-- ==========================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_MORTALITY_DETAIL_FIN_INSERT]
(	
	@DeadsWeeklyLimitPercent			decimal (10,2) 
	,@DeadsFiscalYearLimitPercent		decimal (10,2) 
	,@CreatedBy							varchar(50) 
)
AS
BEGIN
	-- First delete the record
	DELETE from dbo.cft_REPORT_MORTALITY_DETAIL_FIN
	
	INSERT INTO dbo.cft_REPORT_MORTALITY_DETAIL_FIN 
	(
		DeadsWeeklyLimitPercent 
		,DeadsFiscalYearLimitPercent 
		,CreatedBy
	)
	VALUES 
	(
		@DeadsWeeklyLimitPercent 
		,@DeadsFiscalYearLimitPercent
		,@CreatedBy
	)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MORTALITY_DETAIL_FIN_INSERT] TO [db_sp_exec]
    AS [dbo];

