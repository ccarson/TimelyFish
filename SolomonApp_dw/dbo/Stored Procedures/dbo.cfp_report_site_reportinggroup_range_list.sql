


-- ==================================================================
-- Author:		SRipley
-- Create date: 1/5/2013
-- Description:	Returns site/pigflow list
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_report_site_reportinggroup_range_list]
	@PicBegin char(6), @PicEnd Char(6)
AS

	-----------------------------------------------------------------
	-- Report Data
	-----------------------------------------------------------------
select distinct 
 c.contactname as sitename
,  mpg.sitecontactid
from cft_rpt_pig_master_group_dw mpg (nolock)
inner join [$(CentralData)].dbo.contact c (nolock)
	on c.solomoncontactid = mpg.sitecontactid
left join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_reporting_group] rg (nolock)
	on rg.reportinggroupid = mpg.reportinggroupid
where  1=1 --mpg.reportinggroupid > 0
and mpg.picyear_week between @PicBegin and  @PicEnd
order by c.contactname















GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_report_site_reportinggroup_range_list] TO [CorpReports]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_report_site_reportinggroup_range_list] TO [db_sp_exec]
    AS [dbo];

