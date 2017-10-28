

CREATE PROCEDURE [dbo].[cfp_PIC_DATE_STRING_MORTALITY_SELECT]
AS

BEGIN
DECLARE @CurrentPICWeek CHAR(6)

--SELECT @CurrentPICWeek = RIGHT(PicYear,2) + 'WK' + RIGHT('00' + PicWeek,2)
-- 20130115 prior verison of this was returning the incorrect format  12WK1, there seemed to be a change in how the text string was handled.
SELECT @CurrentPICWeek = RIGHT(PicYear,2) + 'WK' + RIGHT('00' + cast(picweek as varchar(2)),2) 
from [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) 
where cast(convert(varchar,getdate() -9,101) as datetime) between WeekOfDate and WeekEndDate

SELECT @CurrentPICWeek AS CurrentPICWeek

END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIC_DATE_STRING_MORTALITY_SELECT] TO [CorpReports]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIC_DATE_STRING_MORTALITY_SELECT] TO [db_sp_exec]
    AS [dbo];

