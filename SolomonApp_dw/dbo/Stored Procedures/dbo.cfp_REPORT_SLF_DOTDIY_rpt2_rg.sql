








-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_DOTDIY_rpt2_rg
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_DOTDIY_rpt2_rg]
@PicYear_Week char(6), @reportinggroupid int, @phase varchar(30)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	


	DECLARE @EndDate char(6)
	
select @enddate = picyear_week
from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK)
where daydate = (select top 1 DATEADD(d,-364,weekofdate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK) where PicYear_week = @picyear_week)

---- system DOTDIY
--select ss.picyear_week, ss.phase, ss.sysdotdiy, NULL as flowdotdiy
--from cft_RPT_SLF_sys_sea_DW ss (nolock)
--where ss.phase = @phase
--  and ss.picyear_week between @enddate and @picyear_week
--union
---- flow DOTDIY
--select flow.picyear_week, flow.phase,  NULL as sysdotdiy
--, flowdotdiy = case when isnull(sum(HeadStarted),0) <> 0
--		 then (cast(isnull(sum(DeadOnTruck_Qty+DeadInYard_Qty),0) as numeric(14,2)) / cast(sum(HeadStarted) as numeric(14,2))) * 100
--		 else 0 end
--from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW] flow (nolock)
--where flow.phase = @phase
--  and flow.picyear_week between @enddate and @picyear_week
--  and flow.reportinggroupid = @reportinggroupid
--group by phase, picyear_week, phase


CREATE TABLE  #dotdiyrpt2  (
	[picyear_week] [char](6) ,
	[phase] [char](3) ,
	sysdotdiy float,
	flowdotdiy float
	)
	
insert into #dotdiyrpt2
select ss.picyear_week, ss.phase, ss.sysdotdiy, NULL as flowdotdiy
from cft_RPT_SLF_sys_sea_DW ss (nolock)
where ss.phase = @phase
  and ss.picyear_week between @enddate and @picyear_week
union
select flow.picyear_week,  flow.phase,  NULL as sysdotdiy,flow.dotdiy as  flowdotdiy
from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
where  flow.phase = @phase
  and  flow.picyear_week between @enddate and @picyear_week
  and  flow.reportinggroupid = @reportinggroupid
order by ss.picyear_week desc

select rpt2.*
,mn.mindotdiy - (mn.mindotdiy*.1) mindotdiy
,mx.maxdotdiy + (mx.maxdotdiy*.1) maxdotdiy
from #dotdiyrpt2 rpt2
left join (select xx.phase, min(xx.mindotdiy) mindotdiy
		   from 
		   (select phase, min(sysdotdiy) mindotdiy from #dotdiyrpt2 where sysdotdiy > 0 group by phase
		   union
			select phase, min(flowdotdiy) mindotdiy from #dotdiyrpt2 where flowdotdiy > 0  group by phase
		   ) xx
		   group by phase) mn
	on mn.phase = rpt2.phase
left join (select xx.phase, max(xx.maxdotdiy) maxdotdiy
		   from 
		   (select phase, max(sysdotdiy) maxdotdiy from #dotdiyrpt2 group by phase
		   union
			select phase, max(flowdotdiy) maxdotdiy from #dotdiyrpt2 group by phase
		   ) xx
		   group by phase) mx
	on mx.phase = rpt2.phase
	
	
END















GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_DOTDIY_rpt2_rg] TO [db_sp_exec]
    AS [dbo];

