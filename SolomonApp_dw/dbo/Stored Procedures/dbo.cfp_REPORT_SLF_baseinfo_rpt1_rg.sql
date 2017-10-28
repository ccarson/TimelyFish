
-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_baseinfo_rpt1_rg
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
-- 2/25/2016, BMD, Excluded SBF PigGroups from report
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_baseinfo_rpt1_rg]
@PicYear_Week char(6), @SiteContactid char(6)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @phase char(3)
	
select top 1 @phase = phase from cft_rpt_pig_master_group_dw mpg (nolock)
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=mpg.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
where picyear_week = @picyear_week and mpg.sitecontactid = @sitecontactid

	DECLARE @EndDate char(6)
	
select @enddate = picyear_week
from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK)
where daydate = (select top 1 DATEADD(d,-364,weekofdate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK) where PicYear_week = @picyear_week)

	DECLARE @reportinggroupid int
	
select @reportinggroupid = reportinggroupid from [dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=flow.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
where picyear_week = @picyear_week and phase = @phase and flow.sitecontactid = @sitecontactid

select dw.SvcManager, dw.SrSvcManager, c.contactname as sitename, rg.reporting_group_description 
, dw.phase, dw.picyear_week
from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  dw (nolock)
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=dw.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
inner join [$(CentralData)].dbo.contact c (nolock)
	on c.solomoncontactid = dw.sitecontactid
left join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_reporting_group] rg (nolock)
	on rg.reportinggroupid = dw.reportinggroupid
where  dw.phase = @phase
  and  dw.picyear_week = @picyear_week
  and  dw.sitecontactid = @sitecontactid
  and  dw.reportinggroupid = @reportinggroupid
  
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_baseinfo_rpt1_rg] TO [db_sp_exec]
    AS [dbo];

