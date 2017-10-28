





-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 03/05/2010
-- Description:	Returns data for the Closed Group report
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_report_PicYear_Week_list]
AS


	-----------------------------------------------------------------
	-- Report Data
	-----------------------------------------------------------------
select distinct picyear_week 
from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw
where daydate between '2001-01-01 00:00:00'and  getdate()
order by picyear_week desc









GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_report_PicYear_Week_list] TO [CorpReports]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_report_PicYear_Week_list] TO [db_sp_exec]
    AS [dbo];

