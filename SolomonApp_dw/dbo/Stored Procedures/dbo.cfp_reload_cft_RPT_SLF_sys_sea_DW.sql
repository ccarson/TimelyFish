
-- 2/25/2016, BMD, Excluded SBF PigGroups from report

CREATE PROCEDURE [dbo].[cfp_reload_cft_RPT_SLF_sys_sea_DW]
AS
BEGIN

-------------------------------------------------------------------------------------------------------
-- this is dependent on replication finishing, so should be run directly after log shipping completes
-------------------------------------------------------------------------------------------------------
--clear table for new data
truncate table  dbo.cft_RPT_SLF_sys_sea_DW

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
insert into cft_RPT_SLF_sys_sea_DW
select SM.picyear_week,SM.phase
, case when isnull(TotalPigDays,0) <> 0
			then isnull(WeightGained,0) / TotalPigDays
			else 0
		end as AverageDailyGain
,case when isnull(TransferIn_Qty,0) <> 0
			then isnull(TransferIn_Wt,0) / TransferIn_Qty
			else 0
		end as AveragePurchase_Wt
,case when (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0)) <> 0
			then (isnull(Prim_Wt,0) + isnull(Cull_Wt,0) + isnull(DeadPigsToPacker_Wt,0) + isnull(TransferToTailender_Wt,0) + isnull(TransferOut_Wt,0) + isnull(TransportDeath_Wt,0)) / (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0))
			else 0
		end as AverageOut_WtF
,case when isnull(WeightGained,0) <> 0
			then isnull(Feed_Qty,0) / WeightGained
			else 0
		end	as FeedToGain 
--,	FeedToGain =
--		case when isnull(WeightGained,0) <> 0
--			then isnull(Feed_Qty,0) / WeightGained
--			else 0
--		end
--,	AveragePurchase_Wt =
--		case when isnull(TransferIn_Qty,0) <> 0
--			then isnull(TransferIn_Wt,0) / TransferIn_Qty
--			else 0
--		end
--,	AverageOut_Wt =
--		case when (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0)) <> 0
--			then (isnull(Prim_Wt,0) + isnull(Cull_Wt,0) + isnull(DeadPigsToPacker_Wt,0) + isnull(TransferToTailender_Wt,0) + isnull(TransferOut_Wt,0) + isnull(TransportDeath_Wt,0)) / (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0))
--			else 0
--		end
--SET	AdjFeedToGain =
--		case 
--			when Phase = 'NUR'
--				then FeedToGain + ((50 - AverageOut_Wt) * 0.005)
--			when Phase = 'FIN'
--				then FeedToGain + ((50 - AveragePurchase_Wt) * 0.005) + ((270 - AverageOut_Wt) * 0.005)
--			when Phase = 'WTF'
--				then FeedToGain + ((270 - AverageOut_Wt) * 0.005)
--			else FeedToGain
--		end
, AdjFeedToGain =
		case 
			when Phase = 'NUR'
			then (case when isnull(WeightGained,0) <> 0 then isnull(Feed_Qty,0) / WeightGained else 0 end) 
			+ ((50 - case when isnull(TransferIn_Qty,0) <> 0 then isnull(TransferIn_Wt,0) / TransferIn_Qty else 0 end) * 0.005)
--			+ ((270 - case when (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0)) <> 0
--			then (isnull(Prim_Wt,0) + isnull(Cull_Wt,0) + isnull(DeadPigsToPacker_Wt,0) + isnull(TransferToTailender_Wt,0) + isnull(TransferOut_Wt,0) + isnull(TransportDeath_Wt,0)) / (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0))
--			else 0
--			end) * 0.005)
			

			when Phase = 'FIN'
			then (case when isnull(WeightGained,0) <> 0 then isnull(Feed_Qty,0) / WeightGained else 0 end) 
			+ ((50 - case when (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0)) <> 0
			then (isnull(Prim_Wt,0) + isnull(Cull_Wt,0) + isnull(DeadPigsToPacker_Wt,0) + isnull(TransferToTailender_Wt,0) + isnull(TransferOut_Wt,0) + isnull(TransportDeath_Wt,0)) / (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0))
			else 0
			end)* 0.005)
			+ ((270 - case when isnull(TransferIn_Qty,0) <> 0 then isnull(TransferIn_Wt,0) / TransferIn_Qty else 0 end) * 0.005)


			when Phase = 'WTF'
			then (case when isnull(WeightGained,0) <> 0 then isnull(Feed_Qty,0) / WeightGained else 0 end)
				+ ((270 - case when (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0)) <> 0
			then (isnull(Prim_Wt,0) + isnull(Cull_Wt,0) + isnull(DeadPigsToPacker_Wt,0) + isnull(TransferToTailender_Wt,0) + isnull(TransferOut_Wt,0) + isnull(TransportDeath_Wt,0)) / (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0))
			else 0
			end) * 0.005)
			else 
				(case when isnull(WeightGained,0) <> 0 then isnull(Feed_Qty,0) / WeightGained else 0 end)
		end * wa.adjwgt_gain
,AdjAverageDailyGain =
            case
                  when Phase = 'NUR'
                        then case when isnull(TotalHeadProduced,0) = 0 then 0 
                        else case when (LivePigDays / TotalHeadProduced) <= 43
                        then ((43 - (LivePigDays / TotalHeadProduced)) * 0.015) 
                        --+ AverageDailyGain
                        + case when isnull(TotalPigDays,0) <> 0	then isnull(WeightGained,0) / TotalPigDays	else 0	end
                        else 
                        --AverageDailyGain 
                        case when isnull(TotalPigDays,0) <> 0	then isnull(WeightGained,0) / TotalPigDays	else 0	end
                        - (((LivePigDays / TotalHeadProduced) - 43) * 0.015) end end
                  when Phase = 'FIN'
                        then case 
                        when case when isnull(TotalPigDays,0) <> 0	then isnull(WeightGained,0) / TotalPigDays	else 0	end > 0 
                        then case when isnull(TotalPigDays,0) <> 0	then isnull(WeightGained,0) / TotalPigDays	else 0	end
                        + ((50 - 
                        case 
							when isnull(TransferIn_Qty,0) <> 0
							then isnull(TransferIn_Wt,0) / TransferIn_Qty
							else 0
						end) * 0.005)
                        + ((270 - 
                        case 
							when (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0)) <> 0
							then (isnull(Prim_Wt,0) + isnull(Cull_Wt,0) + isnull(DeadPigsToPacker_Wt,0) + isnull(TransferToTailender_Wt,0) + isnull(TransferOut_Wt,0) + isnull(TransportDeath_Wt,0)) / (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0))
							else 0
						end) * 0.001) else 0 end 
                  when Phase = 'WTF'
                        then case 
                        when case when isnull(TotalPigDays,0) <> 0	then isnull(WeightGained,0) / TotalPigDays	else 0	end > 0 
                        then case when isnull(TotalPigDays,0) <> 0	then isnull(WeightGained,0) / TotalPigDays	else 0	end
                        + ((270 - 
                        case 
							when (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0)) <> 0
							then (isnull(Prim_Wt,0) + isnull(Cull_Wt,0) + isnull(DeadPigsToPacker_Wt,0) + isnull(TransferToTailender_Wt,0) + isnull(TransferOut_Wt,0) + isnull(TransportDeath_Wt,0)) / (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0))
							else 0
						end) * 0.001) else 0 end  
                  else case when isnull(TotalPigDays,0) <> 0	then isnull(WeightGained,0) / TotalPigDays	else 0	end
            end
, Mortality =
		case when isnull(HeadStarted,0) <> 0
			then (cast(isnull(PigDeath_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
			else 0
		end
--, DOTDIY = case when isnull(HeadStarted,0) <> 0
--		 then (cast(isnull(DeadOnTruck_Qty+DeadInYard_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
--		 else 0 end
-- fixing calculation error
,DOTDIY = case when isnull(HeadStarted,0) <> 0
		 then (cast(isnull(DeadOnTruck_Qty+DeadInYard_Qty+transportdeath_qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
		 else 0 end
, SeaAdjADG =
            case
                  when Phase = 'NUR'
                        then case when isnull(TotalHeadProduced,0) = 0 then 0 
                        else case when (LivePigDays / TotalHeadProduced) <= 43
                        then ((43 - (LivePigDays / TotalHeadProduced)) * 0.015) 
                        --+ AverageDailyGain
                        + case when isnull(TotalPigDays,0) <> 0	then isnull(WeightGained,0) / TotalPigDays	else 0	end
                        else 
                        --AverageDailyGain 
                        case when isnull(TotalPigDays,0) <> 0	then isnull(WeightGained,0) / TotalPigDays	else 0	end
                        - (((LivePigDays / TotalHeadProduced) - 43) * 0.015) end end
                  when Phase = 'FIN'
                        then case 
                        when case when isnull(TotalPigDays,0) <> 0	then isnull(WeightGained,0) / TotalPigDays	else 0	end > 0 
                        then case when isnull(TotalPigDays,0) <> 0	then isnull(WeightGained,0) / TotalPigDays	else 0	end
                        + ((50 - 
                        case 
							when isnull(TransferIn_Qty,0) <> 0
							then isnull(TransferIn_Wt,0) / TransferIn_Qty
							else 0
						end) * 0.005)
                        + ((270 - 
                        case 
							when (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0)) <> 0
							then (isnull(Prim_Wt,0) + isnull(Cull_Wt,0) + isnull(DeadPigsToPacker_Wt,0) + isnull(TransferToTailender_Wt,0) + isnull(TransferOut_Wt,0) + isnull(TransportDeath_Wt,0)) / (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0))
							else 0
						end) * 0.001) else 0 end 
                  when Phase = 'WTF'
                        then case 
                        when case when isnull(TotalPigDays,0) <> 0	then isnull(WeightGained,0) / TotalPigDays	else 0	end > 0 
                        then case when isnull(TotalPigDays,0) <> 0	then isnull(WeightGained,0) / TotalPigDays	else 0	end
                        + ((270 - 
                        case 
							when (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0)) <> 0
							then (isnull(Prim_Wt,0) + isnull(Cull_Wt,0) + isnull(DeadPigsToPacker_Wt,0) + isnull(TransferToTailender_Wt,0) + isnull(TransferOut_Wt,0) + isnull(TransportDeath_Wt,0)) / (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0))
							else 0
						end) * 0.001) else 0 end  
                  else case when isnull(TotalPigDays,0) <> 0	then isnull(WeightGained,0) / TotalPigDays	else 0	end
            end * wa.adjwgt_gain
, SeadAdjFE =
		case 
			when Phase = 'NUR'
			then (case when isnull(WeightGained,0) <> 0 then isnull(Feed_Qty,0) / WeightGained else 0 end) 
			+ ((50 - case when (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0)) <> 0
			then (isnull(Prim_Wt,0) + isnull(Cull_Wt,0) + isnull(DeadPigsToPacker_Wt,0) + isnull(TransferToTailender_Wt,0) + isnull(TransferOut_Wt,0) + isnull(TransportDeath_Wt,0)) / (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0))
			else 0
			end)* 0.005)
--				then FeedToGain + ((50 - AverageOut_Wt) * 0.005)
			when Phase = 'FIN'
			then (case when isnull(WeightGained,0) <> 0 then isnull(Feed_Qty,0) / WeightGained else 0 end) 
			+ ((50 - case when (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0)) <> 0
			then (isnull(Prim_Wt,0) + isnull(Cull_Wt,0) + isnull(DeadPigsToPacker_Wt,0) + isnull(TransferToTailender_Wt,0) + isnull(TransferOut_Wt,0) + isnull(TransportDeath_Wt,0)) / (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0))
			else 0
			end)* 0.005)
--				then FeedToGain + ((50 - AverageOut_Wt) * 0.005)
			+ ((270 - case when (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0)) <> 0
			then (isnull(Prim_Wt,0) + isnull(Cull_Wt,0) + isnull(DeadPigsToPacker_Wt,0) + isnull(TransferToTailender_Wt,0) + isnull(TransferOut_Wt,0) + isnull(TransportDeath_Wt,0)) / (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0))
			else 0
			end) * 0.005)  -- finish part
--				then FeedToGain + ((50 - AveragePurchase_Wt) * 0.005) 
--				+ ((270 - AverageOut_Wt) * 0.005)

			when Phase = 'WTF'
			then (case when isnull(WeightGained,0) <> 0 then isnull(Feed_Qty,0) / WeightGained else 0 end)
				+ ((270 - case when (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0)) <> 0
			then (isnull(Prim_Wt,0) + isnull(Cull_Wt,0) + isnull(DeadPigsToPacker_Wt,0) + isnull(TransferToTailender_Wt,0) + isnull(TransferOut_Wt,0) + isnull(TransportDeath_Wt,0)) / (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0))
			else 0
			end) * 0.005)
--				then FeedToGain + ((270 - AverageOut_Wt) * 0.005)
			else 
				(case when isnull(WeightGained,0) <> 0 then isnull(Feed_Qty,0) / WeightGained else 0 end)
--				FeedToGain
		end * wa.adjfeed_consumption
from
(select picyear_week,picweek,phase
, Sum(HeadStarted) headstarted
, Sum(DeadOnTruck_Qty) DeadOnTruck_Qty
, Sum(DeadInYard_Qty) DeadInYard_Qty
, Sum(PigDeath_Qty) PigDeath_Qty
, Sum(Prim_Wt) Prim_Wt
, Sum(Cull_Wt) Cull_Wt
, Sum(DeadPigsToPacker_Wt) DeadPigsToPacker_Wt
, Sum(TransferToTailender_Wt) TransferToTailender_Wt
, sum(TransferOut_Wt) TransferOut_Wt
, sum(transportdeath_Wt) TransportDeath_Wt
, sum(TotalHeadProduced) TotalHeadProduced
, sum(transportdeath_Qty) TransportDeath_Qty 
, sum(TransferIn_Wt) TransferIn_Wt
, sum(TransferIn_Qty) TransferIn_Qty
, sum(Feed_Qty) Feed_Qty
, sum(WeightGained) WeightGained
, sum(TotalPigDays) TotalPigDays
, sum(LivePigDays) LivePigDays
from   dbo.cft_rpt_pig_master_group_dw  (nolock)
inner join [$(SolomonApp)].dbo.cftPigGroup cpg on cpg.PigGroupID=cft_rpt_pig_master_group_dw.MasterGroup and cpg.PigProdPodID!=53 -- Ignore SBF pig groups
group by picyear_week,picweek,phase) SM
left join  dbo.cft_weekly_adjustments wa (nolock)
	on wa.picweek = SM.picweek 
order by SM.phase, SM.picyear_week

END
