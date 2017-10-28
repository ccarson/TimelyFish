


-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_ADG_rpt2
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_ADG_rpt2]
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


CREATE TABLE  #adgrpt2  (
	[picyear_week] [char](6) ,
	[phase] [char](3) ,
	sysadjadg float,
	flowadjadg float,
    targetadg float 
	)
	
insert into #adgrpt2
-- system numbers
select ss.picyear_week, ss.phase, ss.sysadjadg, NULL as flowadjadg, NULL as targetadg
from cft_RPT_SLF_sys_sea_DW ss (nolock)
where ss.phase = @phase
  and ss.picyear_week between @enddate and @picyear_week
union
-- target numbers
select distinct dd.picyear_week, @phase, null as sysadjadg, null as flowadjadg, s1.targetlinevalue*wa.adjwgt_gain as targetADG
	from [CFApp_PigManagement].[dbo].[cft_TARGET_LINE] s1
	cross join  dbo.cft_weekly_adjustments wa (nolock)
	inner join [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo] dd
		on dd.picweek = wa.picweek and dd.picyear = s1.picyear
where dd.picyear_week between @enddate and @picyear_week
and targetlinetypeid = (case when @phase = 'NUR' then 1 when @phase = 'FIN' then 11 when @phase = 'WTF' then 28 end)
--select ww.picyear_week
--,@phase
--,  null as sysadjadg,NULL as flowadjadg, ss.TargetLineValue as targetadg
--from (select distinct picweek, picyear, picyear_week from [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo]) ww
--left join 
--(select max(TargetLineValue) TargetLineValue, picweek, picyear, targetlinetypeid 
--from [CFApp_PigManagement].[dbo].[cft_TARGET_LINE] 
--group by targetlinetypeid,picyear, picweek) ss
--	on isnull(ss.picweek,ww.picweek) = ww.picweek and ss.picyear = ww.picyear 
--	and ss.targetlinetypeid = (case when @phase = 'NUR' then 1 when @phase = 'FIN' then 11 when @phase = 'WTF' then 28 end)
--where ww.picyear_week between @enddate and @picyear_week
 union
 -- flow numbers
SELECT flow.picyear_week,  flow.phase,  NULL as sysadjadg
, flowadjADG =
            case
                  when Phase = 'NUR'
                        then case when isnull(sum(TotalHeadProduced),0) = 0 then 0 
                        else case when (sum(LivePigDays) / sum(TotalHeadProduced)) <= 43
                        then ((43 - (sum(LivePigDays) / sum(TotalHeadProduced))) * 0.015) 
                        -- + AverageDailyGain
                        + case when isnull(sum(TotalPigDays),0) <> 0 then isnull(sum(WeightGained),0) / sum(TotalPigDays) else 0		end
                        --  else AverageDailyGain - (((LivePigDays / TotalHeadProduced) - 43) * 0.015) end end
                        else case when isnull(sum(TotalPigDays),0) <> 0 then isnull(sum(WeightGained),0) / sum(TotalPigDays) else 0		end 
							- (((sum(LivePigDays) / sum(TotalHeadProduced)) - 43) * 0.015) end end
                  when Phase = 'FIN'
                        then case when case when isnull(sum(TotalPigDays),0) <> 0 then isnull(sum(WeightGained),0) / sum(TotalPigDays) else 0 end > 0 then case when isnull(sum(TotalPigDays),0) <> 0 then isnull(sum(WeightGained),0) / sum(TotalPigDays) else 0		end
                        + ((50 - case when isnull(sum(TransferIn_Qty),0) <> 0 then isnull(sum(TransferIn_Wt),0) / sum(TransferIn_Qty)  else 0		end) * 0.005)
                        + ((270 - case when (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) <> 0
			then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))
			else 0
		end) * 0.001) else 0 end 
                  when Phase = 'WTF'
                        then case when case when isnull(sum(TotalPigDays),0) <> 0 then isnull(sum(WeightGained),0) / sum(TotalPigDays) else 0 end > 0 then case when isnull(sum(TotalPigDays),0) <> 0 then isnull(sum(WeightGained),0) / sum(TotalPigDays) else 0		end
                        + ((270 - case when (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) <> 0
			then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) else 0 end) * 0.001) else 0 end  
                  else case when isnull(sum(TotalPigDays),0) <> 0 then isnull(sum(WeightGained),0) / sum(TotalPigDays) else 0		end
            end 
, NULL as targetadg
from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
where  flow.phase = @phase
  and  flow.picyear_week between @enddate and @picyear_week
  and  flow.pigflowid = @pigflowid
group by picyear_week, pigflowid, phase 

select rpt2.*
,mn.minadg - (mn.minadg*.1) minadg
,mx.maxadg + (mx.maxadg*.1) maxadg
from #adgrpt2 rpt2
left join (select xx.phase, min(xx.minadg) minadg
		   from 
		   (select phase, min(sysadjadg) minadg from #adgrpt2 where sysadjadg > 0 group by phase
		   union
			select phase, min(flowadjADG) minadg from #adgrpt2 where flowadjadg > 0 group by phase
		   union
			select phase, min(targetADG) minadg from #adgrpt2 where targetADG > 0 group by phase
		   ) xx
		   group by phase) mn
	on mn.phase = rpt2.phase
left join (select xx.phase, max(xx.maxadg) maxadg
		   from 
		   (select phase, max(sysadjadg) maxadg from #adgrpt2 group by phase
		   union
			select phase, max(flowadjADG) maxadg from #adgrpt2 group by phase
		   union
			select phase, max(targetADG) maxadg from #adgrpt2 group by phase
		   ) xx
		   group by phase) mx
	on mx.phase = rpt2.phase
	

END



























GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_ADG_rpt2] TO [CorpReports]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_ADG_rpt2] TO [db_sp_exec]
    AS [dbo];

