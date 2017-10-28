

CREATE PROCEDURE [dbo].[cfp_REPORT_HAT_HTP_SCHEDULE_SITE_SELECT] 
	
AS
BEGIN
	 
SELECT	'--All--'site, '%'siteid
UNION ALL
	Select 
		distinct site, 
		cast(siteid as varchar(6)) 
	from cfv_HAT_HTP_Schedule 
	order by site asc

END

