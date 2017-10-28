









-- ==================================================================
-- Author:		Steve Ripley
-- Create date: 02/13/2015
-- Description:	Returns closeout picyear_week list for a inputted reporting group
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_report_rptgrp_closeout_PicYear_Week_list]
	@reportinggroupid int
AS


	-----------------------------------------------------------------
	-- Report Data
	-----------------------------------------------------------------
select distinct dw.reportinggroupid, dw.picyear_week 
from [dbo].[cft_rpt_pig_master_group_dw] dw (nolock)
where dw.reportinggroupid = @reportinggroupid
order by dw.picyear_week desc












