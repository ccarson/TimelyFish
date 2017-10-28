









-- ==================================================================
-- Author:		SReipley
-- Create date: 1/5/2013
-- Description:	Returns site/pigflow list
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_report_site_pigflow_range_list]
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
left join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	on pf.pigflowid = mpg.pigflowid
where  mpg.pigflowid > 0
and mpg.picyear_week between @PicBegin and  @PicEnd
order by c.contactname










