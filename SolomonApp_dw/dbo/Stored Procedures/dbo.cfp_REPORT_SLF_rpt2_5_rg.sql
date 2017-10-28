





-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_ADG_rpt2.5
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE  PROCEDURE [dbo].[cfp_REPORT_SLF_rpt2_5_rg]
@PicBegin char(6),@PicEnd char(6),  @sitecontactid char(6)

AS
BEGIN

--drop table #slf_site_info
create table #slf_site_info
(picyear_week char(6) not null
, sitecontactid char(6) not null
, reportinggroupid int not null
, phase char(3) not null
, actclosedate smalldatetime
, [2mm_before_picweek] char(6) null
, [2mm_after_picweek] char(6) null
, daterange char(13) null
)


insert into #slf_site_info
select mg.picyear_week, mg.sitecontactid,mg.reportinggroupid, mg.phase
, mg.actclosedate, b4.picyear_week [2mm_before_picweek], af.picyear_week [2mm_after_picweek]
, b4.picyear_week+'_'+af.picyear_week as daterange
from cft_RPT_PIG_MASTER_GROUP_DW mg
join [dbo].[cftDayDefinition_WithWeekInfo] b4
	on b4.daydate = dateadd(ww,-8,mg.actclosedate)
join [dbo].[cftDayDefinition_WithWeekInfo] af
	on af.daydate = dateadd(ww,+8,mg.actclosedate)
where mg.sitecontactid = @sitecontactid
and mg.picyear_week between @PicBegin and @PicEnd
and mg.phase in ('NUR', 'WTF', 'FIN')
order by mg.sitecontactid, b4.picyear_week+'_'+af.picyear_week, mg.picyear_week, mg.reportinggroupid, mg.phase


-- create datastore for current averages
--drop table #slf_averages
create table #slf_averages
( phase char(3) null
, reportinggroupid int null
, daterange char(13) null
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
select ssi.phase, ssi.reportinggroupid, ssi.daterange, dw.sitecontactid
,case when isnull(Sum(TotalPigDays),0) <> 0 then isnull(SUM(WeightGained),0) / Sum(TotalPigDays) else 0 end AverageDailyGain
,case when isnull(Sum(WeightGained),0) <> 0 then isnull(Sum(Feed_Qty),0)     / Sum(WeightGained) else 0 end FeedToGain
,case when isnull(Sum(HeadStarted),0)  <> 0 then (cast(isnull(SUM(PigDeath_Qty),0) as numeric(14,2)) / cast(Sum(HeadStarted) as numeric(14,2))) * 100 else 0 end Mortality
,sum(LivePigDays) livepigdays
,sum(TotalHeadProduced) totalheadproduced, 
case
  when ssi.Phase = 'NUR'
        then case when isnull(sum(TotalHeadProduced),0) = 0 then 0 
				  else case when (sum(LivePigDays) / sum(TotalHeadProduced)) <= 43
        then ((43 - (sum(LivePigDays) / sum(TotalHeadProduced))) * 0.015) + sum(AverageDailyGain)
        else case when isnull(Sum(TotalPigDays),0) <> 0	then isnull(SUM(WeightGained),0) / Sum(TotalPigDays) else 0	end - (((sum(LivePigDays) / sum(TotalHeadProduced)) - 43) * 0.015) end end
  when ssi.Phase = 'FIN'
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
      when ssi.Phase = 'WTF'
           then case when case when isnull(Sum(TotalPigDays),0) <> 0 then isnull(SUM(WeightGained),0) / Sum(TotalPigDays) else 0 end > 0 then 
           case when isnull(Sum(TotalPigDays),0) <> 0 then isnull(SUM(WeightGained),0) / Sum(TotalPigDays) else 0 end
            + ((270 - case when (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) <> 0
			then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))
			else 0
		end) * 0.001) else 0 end  
			else case when isnull(Sum(TotalPigDays),0) <> 0 then isnull(SUM(WeightGained),0) / Sum(TotalPigDays) else 0 end 
end adjAverageDailyGain
,case 
	when ssi.Phase = 'NUR'
		then case when isnull(sum(WeightGained),0) <> 0 then isnull(SUM(Feed_Qty),0) / sum(WeightGained) else 0 end + ((50 - case when (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) <> 0
			then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))
			else 0
		end) * 0.005)
	when ssi.Phase = 'FIN'
		then case when isnull(sum(WeightGained),0) <> 0 then isnull(SUM(Feed_Qty),0) / sum(WeightGained) else 0 end + ((50 - 		case when isnull(sum(TransferIn_Qty),0) <> 0
			then isnull(sum(TransferIn_Wt),0) / sum(TransferIn_Qty)
			else 0
		end) * 0.005) + ((270 - case when (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) <> 0
			then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))
			else 0
		end) * 0.005)
	when ssi.Phase = 'WTF'
		then case when isnull(sum(WeightGained),0) <> 0 then isnull(SUM(Feed_Qty),0) / sum(WeightGained) else 0 end + ((270 - case when (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) <> 0
			then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))
			else 0
		end) * 0.005)
	else case when isnull(sum(WeightGained),0) <> 0 then isnull(SUM(Feed_Qty),0) / sum(WeightGained) else 0 end
 end adjfeedtogain
from #slf_site_info ssi
join  dbo.cft_RPT_PIG_MASTER_GROUP_DW dw (nolock)
	on dw.reportinggroupid = ssi.reportinggroupid and dw.phase = ssi.phase and dw.picyear_week between ssi.[2mm_before_picweek] and ssi.[2mm_after_picweek]
where dw.picyear_week between @PicBegin and @PicEnd
and dw.phase in ('NUR', 'WTF', 'FIN')
group by ssi.phase, ssi.reportinggroupid, ssi.daterange, dw.sitecontactid
--




--drop table #slf_rankings
create table #slf_rankings
( daterange varchar(13) not null
, contactname varchar(30) null
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
select base.daterange
	, c.contactname, c.solomoncontactid as sitecontactid
	, base.Phase
	, base.reportinggroupid
	, base.AdjAverageDailyGain
	, base.AdjFeedToGain
	, base.Mortality
	, Rank() over (Partition by base.Phase, base.reportinggroupid, base.daterange Order by AdjAverageDailyGain desc) as 'AdjADGRank'
	, Rank() over (Partition by base.Phase, base.reportinggroupid, base.daterange Order by AdjFeedToGain) as 'AdjFERank'
	, Rank() over (Partition by base.Phase, base.reportinggroupid, base.daterange  Order by Mortality) as 'MortRank'
	from #slf_averages base
	left join [$(CentralData)].dbo.contact c (nolock) 
		on c.solomoncontactid = base.sitecontactid


--drop table #slf_pcttile
create table #slf_pcttile
( daterange varchar(13) not null
, contactname varchar(30) null
, sitecontactid char(6) null
, phase char(3) null
, reportinggroupid int null
, comps int null
, adjadgrankpctile float null
, adjferankpctile float null
, mortrankpctile float null
, comborank float null
)
insert into #slf_pcttile
select rnk.daterange, rnk.contactname, rnk.sitecontactid, rnk.phase, rnk.reportinggroupid, mx.comps
, (cast(maxadg as float) - cast(adjadgrank as float)+ 1)/cast(maxadg as float) as adjadgrankpctile 
, (cast(maxFE as float) - cast(AdjFERank as float)+ 1)/cast(maxFE as float) as AdjFERankpctile
, (cast(maxmort as float) - cast(MortRank as float)+ 1)/cast(maxmort as float) as MortRankpctile
, ((cast(maxadg as float) - cast(adjadgrank as float)+ 1)/cast(maxadg as float))/3 + 
((cast(maxfe as float) - cast(AdjFERank as float)+ 1)/cast(maxfe as float))/3 + 
((cast(maxmort as float) - cast(MortRank as float)+ 1)/cast(maxmort as float))/3 as comborank
from #slf_rankings rnk
inner join (select daterange,phase,reportinggroupid, max(AdjADGRank) maxadg, max(AdjFERank) maxFE, max(MortRank) maxmort 
			, count(distinct sitecontactid) comps 
		    from #slf_rankings
			group by daterange,phase,reportinggroupid) mx
	on mx.daterange = rnk.daterange and mx.phase = rnk.phase and mx.reportinggroupid = rnk.reportinggroupid
where sitecontactid =  @sitecontactid
  and contactname <> ''


--select site.picyear_week as site_closeout_picyear_week, pct.contactname, pct.sitecontactid, pct.phase, pct.adjadgrankpctile, pct.adjferankpctile, pct.mortrankpctile, pct.comborank
--, pct.comps
--, site.picyear_week + '_' +  pf.reporting_group_Description+'_'+pct.phase  as x_axis
--from #slf_pcttile pct
--left join 
--(select daterange, sitecontactid, reportinggroupid, phase, max(picyear_week) picyear_week 
--from #slf_site_info 
--group by daterange, sitecontactid, reportinggroupid, phase) site
--	on site.daterange = pct.daterange and site.sitecontactid = pct.sitecontactid and site.reportinggroupid = pct.reportinggroupid and site.phase = pct.phase
--left join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_reporting_group] pf (nolock)
--	on pf.reportinggroupid = pct.reportinggroupid
--where pct.comps >= 3
--order by pct.daterange + '_' +  pf.reporting_group_Description+'_'+pct.phase

select site.picyear_week as site_closeout_picyear_week, pct.contactname, pct.sitecontactid, pct.phase
, case when pct.comps < 3 then null else pct.adjadgrankpctile end adjadgrankpctile 
, case when pct.comps < 3 then null else  pct.adjferankpctile end adjferankpctile
, case when pct.comps < 3 then null else  pct.mortrankpctile end mortrankpctile
, case when pct.comps < 3 then null else  pct.comborank end comborank
, pct.comps
, site.picyear_week + '_' +  pf.reporting_group_Description+'_'+pct.phase  as x_axis
from #slf_pcttile pct
left join 
(select daterange, sitecontactid, reportinggroupid, phase, max(picyear_week) picyear_week 
from #slf_site_info 
group by daterange, sitecontactid, reportinggroupid, phase) site
	on site.daterange = pct.daterange and site.sitecontactid = pct.sitecontactid and site.reportinggroupid = pct.reportinggroupid and site.phase = pct.phase
left join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_reporting_group] pf (nolock)
	on pf.reportinggroupid = pct.reportinggroupid
where pct.comps >= 0
order by pct.daterange + '_' +  pf.reporting_group_Description+'_'+pct.phase
	

END












GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_rpt2_5_rg] TO [CorpReports]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_rpt2_5_rg] TO [db_sp_exec]
    AS [dbo];

