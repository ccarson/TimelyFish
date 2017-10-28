
-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 03/05/2010
-- Description:	Returns data for the Closed Group report
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_report_PicYear_Week_less_2month_list]
AS


	-----------------------------------------------------------------
	-- Report Data
	-----------------------------------------------------------------
select distinct picyear_week 
from  dbo.cftDayDefinition_WithWeekInfo dw
where daydate between '2001-01-01 00:00:00'and  dateadd(ww,-8,getdate())
order by picyear_week desc



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_report_PicYear_Week_less_2month_list] TO [CorpReports]
    AS [dbo];

