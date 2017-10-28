
-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_Mort_rpt1_rg
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
-- 2/25/2016, BMD, Excluded SBF PigGroups from report
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_Mort_rpt1_rg]

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



CREATE TABLE  #mortalityrpt1  (
	[picyear_week] [char](6) ,
	[phase] [char](3) ,
	sysmortality float,
	sitemortality float,
	flowmortality float,
    sitecontactid char(6),
    targetmortality float 
	)
	
insert into #mortalityrpt1	
select ss.picyear_week, ss.phase, ss.sysmortality, NULL as sitemortality, NULL as flowmortality, '' as sitecontactid, NULL as targetmortality
from cft_RPT_SLF_sys_sea_DW ss (nolock)
where ss.phase = @phase
  and ss.picyear_week between @enddate and @picyear_week
union
select ww.picyear_week
,@phase
,  null as sysmortality, NULL as sitemortality, NULL as flowmortality, '' as sitecontactid, ss.TargetLineValue as targetmortality
from (select distinct picweek, picyear, picyear_week from [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo]) ww
left join (select max(TargetLineValue) TargetLineValue, picweek, picyear, targetlinetypeid from [CFApp_PigManagement].[dbo].[cft_TARGET_LINE] group by targetlinetypeid,picyear, picweek) ss
	on isnull(ss.picweek,ww.picweek) = ww.picweek and ss.picyear = ww.picyear 
	and ss.targetlinetypeid = (case when @phase = 'NUR' then 3 when @phase = 'FIN' then 13 when @phase = 'WTF' then 30 end)
where 1=1 --ww.picyear = '2013'
  and ww.picyear_week between @enddate and @picyear_week
union
select site.picyear_week, site.phase,  NULL, site.mortality as sitemortality, NULL, site.sitecontactid, NULL as targetmortality
from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW] site (nolock)
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=site.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
where site.phase = @phase
  and site.picyear_week between @enddate and @picyear_week
  and site.sitecontactid = @sitecontactid
 union
select flow.picyear_week,  flow.phase,  NULL as sysmortality, NULL as sitemortality,flow.mortality as  flowmortality, flow.sitecontactid, NULL as targetmortality
from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=flow.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
where  flow.phase = @phase
  and  flow.picyear_week between @enddate and @picyear_week
  and  flow.sitecontactid <> @sitecontactid
  and  flow.reportinggroupid = @reportinggroupid
order by ss.picyear_week desc

select rpt1.*
,mn.minmort - (mn.minmort*.005) minmort
,mx.maxmort + (mx.maxmort*.005) maxmort
from #mortalityrpt1 rpt1
left join (select xx.phase, min(xx.minmort) minmort
		   from 
		   (select phase, min(sysmortality) minmort from #mortalityrpt1 group by phase
		   union
			select phase, min(sitemortality) minmort from #mortalityrpt1 group by phase
		   union
			select phase, min(flowmortality) minmort from #mortalityrpt1 group by phase
		   union
			select phase, min(targetmortality) minmort from #mortalityrpt1 group by phase
		   ) xx
		   group by phase) mn
	on mn.phase = rpt1.phase
left join (select xx.phase, max(xx.maxmort) maxmort
		   from 
		   (select phase, max(sysmortality) maxmort from #mortalityrpt1 group by phase
		   union
			select phase, max(sitemortality) maxmort from #mortalityrpt1 group by phase
		   union
			select phase, max(flowmortality) maxmort from #mortalityrpt1 group by phase
		   union
			select phase, max(targetmortality) maxmort from #mortalityrpt1 group by phase
		   ) xx
		   group by phase) mx
	on mx.phase = rpt1.phase
	
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_Mort_rpt1_rg] TO [CorpReports]
    AS [dbo];

