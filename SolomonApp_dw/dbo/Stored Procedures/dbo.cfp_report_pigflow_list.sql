







-- ==================================================================
-- Author:		SRipley
-- Create date: 1/5/2013
-- Description:	Returns site/pigflow list
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_report_pigflow_list]
	@picyear_week char(6)
AS

	-----------------------------------------------------------------
	-- Report Data
	-----------------------------------------------------------------
select distinct pf.pigflowid, pf.pigflowdescription 
from cft_rpt_pig_master_group_dw mpg (nolock)
inner join [$(CentralData)].dbo.contact c (nolock)
	on c.solomoncontactid = mpg.sitecontactid
left join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	on pf.pigflowid = mpg.pigflowid
where  mpg.pigflowid > 0
and mpg.picyear_week = @picyear_week
order by pf.pigflowdescription









GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_report_pigflow_list] TO [CorpReports]
    AS [dbo];

