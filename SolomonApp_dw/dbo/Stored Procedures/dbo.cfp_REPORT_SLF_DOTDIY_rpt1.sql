






-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_DOTDIY_rpt1
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_DOTDIY_rpt1]
@PicYear_Week char(6), @SiteContactid char(6)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @phase char(3)
	
select top 1 @phase = phase from cft_rpt_pig_master_group_dw mpg (nolock)
where picyear_week = @picyear_week and sitecontactid = @sitecontactid

	DECLARE @EndDate char(6)
	
select @enddate = picyear_week
from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK)
where daydate = (select top 1 DATEADD(d,-364,weekofdate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK) where PicYear_week = @picyear_week)

	DECLARE @pigflowid int
	
select @pigflowid = pigflowid from [dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
where picyear_week = @picyear_week and phase = @phase and sitecontactid = @sitecontactid


CREATE TABLE  #dotdiyrpt1  (
	[picyear_week] [char](6) ,
	[phase] [char](3) ,
	sysdotdiy float,
	sitedotdiy float,
	flowdotdiy float,
    sitecontactid char(6)
--    ,targetdotdiy float	20130731 sripley they don't use target for dotdiy, remove it
	)
	
insert into #dotdiyrpt1	
select ss.picyear_week, ss.phase, ss.sysdotdiy, NULL as sitedotdiy, NULL as flowdotdiy, '' as sitecontactid	--, NULL as targetdotdiy
from cft_RPT_SLF_sys_sea_DW ss (nolock)
where ss.phase = @phase
  and ss.picyear_week between @enddate and @picyear_week
union
--select ww.picyear_week
--,@phase
--,  null as sysdotdiy, NULL as sitedotdiy, NULL as flowdotdiy, '' as sitecontactid, ss.TargetLineValue as targetdotdiy
--from (select distinct picweek, picyear, picyear_week from [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo]) ww
--left join (select max(TargetLineValue) TargetLineValue, picweek, picyear, targetlinetypeid from [CFApp_PigManagement].[dbo].[cft_TARGET_LINE] group by targetlinetypeid,picyear, picweek) ss
--	on isnull(ss.picweek,ww.picweek) = ww.picweek and ss.picyear = ww.picyear 
--	and ss.targetlinetypeid = (case when @phase = 'NUR' then 1 when @phase = 'FIN' then 11 when @phase = 'WTF' then 28 end)
--where 1=1 --ww.picyear = '2013'
--  and ww.picyear_week between @enddate and @picyear_week
--union
select site.picyear_week, site.phase,  NULL, site.dotdiy as sitedotdiy, NULL, sitecontactid	--, NULL as targetdotdiy
from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW] site (nolock)
where site.phase = @phase
  and site.picyear_week between @enddate and @picyear_week
  and site.sitecontactid = @sitecontactid
 union
select flow.picyear_week,  flow.phase,  NULL as sysdotdiy, NULL as sitedotdiy,flow.dotdiy as  flowdotdiy, sitecontactid	--, NULL as targetdotdiy
from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
where  flow.phase = @phase
  and  flow.picyear_week between @enddate and @picyear_week
  and  flow.sitecontactid <> @sitecontactid
  and  flow.pigflowid = @pigflowid
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
    ON OBJECT::[dbo].[cfp_REPORT_SLF_DOTDIY_rpt1] TO [CorpReports]
    AS [dbo];

