












-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FE_rpt2_rg
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FE_rpt2_rg]
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


CREATE TABLE  #ferpt2  (
	[picyear_week] [char](6) ,
	[phase] [char](3) ,
	sysadjfe float,
	flowadjfe float,
    targetfe float 
	)
	
insert into #ferpt2
-- system averages
select ss.picyear_week, ss.phase, ss.sysadjfe, NULL as flowadjfe, null as targetfe
from cft_RPT_SLF_sys_sea_DW ss (nolock)
where ss.phase = @phase
  and ss.picyear_week between @enddate and @picyear_week
union
SELECT flow.picyear_week,  flow.phase,  NULL as sysadjfe
, flowadjfe =
            case
			  when Phase = 'NUR'
--				    then FeedToGain + ((50 - AverageOut_Wt) * 0.005)
					then case when isnull(sum(WeightGained),0) <> 0 then isnull(sum(Feed_Qty),0) / sum(WeightGained) else 0 end
--					+  ((50 - AverageOut_Wt) * 0.005)
					+  ((50 - case when (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) <> 0 then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) else 0 end) * 0.005)
				when Phase = 'FIN'
--				then FeedToGain + ((50 - AveragePurchase_Wt) * 0.005) + ((270 - AverageOut_Wt) * 0.005)
				then case when isnull(sum(WeightGained),0) <> 0	then isnull(sum(Feed_Qty),0) / sum(WeightGained) else 0	end 
				+ ((50 - case when isnull(sum(TransferIn_Qty),0) <> 0 then isnull(sum(TransferIn_Wt),0) / sum(TransferIn_Qty) else 0 end) * 0.005) 
				+ ((270 - case when (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) <> 0
				then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) else 0 end) * 0.005)
                when Phase = 'WTF'
--				then FeedToGain + ((270 - AverageOut_Wt) * 0.005)
				then case when isnull(sum(WeightGained),0) <> 0	then isnull(sum(Feed_Qty),0) / sum(WeightGained) else 0	end
--				+ ((270 - AverageOut_Wt) * 0.005)
				+ ((270 -case when (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) <> 0
				then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) else 0 end) * 0.005)
            end 
, NULL as targetfe
from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
where  flow.phase = @phase
  and  flow.picyear_week between @enddate and @picyear_week
  and  flow.reportinggroupid = @reportinggroupid
group by picyear_week, reportinggroupid, phase 
 union
 -- Targets
select distinct dd.picyear_week, @phase, null as sysadjadg, null as flowadjadg, s1.targetlinevalue*wa.adjfeed_consumption as targetfe
	from [CFApp_PigManagement].[dbo].[cft_TARGET_LINE] s1
	cross join  dbo.cft_weekly_adjustments wa (nolock)
	inner join [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo] dd
		on dd.picweek = wa.picweek and dd.picyear = s1.picyear
where dd.picyear_week between @enddate and @picyear_week
and s1.targetlinetypeid = (case when @phase = 'NUR' then 2 when @phase = 'FIN' then 12 when @phase = 'WTF' then 29 end)
--select ww.picyear_week
--,@phase
--,  null as sysadjfe, NULL as flowadjfe, ss.TargetLineValue as targetfe
--from (select distinct picweek, picyear, picyear_week from [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo]) ww
--left join (select max(TargetLineValue) TargetLineValue, picweek, picyear, targetlinetypeid from [CFApp_PigManagement].[dbo].[cft_TARGET_LINE] group by targetlinetypeid,picyear, picweek) ss
--	on isnull(ss.picweek,ww.picweek) = ww.picweek and ss.picyear = ww.picyear 
--	and ss.targetlinetypeid = (case when @phase = 'NUR' then 2 when @phase = 'FIN' then 12 when @phase = 'WTF' then 29 end)
--where 1=1 --ww.picyear = '2013'
--  and ww.picyear_week between @enddate and @picyear_week
--order by ss.picyear_week desc


select rpt2.*
,mn.minfe - (mn.minfe*.1) minfe
,mx.maxfe + (mx.maxfe*.1) maxfe
from #ferpt2 rpt2
left join (select xx.phase, min(xx.minfe) minfe
		   from 
		   (select phase, min(sysadjfe) minfe from #ferpt2  where sysadjfe > 0 group by phase
		   union
			select phase, min(flowadjfe) minfe from #ferpt2  where flowadjfe > 0 group by phase
		   union
			select phase, min(targetfe) minfe from #ferpt2 where targetfe > 0 group by phase
		   ) xx
		   group by phase) mn
	on mn.phase = rpt2.phase
left join (select xx.phase, max(xx.maxfe) maxfe
		   from 
		   (select phase, max(sysadjfe) maxfe from #ferpt2 group by phase
		   union
			select phase, max(flowadjfe) maxfe from #ferpt2 group by phase
		   union
			select phase, max(targetfe) maxfe from #ferpt2 group by phase
		   ) xx
		   group by phase) mx
	on mx.phase = rpt2.phase
	
	
END



















GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_FE_rpt2_rg] TO [db_sp_exec]
    AS [dbo];

