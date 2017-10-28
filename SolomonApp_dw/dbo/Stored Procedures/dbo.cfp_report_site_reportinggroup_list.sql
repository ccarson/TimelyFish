

-- ==================================================================
-- Author:		SReipley
-- Create date: 1/5/2013
-- Description:	Returns site/pigflow list
-- 2/25/2016, BMD, Excluded SBF PigGroups from report
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_report_site_reportinggroup_list]
	@picyear_week char(6)
AS

	-----------------------------------------------------------------
	-- Report Data
	-----------------------------------------------------------------
select distinct 
 'Site:     ' + c.contactname + '     ReportingGroup:     ' + rg.reporting_group_description as flowsite
,  mpg.sitecontactid
from cft_rpt_pig_master_group_dw mpg (nolock)
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=mpg.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
inner join [$(CentralData)].dbo.contact c (nolock)
	on c.solomoncontactid = mpg.sitecontactid
left join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_reporting_group] rg (nolock)
	on rg.reportinggroupid = mpg.reportinggroupid
where  1=1
and mpg.picyear_week = @picyear_week
and mpg.phase in ('nur', 'fin','wtf')
order by flowsite

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_report_site_reportinggroup_list] TO [CorpReports]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_report_site_reportinggroup_list] TO [db_sp_exec]
    AS [dbo];

