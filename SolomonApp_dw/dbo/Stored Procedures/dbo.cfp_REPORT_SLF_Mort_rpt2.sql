







-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_Mort_rpt2
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_Mort_rpt2]
@PicYear_Week char(6), @pigflowid int, @phase varchar(30)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @EndDate char(6)
	
select @enddate = picyear_week
from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK)
where daydate = (select top 1 DATEADD(d,-364,weekofdate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK) where PicYear_week = @picyear_week)


CREATE TABLE  #mortalityrpt2  (
	[picyear_week] [char](6) ,
	[phase] [char](3) ,
	sysmortality float,
	flowmortality float,
    targetmortality float 
	)
	
insert into #mortalityrpt2	
-- system numbers
select ss.picyear_week, ss.phase, ss.sysmortality, NULL as flowmortality, null as targetmortality
from cft_RPT_SLF_sys_sea_DW ss (nolock)
where ss.phase = @phase
  and ss.picyear_week between @enddate and @picyear_week
union
-- flow numbers
select flow.picyear_week,  flow.phase,  NULL as ssmortality
, flowmortality =
		case when isnull(sum(HeadStarted),0) <> 0
			then (cast(isnull(sum(PigDeath_Qty),0) as numeric(14,2)) / cast(sum(HeadStarted) as numeric(14,2))) * 100
			else 0
		end
, null as targetmortality
from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
where  flow.phase = @phase
  and  flow.picyear_week between @enddate and @picyear_week
  and  flow.pigflowid = @pigflowid
group by flow.pigflowid, flow.picyear_week, flow.phase
 union
-- target numbers
select ww.picyear_week
,@phase
,  null as sysmortality, NULL as flowmortality, ss.TargetLineValue as targetmortality
from (select distinct picweek, picyear, picyear_week from [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo]) ww
left join (select max(TargetLineValue) TargetLineValue, picweek, picyear, targetlinetypeid from [CFApp_PigManagement].[dbo].[cft_TARGET_LINE] group by targetlinetypeid,picyear, picweek) ss
	on isnull(ss.picweek,ww.picweek) = ww.picweek and ss.picyear = ww.picyear 
	and ss.targetlinetypeid = (case when @phase = 'NUR' then 3 when @phase = 'FIN' then 13 when @phase = 'WTF' then 30 end)
where ww.picyear_week between @enddate and @picyear_week
order by ss.picyear_week desc


select rpt2.*
,mn.minmort - (mn.minmort*.1) minmort
,mx.maxmort + (mx.maxmort*.1) maxmort
from #mortalityrpt2 rpt2
left join (select xx.phase, min(xx.minmort) minmort
		   from 
		   (select phase, min(sysmortality) minmort from #mortalityrpt2 group by phase
		   union
			select phase, min(flowmortality) minmort from #mortalityrpt2 group by phase
		   union
			select phase, min(targetmortality) minmort from #mortalityrpt2 group by phase
		   ) xx
		   group by phase) mn
	on mn.phase = rpt2.phase
left join (select xx.phase, max(xx.maxmort) maxmort
		   from 
		   (select phase, max(sysmortality) maxmort from #mortalityrpt2 group by phase
		   union
			select phase, max(flowmortality) maxmort from #mortalityrpt2 group by phase
		   union
			select phase, max(targetmortality) maxmort from #mortalityrpt2 group by phase
		   ) xx
		   group by phase) mx
	on mx.phase = rpt2.phase
	
	
END














GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_Mort_rpt2] TO [db_sp_exec]
    AS [dbo];

