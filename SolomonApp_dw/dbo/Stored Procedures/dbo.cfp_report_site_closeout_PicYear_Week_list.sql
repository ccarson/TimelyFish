








-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 03/05/2010
-- Description:	Returns data for the Closed Group report
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_report_site_closeout_PicYear_Week_list]
	@SiteContactid char(6)
AS


	-----------------------------------------------------------------
	-- Report Data
	-----------------------------------------------------------------
select distinct dw.SiteContactid, picyear_week 
from [$(CentralData)].dbo.contact c (nolock)
join  [dbo].[cft_rpt_pig_master_group_dw] dw (nolock)
	on sitecontactid = solomoncontactid
where c.contactid = @SiteContactid
order by picyear_week desc











