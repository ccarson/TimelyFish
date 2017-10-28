-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 01/15/2010
-- Description:	Returns setup values for this report
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_MORTALITY_DETAIL_NUR_SELECT]
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT DeadsWeeklyLimitPercent
		  ,DeadsFiscalYearLimitPercent
	FROM dbo.cft_REPORT_MORTALITY_DETAIL_NUR (NOLOCK)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MORTALITY_DETAIL_NUR_SELECT] TO [db_sp_exec]
    AS [dbo];

