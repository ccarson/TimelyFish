
-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_DOTDIY_rpt1_rg
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
-- 2/25/2016, BMD, Excluded SBF PigGroups from report
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_DOTDIY_rpt1_rg]
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


CREATE TABLE  #dotdiyrpt1  (
	[picyear_week] [char](6) ,
	[phase] [char](3) ,
	sysdotdiy float,
	sitedotdiy float,
	flowdotdiy float,
    sitecontactid char(6)
	)
	
insert into #dotdiyrpt1	
select ss.picyear_week, ss.phase, ss.sysdotdiy, NULL as sitedotdiy, NULL as flowdotdiy, '' as sitecontactid	--, NULL as targetdotdiy
from cft_RPT_SLF_sys_sea_DW ss (nolock)
where ss.phase = @phase
  and ss.picyear_week between @enddate and @picyear_week
union
select site.picyear_week, site.phase,  NULL, site.dotdiy as sitedotdiy, NULL, site.sitecontactid	--, NULL as targetdotdiy
from [dbo].[cft_RPT_PIG_MASTER_GROUP_DW] site (nolock)
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=site.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
where site.phase = @phase
  and site.picyear_week between @enddate and @picyear_week
  and site.sitecontactid = @sitecontactid
 union
select flow.picyear_week,  flow.phase,  NULL as sysdotdiy, NULL as sitedotdiy,flow.dotdiy as  flowdotdiy, flow.sitecontactid	--, NULL as targetdotdiy
from [dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=flow.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
where  flow.phase = @phase
  and  flow.picyear_week between @enddate and @picyear_week
  and  flow.sitecontactid <> @sitecontactid
  and  flow.reportinggroupid = @reportinggroupid
order by ss.picyear_week desc

select rpt1.*
,mn.mindotdiy - (mn.mindotdiy*.1) mindotdiy
,mx.maxdotdiy + (mx.maxdotdiy*.1) maxdotdiy
from #dotdiyrpt1 rpt1
left join (select xx.phase, min(xx.mindotdiy) mindotdiy
		   from 
		   (select phase, min(sysdotdiy) mindotdiy from #dotdiyrpt1 group by phase
		   union
			select phase, min(sitedotdiy) mindotdiy from #dotdiyrpt1 group by phase
		   union
			select phase, min(flowdotdiy) mindotdiy from #dotdiyrpt1 group by phase
		 --  union
			--select phase, min(targetdotdiy) mindotdiy from #dotdiyrpt1 group by phase
		   ) xx
		   group by phase) mn
	on mn.phase = rpt1.phase
left join (select xx.phase, max(xx.maxdotdiy) maxdotdiy
		   from 
		   (select phase, max(sysdotdiy) maxdotdiy from #dotdiyrpt1 group by phase
		   union
			select phase, max(sitedotdiy) maxdotdiy from #dotdiyrpt1 group by phase
		   union
			select phase, max(flowdotdiy) maxdotdiy from #dotdiyrpt1 group by phase
		 --  union
			--select phase, max(targetdotdiy) maxdotdiy from #dotdiyrpt1 group by phase
		   ) xx
		   group by phase) mx
	on mx.phase = rpt1.phase
	
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_DOTDIY_rpt1_rg] TO [CorpReports]
    AS [dbo];

