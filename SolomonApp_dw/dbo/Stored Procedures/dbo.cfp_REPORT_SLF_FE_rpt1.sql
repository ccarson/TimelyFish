











-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FE_rpt1
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FE_rpt1]
@PicYear_Week char(6), @SiteContactid char(6)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @phase char(3)
	
select top 1 @phase = phase from cft_rpt_pig_group_dw mpg (nolock)
where picyear_week = @picyear_week and sitecontactid = @sitecontactid

	DECLARE @EndDate char(6)
	
select @enddate = picyear_week
from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK)
where daydate = (select top 1 DATEADD(d,-364,weekofdate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK) where PicYear_week = @picyear_week)

	DECLARE @pigflowid int
	
select @pigflowid = pigflowid from [dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
where picyear_week = @picyear_week and phase = @phase and sitecontactid = @sitecontactid

--select ss.picyear_week, ss.phase, ss.sysadjfe, NULL as siteadjfe, NULL as flowadjfe, '' as sitecontactid, null as targetfe
--from cft_RPT_SLF_sys_sea_DW ss (nolock)
--where ss.phase = @phase
--  and ss.picyear_week between @enddate and @picyear_week
--union
--select site.picyear_week, site.phase,  NULL as sysadjfe, site.adjfeedtogain as siteadjfe, NULL, sitecontactid,null as targetfe
--from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW] site (nolock)
--where site.phase = @phase
--  and site.picyear_week between @enddate and @picyear_week
--  and site.sitecontactid = @sitecontactid
-- union
--select flow.picyear_week,  flow.phase,  NULL as sysadjfe, NULL as siteadjFE,flow.adjfeedtogain as  flowadjFE, sitecontactid, null as targetfe
--from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
--where  flow.phase = @phase
--  and  flow.picyear_week between @enddate and @picyear_week
--  and  flow.sitecontactid <> @sitecontactid
--  and  flow.pigflowid = @pigflowid
-- union
--select ww.picyear_week
--,@phase
--,  null as sysadjfe, NULL as siteadjfe, NULL as flowadjfe, '' as sitecontactid, ss.TargetLineValue as targetfe
--from (select distinct picweek, picyear, picyear_week from [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo]) ww
--left join (select max(TargetLineValue) TargetLineValue, picweek, picyear, targetlinetypeid from [CFApp_PigManagement].[dbo].[cft_TARGET_LINE] group by targetlinetypeid,picyear, picweek) ss
--	on isnull(ss.picweek,ww.picweek) = ww.picweek and ss.picyear = ww.picyear 
--	and ss.targetlinetypeid = (case when @phase = 'NUR' then 2 when @phase = 'FIN' then 12 when @phase = 'WTF' then 29 end)
--where 1=1 --ww.picyear = '2013'
--  and ww.picyear_week between @enddate and @picyear_week
--order by ss.picyear_week desc


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
--select ww.picyear_week
--,@phase
--,  null as sysadjfe, NULL as siteadjfe, NULL as flowadjfe, '' as sitecontactid, ss.TargetLineValue as targetfe
--from (select distinct picweek, picyear, picyear_week from [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo]) ww
--left join (select max(TargetLineValue) TargetLineValue, picweek, picyear, targetlinetypeid from [CFApp_PigManagement].[dbo].[cft_TARGET_LINE] group by targetlinetypeid,picyear, picweek) ss
--	on isnull(ss.picweek,ww.picweek) = ww.picweek and ss.picyear = ww.picyear 
--	and ss.targetlinetypeid = (case when @phase = 'NUR' then 2 when @phase = 'FIN' then 12 when @phase = 'WTF' then 29 end)
--where 1=1 --ww.picyear = '2013'
--  and ww.picyear_week between @enddate and @picyear_week
union
select site.picyear_week, site.phase,  NULL, site.adjfeedtogain as siteadjfe, NULL, sitecontactid, NULL as targetfe
from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW] site (nolock)
where site.phase = @phase
  and site.picyear_week between @enddate and @picyear_week
  and site.sitecontactid = @sitecontactid
 union
select flow.picyear_week,  flow.phase,  NULL as sysadjfe, NULL as siteadjfe,flow.adjfeedtogain as  flowadjfe, sitecontactid, NULL as targetfe
from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
where  flow.phase = @phase
  and  flow.picyear_week between @enddate and @picyear_week
  and  flow.sitecontactid <> @sitecontactid
  and  flow.pigflowid = @pigflowid
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
    ON OBJECT::[dbo].[cfp_REPORT_SLF_FE_rpt1] TO [CorpReports]
    AS [dbo];

