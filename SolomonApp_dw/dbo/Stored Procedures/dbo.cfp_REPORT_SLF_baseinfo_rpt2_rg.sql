








-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_baseinfo_rpt2_rg
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
create PROCEDURE [dbo].[cfp_REPORT_SLF_baseinfo_rpt2_rg]
@PicYear_Week char(6), @phase char(3), @reportinggroupid int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @EndDate char(6)
	
select @enddate = picyear_week
from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK)
where daydate = (select top 1 DATEADD(d,-364,weekofdate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK) where PicYear_week = @picyear_week)


select dw.SvcManager, dw.SrSvcManager, c.contactname as sitename, rg.reporting_group_description
, dw.phase, dw.picyear_week
from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  dw (nolock)
inner join [$(CentralData)].dbo.contact c (nolock)
	on c.solomoncontactid = dw.sitecontactid
inner join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_reporting_group] rg (nolock)
	on rg.reportinggroupid = dw.reportinggroupid
where  dw.phase = @phase
  and  dw.picyear_week = @picyear_week
--  and  dw.sitecontactid = @sitecontactid
  and  dw.reportinggroupid = @reportinggroupid
  
END















GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_baseinfo_rpt2_rg] TO [db_sp_exec]
    AS [dbo];

