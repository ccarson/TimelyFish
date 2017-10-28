















-- ==================================================================
-- Author:		SRipley
-- Create date: 2/2/2015
-- Description:	Returns last closeout for a site/reportinggroup
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_report_active_sites_list]
AS

	-----------------------------------------------------------------
	-- Report Data
	-----------------------------------------------------------------
	
select distinct c.solomoncontactid as SiteContactid, c.contactname 
from [$(CentralData)].dbo.contact c (nolock)
where c.statustypeid = 1 and c.contacttypeid = 4
order by c.contactname 


--select c.contactid, c.contactname, rg.reportinggroupid, rg.reporting_group_description
--from cft_rpt_pig_master_group_dw mpg (nolock)
--inner join [$(CentralData)].dbo.contact c (nolock)
--	on c.solomoncontactid = mpg.sitecontactid
--inner join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_reporting_group] rg (nolock)
--	on rg.reportinggroupid = mpg.reportinggroupid
--order by c.contactname
















