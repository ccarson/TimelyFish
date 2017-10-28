
-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FE_rpt1_rg
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
-- 2/25/2016, BMD, Excluded SBF PigGroups from report
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FE_rpt1_rg]
@PicYear_Week char(6), @SiteContactid char(6)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @phase char(3)
	
select top 1 @phase = phase from cft_rpt_pig_group_dw mpg (nolock)
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

CREATE TABLE  #ferpt1  (
	[picyear_week] [char](6) ,
	[phase] [char](3) ,
	sysadjfe float,
	siteadjfe float,
	flowadjfe float,
    sitecontactid char(6),
    targetfe float 
	)
	
insert into #ferpt1	
select ss.picyear_week, ss.phase, ss.sysadjfe, NULL as siteadjfe, NULL as flowadjfe, '' as sitecontactid, NULL as targetfe
from cft_RPT_SLF_sys_sea_DW ss (nolock)
where ss.phase = @phase
  and ss.picyear_week between @enddate and @picyear_week
union
select distinct dd.picyear_week, @phase, null as sysadjadg, null as siteadjadg, null as flowadjadg, '' as sitecontactid, s1.targetlinevalue*wa.adjfeed_consumption as targetfe
	from [CFApp_PigManagement].[dbo].[cft_TARGET_LINE] s1
	cross join  dbo.cft_weekly_adjustments wa (nolock)
	inner join [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo] dd
		on dd.picweek = wa.picweek and dd.picyear = s1.picyear
where dd.picyear_week between @enddate and @picyear_week
  and s1.targetlinetypeid = (case when @phase = 'NUR' then 2 when @phase = 'FIN' then 12 when @phase = 'WTF' then 29 end)
union
select site.picyear_week, site.phase,  NULL, site.adjfeedtogain as siteadjfe, NULL, site.sitecontactid, NULL as targetfe
from [dbo].[cft_RPT_PIG_MASTER_GROUP_DW] site (nolock)
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=site.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
where site.phase = @phase
  and site.picyear_week between @enddate and @picyear_week
  and site.sitecontactid = @sitecontactid
 union
select flow.picyear_week,  flow.phase,  NULL as sysadjfe, NULL as siteadjfe,flow.adjfeedtogain as  flowadjfe, flow.sitecontactid, NULL as targetfe
from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=flow.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
where  flow.phase = @phase
  and  flow.picyear_week between @enddate and @picyear_week
  and  flow.sitecontactid <> @sitecontactid
  and  flow.reportinggroupid = @reportinggroupid
order by ss.picyear_week desc

select rpt1.*
,mn.minfe - (mn.minfe*.05) minfe
,mx.maxfe + (mx.maxfe*.05) maxfe
from #ferpt1 rpt1
left join (select xx.phase, min(xx.minfe) minfe
		   from 
		   (select phase, min(sysadjfe) minfe from #ferpt1  where sysadjfe > 0 group by phase
		   union
			select phase, min(siteadjfe) minfe from #ferpt1  where siteadjfe > 0 group by phase
		   union
			select phase, min(flowadjfe) minfe from #ferpt1  where flowadjfe > 0 group by phase
		   union
			select phase, min(targetfe) minfe from #ferpt1  where targetfe > 0 group by phase
		   ) xx
		   group by phase) mn
	on mn.phase = rpt1.phase
left join (select xx.phase, max(xx.maxfe) maxfe
		   from 
		   (select phase, max(sysadjfe) maxfe from #ferpt1 group by phase
		   union
			select phase, max(siteadjfe) maxfe from #ferpt1 group by phase
		   union
			select phase, max(flowadjfe) maxfe from #ferpt1 group by phase
		   union
			select phase, max(targetfe) maxfe from #ferpt1 group by phase
		   ) xx
		   group by phase) mx
	on mx.phase = rpt1.phase

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_FE_rpt1_rg] TO [CorpReports]
    AS [dbo];

