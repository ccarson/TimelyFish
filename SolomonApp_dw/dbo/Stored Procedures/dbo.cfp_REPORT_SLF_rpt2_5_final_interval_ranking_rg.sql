











-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_ADG_rpt2.5
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE  PROCEDURE [dbo].[cfp_REPORT_SLF_rpt2_5_final_interval_ranking_rg]
@PicBegin char(6),@PicEnd char(6),  @sitecontactid char(6)

AS
BEGIN

-- create datastore for current averages
--drop table #slf_averages
create table #slf_averages
( phase char(3) null
, reportinggroupid int null
, sitecontactid char(6) null
, AverageDailyGain float null
, FeedToGain float null
, Mortality float null
, LivePigDays float null
, TotalHeadProduced float null
, adjaveragedailygain float null
, AdjFeedToGain float null
)


insert into #slf_averages
select phase, reportinggroupid, sitecontactid
,case when isnull(Sum(TotalPigDays),0) <> 0 then isnull(SUM(WeightGained),0) / Sum(TotalPigDays) else 0 end AverageDailyGain
,case when isnull(Sum(WeightGained),0) <> 0 then isnull(Sum(Feed_Qty),0)     / Sum(WeightGained) else 0 end FeedToGain
,case when isnull(Sum(HeadStarted),0)  <> 0 then (cast(isnull(SUM(PigDeath_Qty),0) as numeric(14,2)) / cast(Sum(HeadStarted) as numeric(14,2))) * 100 else 0 end Mortality
,sum(LivePigDays) livepigdays
,sum(TotalHeadProduced) totalheadproduced, 
case
  when Phase = 'NUR'
        then case when isnull(sum(TotalHeadProduced),0) = 0 then 0 
				  else case when (sum(LivePigDays) / sum(TotalHeadProduced)) <= 43
        then ((43 - (sum(LivePigDays) / sum(TotalHeadProduced))) * 0.015) + sum(AverageDailyGain)
        else case when isnull(Sum(TotalPigDays),0) <> 0	then isnull(SUM(WeightGained),0) / Sum(TotalPigDays) else 0	end - (((sum(LivePigDays) / sum(TotalHeadProduced)) - 43) * 0.015) end end
  when Phase = 'FIN'
        then case when 
				case when isnull(Sum(TotalPigDays),0) <> 0
				 then isnull(SUM(WeightGained),0) / Sum(TotalPigDays) else 0 end > 0 
				 then case when isnull(Sum(TotalPigDays),0) <> 0 then isnull(SUM(WeightGained),0) / Sum(TotalPigDays) else 0 
				end
            + ((50 - case when isnull(sum(TransferIn_Qty),0) <> 0
			then isnull(sum(TransferIn_Wt),0) / sum(TransferIn_Qty)
			else 0
		end) * 0.005)
            + ((270 - case when (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) <> 0
			then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))
			else 0
		end) * 0.001) else 0 
              end 
      when Phase = 'WTF'
           then case when case when isnull(Sum(TotalPigDays),0) <> 0 then isnull(SUM(WeightGained),0) / Sum(TotalPigDays) else 0 end > 0 then 
           case when isnull(Sum(TotalPigDays),0) <> 0 then isnull(SUM(WeightGained),0) / Sum(TotalPigDays) else 0 end
            + ((270 - case when (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) <> 0
			then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))
			else 0
		end) * 0.001) else 0 end  
			else case when isnull(Sum(TotalPigDays),0) <> 0 then isnull(SUM(WeightGained),0) / Sum(TotalPigDays) else 0 end 
end adjAverageDailyGain
,case 
	when Phase = 'NUR'
		then case when isnull(sum(WeightGained),0) <> 0 then isnull(SUM(Feed_Qty),0) / sum(WeightGained) else 0 end + ((50 - case when (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) <> 0
			then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))
			else 0
		end) * 0.005)
	when Phase = 'FIN'
		then case when isnull(sum(WeightGained),0) <> 0 then isnull(SUM(Feed_Qty),0) / sum(WeightGained) else 0 end + ((50 - case when isnull(sum(TransferIn_Qty),0) <> 0
			then isnull(sum(TransferIn_Wt),0) / sum(TransferIn_Qty)
			else 0
		end) * 0.005) + ((270 - case when (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) <> 0
			then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))
			else 0
		end) * 0.005)
	when Phase = 'WTF'
		then case when isnull(sum(WeightGained),0) <> 0 then isnull(SUM(Feed_Qty),0) / sum(WeightGained) else 0 end + ((270 - case when (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) <> 0
			then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))
			else 0
		end) * 0.005)
	else case when isnull(sum(WeightGained),0) <> 0 then isnull(SUM(Feed_Qty),0) / sum(WeightGained) else 0 end
 end adjfeedtogain
from  dbo.cft_RPT_PIG_MASTER_GROUP_DW
where picyear_week between @PicBegin and @PicEnd
and phase in ('NUR', 'WTF', 'FIN')
group by phase, reportinggroupid, sitecontactid
--

--drop table #slf_rankings
create table #slf_rankings
( contactname varchar(30) null
, sitecontactid char(6) null
, phase char(3) null
, reportinggroupid int null
, AdjAverageDailyGain float null
, AdjFeedToGain float null
, Mortality float null
, AdjADGRank int null
, adjferank int null
, mortrank int null
)

insert into #slf_rankings
select c.contactname, c.solomoncontactid as sitecontactid
	, base.Phase
	, base.reportinggroupid
	, base.AdjAverageDailyGain
	, base.AdjFeedToGain
	, base.Mortality
	, Rank() over (Partition by base.Phase, base.reportinggroupid Order by AdjAverageDailyGain desc) as 'AdjADGRank'
	, Rank() over (Partition by base.Phase, base.reportinggroupid Order by AdjFeedToGain) as 'AdjFERank'
	, Rank() over (Partition by base.Phase, base.reportinggroupid  Order by Mortality) as 'MortRank'
	from #slf_averages base
	left join [$(CentralData)].dbo.contact c (nolock) 
		on c.solomoncontactid = base.sitecontactid


--drop table #slf_pcttile
create table #slf_pcttile
( contactname varchar(30) null
, sitecontactid char(6) null
, phase char(3) null
, reportinggroupid int null
, adjadgrankpctile float null
, adjferankpctile float null
, mortrankpctile float null
, comborank float null
, TotComp int null
)
insert into #slf_pcttile
select rnk.contactname, rnk.sitecontactid, rnk.phase, rnk.reportinggroupid
, (cast(maxadg as float) - cast(adjadgrank as float)+ 1)/cast(maxadg as float) as adjadgrankpctile 
, (cast(maxFE as float) - cast(AdjFERank as float)+ 1)/cast(maxFE as float) as AdjFERankpctile
, (cast(maxmort as float) - cast(MortRank as float)+ 1)/cast(maxmort as float) as MortRankpctile
, ((cast(maxadg as float) - cast(adjadgrank as float)+ 1)/cast(maxadg as float))/3 + 
((cast(maxfe as float) - cast(AdjFERank as float)+ 1)/cast(maxfe as float))/3 + 
((cast(maxmort as float) - cast(MortRank as float)+ 1)/cast(maxmort as float))/3 as comborank
, mx.TotComp
from #slf_rankings rnk
inner join (select phase,reportinggroupid, max(AdjADGRank) maxadg, max(AdjFERank) maxFE, max(MortRank) maxmort, count(1) TotComp 
		    from #slf_rankings
			group by phase,reportinggroupid) mx
	on mx.phase = rnk.phase and mx.reportinggroupid = rnk.reportinggroupid
where sitecontactid =  @sitecontactid
  and contactname <> ''


select pct.contactname, pct.sitecontactid, pct.phase + '-' 
+ pf.Reporting_Group_Description as phaseflow
--+ substring(pf.PigFlowDescription,1,7) as phaseflow
, pct.adjadgrankpctile, pct.adjferankpctile, pct.mortrankpctile, pct.comborank, pct.TotComp
from #slf_pcttile pct
LEFT JOIN [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] PF (NOLOCK)
	ON pf.reportinggroupid = pct.reportinggroupid
where pct.sitecontactid = @sitecontactid


END













GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_rpt2_5_final_interval_ranking_rg] TO [CorpReports]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_rpt2_5_final_interval_ranking_rg] TO [db_sp_exec]
    AS [dbo];

