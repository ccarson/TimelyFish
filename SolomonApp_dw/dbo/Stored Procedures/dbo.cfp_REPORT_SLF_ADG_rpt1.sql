

-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_ADG_rpt1
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_ADG_rpt1]
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


CREATE TABLE  #adgrpt1  (
	[picyear_week] [char](6) ,
	[phase] [char](3) ,
	sysadjadg float,
	siteadjadg float,
	flowadjadg float,
    sitecontactid char(6),
    targetadg float 
	)
	
insert into #adgrpt1	
--select ss.picyear_week, ss.phase, ss.sysadjadg, NULL as siteadjadg, NULL as flowadjadg, '' as sitecontactid, NULL as targetadg
select ss.picyear_week, ss.phase, ss.seaadjadg as sysadjadg, NULL as siteadjadg, NULL as flowadjadg, '' as sitecontactid, NULL as targetadg
from cft_RPT_SLF_sys_sea_DW ss (nolock)
where ss.phase = @phase
  and ss.picyear_week between @enddate and @picyear_week
union
select distinct dd.picyear_week, @phase, null as sysadjadg, null as siteadjadg, null as flowadjadg, '' as sitecontactid, s1.targetlinevalue*wa.adjwgt_gain as targetADG
	from [CFApp_PigManagement].[dbo].[cft_TARGET_LINE] s1
	cross join  dbo.cft_weekly_adjustments wa (nolock)
	inner join [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo] dd
		on dd.picweek = wa.picweek and dd.picyear = s1.picyear
where dd.picyear_week between @enddate and @picyear_week
and targetlinetypeid = (case when @phase = 'NUR' then 1 when @phase = 'FIN' then 11 when @phase = 'WTF' then 28 end)
--select ww.picyear_week
--,@phase
--,  null as sysadjadg, NULL as siteadjadg, NULL as flowadjadg, '' as sitecontactid, ss.TargetLineValue as targetadg
--from (select distinct picweek, picyear, picyear_week from [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo]) ww
--left join (select max(TargetLineValue) TargetLineValue, picweek, picyear, targetlinetypeid from [CFApp_PigManagement].[dbo].[cft_TARGET_LINE] group by targetlinetypeid,picyear, picweek) ss
--	on isnull(ss.picweek,ww.picweek) = ww.picweek and ss.picyear = ww.picyear 
--	and ss.targetlinetypeid = (case when @phase = 'NUR' then 1 when @phase = 'FIN' then 11 when @phase = 'WTF' then 28 end)
--where 1=1 --ww.picyear = '2013'
--  and ww.picyear_week between @enddate and @picyear_week
union
select site.picyear_week, site.phase,  NULL, site.adjaveragedailygain as siteadjADG, NULL, sitecontactid, NULL as targetadg
from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW] site (nolock)
where site.phase = @phase
  and site.picyear_week between @enddate and @picyear_week
  and site.sitecontactid = @sitecontactid
 union
select flow.picyear_week,  flow.phase,  NULL as sysadjadg, NULL as siteadjadg,flow.adjaveragedailygain as  flowadjADG, sitecontactid, NULL as targetadg
from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
where  flow.phase = @phase
  and  flow.picyear_week between @enddate and @picyear_week
  and  flow.sitecontactid <> @sitecontactid
  and  flow.pigflowid = @pigflowid
order by ss.picyear_week desc

select rpt1.*
,mn.minadg - (mn.minadg*.05) minadg
,mx.maxadg + (mx.maxadg*.05) maxadg
from #adgrpt1 rpt1
left join (select xx.phase, min(xx.minadg) minadg
		   from 
		   (select phase, min(sysadjadg) minadg from #adgrpt1 where sysadjadg > 0 group by phase
		   union
			select phase, min(siteadjadg) minadg from #adgrpt1 where siteadjadg > 0 group by phase
		   union
			select phase, min(flowadjADG) minadg from #adgrpt1 where flowadjadg > 0 group by phase
		   union
			select phase, min(targetADG) minadg from #adgrpt1 where targetADG > 0 group by phase
		   ) xx
		   group by phase) mn
	on mn.phase = rpt1.phase
left join (select xx.phase, max(xx.maxadg) maxadg
		   from 
		   (select phase, max(sysadjadg) maxadg from #adgrpt1 group by phase
		   union
			select phase, max(siteadjadg) maxadg from #adgrpt1 group by phase
		   union
			select phase, max(flowadjADG) maxadg from #adgrpt1 group by phase
		   union
			select phase, max(targetADG) maxadg from #adgrpt1 group by phase
		   ) xx
		   group by phase) mx
	on mx.phase = rpt1.phase


END




















GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_ADG_rpt1] TO [CorpReports]
    AS [dbo];

