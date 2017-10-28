
-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_site_perf_rpt1_rg
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
-- 2/25/2016, BMD, Excluded SBF PigGroups from report
-- =============================================
CREATE  PROCEDURE [dbo].[cfp_REPORT_SLF_site_perf_rpt1_rg]
@PicYear_Week char(6), @SiteContactid char(6)

AS
BEGIN

declare @mastergroup char(10)

create table #SLF_site_MG_last_3_closeouts
(picyear_week char(6) not null
, mastergroup char(10) not null
, sitecontactid char(6) not null
, reportinggroupid int not null
, phase char(3) not null
, actstartdate smalldatetime null
, actclosedate smalldatetime null
, nbrcomps int null
)


insert into #SLF_site_MG_last_3_closeouts
select top 1 mg.picyear_week, mg.mastergroup, mg.sitecontactid,mg.reportinggroupid, mg.phase, mg.actstartdate, mg.actclosedate, NULL
from cft_RPT_PIG_MASTER_GROUP_DW mg
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=mg.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
where mg.sitecontactid =  @sitecontactid
and mg.phase in ('NUR', 'WTF', 'FIN')
and mg.picyear_week <= @picyear_week
order by mg.sitecontactid,mg.actclosedate desc

insert into #SLF_site_MG_last_3_closeouts
select top 1 mg.picyear_week, mg.mastergroup, mg.sitecontactid,mg.reportinggroupid, mg.phase, mg.actstartdate, mg.actclosedate, NULL
from cft_RPT_PIG_MASTER_GROUP_DW mg
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=mg.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
where mg.sitecontactid =  @sitecontactid
and mg.phase in ('NUR', 'WTF', 'FIN')
and mg.picyear_week <= @picyear_week
and mg.actclosedate <= (select DATEADD(DD,21,max(actstartdate)) from #SLF_site_MG_last_3_closeouts)	-- <= 3 week overlap of start and close dates
order by mg.sitecontactid,mg.actclosedate desc

insert into #SLF_site_MG_last_3_closeouts
select top 1 mg.picyear_week, mg.mastergroup, mg.sitecontactid,mg.reportinggroupid, mg.phase, mg.actstartdate, mg.actclosedate, NULL
from cft_RPT_PIG_MASTER_GROUP_DW mg
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=mg.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
where mg.sitecontactid =  @sitecontactid
and mg.phase in ('NUR', 'WTF', 'FIN')
and mg.picyear_week <= @picyear_week
and mg.actclosedate <= (select DATEADD(DD,21,min(actstartdate)) from #SLF_site_MG_last_3_closeouts)	-- <= 3 week overlap of start and close dates
order by mg.sitecontactid,mg.actclosedate desc




declare @startdate datetime, @closedate datetime, @nbrcomps int, @reportinggroupid int, @phase varchar(3)

declare get_daterange cursor 
for select picyear_week, mastergroup, sitecontactid, reportinggroupid, phase, actstartdate, actclosedate
FROM #SLF_site_MG_last_3_closeouts

open get_daterange

fetch next from get_daterange into @picyear_week, @mastergroup, @sitecontactid, @reportinggroupid, @phase, @startdate, @closedate

while (@@fetch_status <> -1)
begin 
	
	-- we want a count of all other sites plus the one site to get comp counts.  don't want to count multiple @sitecontactid sites.
	select @nbrcomps = count(distinct cft_RPT_PIG_MASTER_GROUP_DW.sitecontactid+picyear_week) + 1  
	from cft_RPT_PIG_MASTER_GROUP_DW
	inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=cft_RPT_PIG_MASTER_GROUP_DW.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
	where	reportinggroupid = @reportinggroupid
	and		phase = @phase
	and		cft_RPT_PIG_MASTER_GROUP_DW.actclosedate between @startdate and @closedate
	and		cft_RPT_PIG_MASTER_GROUP_DW.sitecontactid <> @sitecontactid
	
	update #SLF_site_MG_last_3_closeouts
	set nbrcomps = @nbrcomps
	where picyear_week = @picyear_week and sitecontactid = @sitecontactid
	
	fetch next from get_daterange into @picyear_week, @mastergroup, @sitecontactid, @reportinggroupid, @phase, @startdate, @closedate
end

close get_daterange
deallocate get_daterange


--select * from #SLF_site_MG_last_3_closeouts


--drop table #slf_averages
create table #slf_averages
( phase char(3) null
, reportinggroupid int null
, picyear_week char(6) null
, sitecontactid char(6) null
, AverageDailyGain float null
, FeedToGain float null
, Mortality float null
, LivePigDays float null
, TotalHeadProduced float null
, adjAverageDailyGain float null
, AdjFeedToGain float null
)



declare get_closeout cursor 
for select picyear_week, phase, reportinggroupid, actstartdate, actclosedate
FROM #SLF_site_MG_last_3_closeouts

open get_closeout

fetch next from get_closeout into @picyear_week, @phase, @reportinggroupid, @startdate, @closedate

while (@@fetch_status <> -1)
begin 

insert into #slf_averages
select phase, reportinggroupid, @picyear_week, cft_RPT_PIG_MASTER_GROUP_DW.sitecontactid
,case when isnull(Sum(TotalPigDays),0) <> 0 then isnull(SUM(WeightGained),0) / Sum(TotalPigDays) else 0 end AverageDailyGain
,case when isnull(Sum(WeightGained),0) <> 0 then isnull(Sum(Feed_Qty),0)     / Sum(WeightGained) else 0 end FeedToGain
,case when isnull(Sum(HeadStarted),0)  <> 0 then (cast(isnull(SUM(PigDeath_Qty),0) as numeric(14,2)) / cast(Sum(HeadStarted) as numeric(14,2))) * 100 else 0 end Mortality
,sum(LivePigDays) livepigdays
,sum(TotalHeadProduced) totalheadproduced
,case
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
		then case when isnull(sum(WeightGained),0) <> 0 then isnull(SUM(Feed_Qty),0) / sum(WeightGained) else 0 end + ((50 - 		case when isnull(sum(TransferIn_Qty),0) <> 0
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
 end AdjFeedToGain
from  dbo.cft_RPT_PIG_MASTER_GROUP_DW
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=cft_RPT_PIG_MASTER_GROUP_DW.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
where cft_RPT_PIG_MASTER_GROUP_DW.actclosedate between @startdate and @closedate
and phase =@phase and reportinggroupid =@reportinggroupid and cft_RPT_PIG_MASTER_GROUP_DW.sitecontactid <> @sitecontactid
group by phase, reportinggroupid, picyear_week, cft_RPT_PIG_MASTER_GROUP_DW.sitecontactid

union

select phase, reportinggroupid,@picyear_week, cft_RPT_PIG_MASTER_GROUP_DW.sitecontactid
,case when isnull(Sum(TotalPigDays),0) <> 0 then isnull(SUM(WeightGained),0) / Sum(TotalPigDays) else 0 end AverageDailyGain
,case when isnull(Sum(WeightGained),0) <> 0 then isnull(Sum(Feed_Qty),0)     / Sum(WeightGained) else 0 end FeedToGain
,case when isnull(Sum(HeadStarted),0)  <> 0 then (cast(isnull(SUM(PigDeath_Qty),0) as numeric(14,2)) / cast(Sum(HeadStarted) as numeric(14,2))) * 100 else 0 end Mortality
,sum(LivePigDays) livepigdays
,sum(TotalHeadProduced) totalheadproduced
,case
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
		then case when isnull(sum(WeightGained),0) <> 0 then isnull(SUM(Feed_Qty),0) / sum(WeightGained) else 0 end + ((50 - 		case when isnull(sum(TransferIn_Qty),0) <> 0
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
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=cft_RPT_PIG_MASTER_GROUP_DW.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
where picyear_week = @picyear_week
and phase =@phase and reportinggroupid =@reportinggroupid and cft_RPT_PIG_MASTER_GROUP_DW.sitecontactid = @sitecontactid
group by phase, reportinggroupid, cft_RPT_PIG_MASTER_GROUP_DW.sitecontactid

	fetch next from get_closeout into @picyear_week, @phase, @reportinggroupid, @startdate, @closedate

end

close get_closeout
deallocate get_closeout

--drop table #slf_rankings
create table #slf_rankings
( picyear_week varchar(6) not null
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
select base.picyear_week
	, c.contactname, c.solomoncontactid as sitecontactid
	, base.phase
	, base.reportinggroupid
	, base.AdjAverageDailyGain
	, base.AdjFeedToGain
	, base.Mortality
	, Rank() over (Partition by base.Phase, base.reportinggroupid, base.picyear_week Order by AdjAverageDailyGain desc) as 'AdjADGRank'
	, Rank() over (Partition by base.Phase, base.reportinggroupid, base.picyear_week Order by AdjFeedToGain) as 'AdjFERank'
	, Rank() over (Partition by base.Phase, base.reportinggroupid, base.picyear_week  Order by Mortality) as 'MortRank'
	from #slf_averages base
	left join [$(CentralData)].dbo.contact c (nolock) 
		on c.solomoncontactid = base.sitecontactid
		
--drop table #slf_pcttile
create table #slf_pcttile
( picyear_week varchar(6) not null
, contactname varchar(30) null
, sitecontactid char(6) null
, phase char(3) null
, reportinggroupid int null
, adjadgrankpctile float null
, adjferankpctile float null
, mortrankpctile float null
, comborank float null
)
insert into #slf_pcttile
select rnk.picyear_week, rnk.contactname, rnk.sitecontactid, rnk.phase, rnk.reportinggroupid
, (cast(maxadg as float) - cast(adjadgrank as float)+ 1)/cast(maxadg as float) as adjadgrankpctile 
, (cast(maxFE as float) - cast(AdjFERank as float)+ 1)/cast(maxFE as float) as AdjFERankpctile
, (cast(maxmort as float) - cast(MortRank as float)+ 1)/cast(maxmort as float) as MortRankpctile
, ((cast(maxadg as float) - cast(adjadgrank as float)+ 1)/cast(maxadg as float))/3 + 
((cast(maxfe as float) - cast(AdjFERank as float)+ 1)/cast(maxfe as float))/3 + 
((cast(maxmort as float) - cast(MortRank as float)+ 1)/cast(maxmort as float))/3 as comborank
from #slf_rankings rnk
inner join (select picyear_week,phase,reportinggroupid, max(AdjADGRank) maxadg, max(AdjFERank) maxFE, max(MortRank) maxmort 
		    from #slf_rankings
			group by picyear_week,phase,reportinggroupid) mx
	on mx.picyear_week = rnk.picyear_week and mx.phase = rnk.phase and mx.reportinggroupid = rnk.reportinggroupid
where sitecontactid =  @sitecontactid
  and contactname <> ''


select pct.picyear_week+': '+pct.phase+'_'+rg.Reporting_Group_Description	--+'_'+site.mastergroup 
as x_axis, pct.contactname, pct.sitecontactid, pct.phase, pct.adjadgrankpctile, pct.adjferankpctile, pct.mortrankpctile, pct.comborank
, site.nbrcomps
from #slf_pcttile pct
left join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] rg (nolock)
	on pct.reportinggroupid = rg.reportinggroupid
left join #SLF_site_MG_last_3_closeouts site
	on site.picyear_week = pct.picyear_week and site.sitecontactid = pct.sitecontactid and site.reportinggroupid = pct.reportinggroupid and site.phase = pct.phase

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_site_perf_rpt1_rg] TO [CorpReports]
    AS [dbo];

