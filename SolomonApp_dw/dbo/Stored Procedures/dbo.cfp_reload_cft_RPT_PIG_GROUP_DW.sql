
CREATE PROCEDURE [dbo].[cfp_reload_cft_RPT_PIG_GROUP_DW]
AS
BEGIN

-- 2/26/2016, BMD, Excluded all the PigGroups that were sold to SeaBoard Foods from the table.
--                 These "sold" groups have a lot of incomplete data and are messing up reports (skewing ADG, FE, etc.)

-------------------------------------------------------------------------------------------------------
-- this is dependent on replication finishing, so should be run directly after log shipping completes
-------------------------------------------------------------------------------------------------------
--clear table for new data
truncate table  dbo.cft_RPT_PIG_GROUP_DW

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
insert into cft_RPT_PIG_GROUP_DW
([TaskID],[SiteContactID],[MasterGroup],[PigFlowID],reportinggroupid,[ActCloseDate],[ActStartDate],[MasterActCloseDate],[MasterActStartDate],[BarnNbr],[Description],[PodDescription]
,[PGStatusID],[PigGenderTypeID],[Phase],[PhaseDesc],[SvcManager],[SrSvcManager],[MasterSvcManager],[MasterSrSvcManager],[LivePigDays],[DeadPigDays],[TotalPigDays]
,[Feed_Qty],[TransferIn_Qty],[MoveIn_Qty],[MoveOut_Qty],[PigDeath_Qty],[PigDeath_pretot_Qty],[TransferOut_Qty],[TransferToTailender_Qty],[Prim_Qty],[Cull_Qty],[euthanized_Qty],[Deadb4Grade_Death_Qty]
,[DeadPigsToPacker_Qty],[TransportDeath_Qty],[InventoryAdjustment_Qty],[Top_Qty],[TransferIn_Wt],[MoveIn_Wt],[MoveOut_Wt],[TransferOut_Wt],[TransferToTailender_Wt],[Prim_Wt]
,[Cull_Wt],[euthanized_Wt],[Deadb4Grade_Death_Wt],[DeadPigsToPacker_Wt],[TransportDeath_Wt],[Top_Wt],[MedicationCost],[WeightGained],[HeadStarted],[TotalHeadProduced],[AverageDailyGain]
,[SeaAverageDailyGain],[FeedToGain],[AdjFeedToGain],[SeaAdjFeedToGain],[Mortality],[AveragePurchase_Wt],[AverageOut_Wt],[AverageDailyFeedIntake],[Tailender_Pct],[DeadPigsToPacker_Pct]
,[Cull_Pct],[NoValue_Pct],[MedicationCostPerHead],[VaccinationCost],[FeedCost],[HeadCapacity],[PigStartDate],[PigEndDate],[HeadSold],[AverageMarket_Wt],[DaysInGroup]
,[PigCapacityDays],[EmptyDays],[EmptyCapacityDays],[CapacityDays],[TotalCapacityDays],[AverageDaysInGroup],[AverageEmptyDays],[Utilization],[MedicationCostPerHeadSold]
,[VaccinationCostPerHeadSold],[FeedCostPerHundredGain],[AdjAverageDailyGain],[DeadOnTruck_qty],[DeadInYard_qty],[CondemnedByPacker_qty],[Condemned_qty],[DeadOnTruck_wt]
,[DeadInYard_wt],[CondemnedByPacker_wt],[Condemned_wt],[DOTDIY],[DayDate],[DayName],[PICCycle],[PICDayNbr],[WeekOfDate],[FiscalPeriod],[FiscalYear]
,[PICWeek],[PICYear],[PICYear_Week],[WeekEndDate],[PICQuarter])
select mg.taskid,[SiteContactID],[MasterGroup],[PigFlowID],reportinggroupid,[ActCloseDate],[ActStartDate],[MasterActCloseDate],[MasterActStartDate],[BarnNbr],[Description],[PodDescription]
,[PGStatusID],[PigGenderTypeID],[Phase],[PhaseDesc],[SvcManager],[SrSvcManager],[MasterSvcManager],[MasterSrSvcManager],[LivePigDays],[DeadPigDays],[TotalPigDays]
,[Feed_Qty],[TransferIn_Qty],[MoveIn_Qty],[MoveOut_Qty],[PigDeath_Qty]
,([PigDeath_Qty] - [euthanized_Qty] - [Deadb4Grade_Death_Qty]) as PigDeath_pretot_qty  -- pretotal or reported pig deaths
,[TransferOut_Qty],[TransferToTailender_Qty],[Prim_Qty],[Cull_Qty],[euthanized_Qty],[Deadb4Grade_Death_Qty]
,[DeadPigsToPacker_Qty],[TransportDeath_Qty],[InventoryAdjustment_Qty],[Top_Qty],[TransferIn_Wt],[MoveIn_Wt],[MoveOut_Wt],[TransferOut_Wt],[TransferToTailender_Wt],[Prim_Wt]
,[Cull_Wt],[euthanized_Wt],[Deadb4Grade_Death_Wt],[DeadPigsToPacker_Wt],[TransportDeath_Wt],[Top_Wt],[MedicationCost],[WeightGained],[HeadStarted],[TotalHeadProduced],[AverageDailyGain]
,[SeaAdjAverageDailyGain] = case
                  when mg.Phase = 'NUR'
                        then case when isnull(mg.TotalHeadProduced,0) = 0 then 0 
                        else case when (mg.LivePigDays / mg.TotalHeadProduced) <= 43
                        then ((43 - (mg.LivePigDays / mg.TotalHeadProduced)) * 0.015) + (case when isnull(mg.TotalPigDays,0) <> 0
						then isnull(wadj.AdjWgt_Gain,0) / mg.TotalPigDays else 0
						end) else (case when isnull(mg.TotalPigDays,0) <> 0
						then isnull(wadj.AdjWgt_Gain,0) / mg.TotalPigDays else 0
						end) - (((mg.LivePigDays / mg.TotalHeadProduced) - 43) * 0.015) end end
                  when Phase = 'FIN'
                        then case when (case when isnull(mg.TotalPigDays,0) <> 0
						then isnull(wadj.AdjWgt_Gain,0) / mg.TotalPigDays else 0
						end) > 0 then (case when isnull(mg.TotalPigDays,0) <> 0
						then isnull(wadj.AdjWgt_Gain,0) / mg.TotalPigDays else 0
						end) + ((50 - (case when isnull(mg.TransferIn_Qty,0) <> 0
						then isnull(mg.TransferIn_Wt,0) / mg.TransferIn_Qty
						else 0 end)) * 0.005)
                        + ((270 - (case when (isnull(mg.TotalHeadProduced,0) + isnull(mg.TransportDeath_Qty,0)) <> 0
						then (isnull(mg.Prim_Wt,0) + isnull(mg.Cull_Wt,0) + isnull(mg.DeadPigsToPacker_Wt,0) + isnull(mg.TransferToTailender_Wt,0) + isnull(mg.TransferOut_Wt,0) + isnull(mg.TransportDeath_Wt,0)) / (isnull(mg.TotalHeadProduced,0) + isnull(mg.TransportDeath_Qty,0))
						else 0 end)) * 0.001) else 0 end 
                  when Phase = 'WTF'
                        then case when (case when isnull(mg.TotalPigDays,0) <> 0
						then isnull(wadj.AdjWgt_Gain,0) / mg.TotalPigDays else 0
						end) > 0 then (case when isnull(mg.TotalPigDays,0) <> 0
						then isnull(wadj.AdjWgt_Gain,0) / mg.TotalPigDays else 0
						end) + ((270 - (case when (isnull(mg.TotalHeadProduced,0) + isnull(mg.TransportDeath_Qty,0)) <> 0
						then (isnull(mg.Prim_Wt,0) + isnull(mg.Cull_Wt,0) + isnull(mg.DeadPigsToPacker_Wt,0) + isnull(mg.TransferToTailender_Wt,0) + isnull(mg.TransferOut_Wt,0) + isnull(mg.TransportDeath_Wt,0)) / (isnull(mg.TotalHeadProduced,0) + isnull(mg.TransportDeath_Qty,0))
						else 0 end)) * 0.001) else 0 end  
                  else (case when isnull(mg.TotalPigDays,0) <> 0
						then isnull(wadj.AdjWgt_Gain,0) / mg.TotalPigDays else 0
						end)
            end
      ,[FeedToGain]
      ,[AdjFeedToGain]
      ,[SeaAdjFeedToGain]= case 
			when Phase = 'NUR'
			then (case when isnull(mg.WeightGained,0) <> 0
			then isnull(wadj.AdjFeed_Consumption,0) / mg.WeightGained
			else 0 end) + ((50 - (case when (isnull(mg.TotalHeadProduced,0) + isnull(mg.TransportDeath_Qty,0)) <> 0
			then (isnull(mg.Prim_Wt,0) + isnull(mg.Cull_Wt,0) + isnull(mg.DeadPigsToPacker_Wt,0) + isnull(mg.TransferToTailender_Wt,0) + isnull(mg.TransferOut_Wt,0) + isnull(mg.TransportDeath_Wt,0)) / (isnull(mg.TotalHeadProduced,0) + isnull(mg.TransportDeath_Qty,0))
			else 0 end)) * 0.005)
			when Phase = 'FIN'
			then (case when isnull(mg.WeightGained,0) <> 0
			then isnull(wadj.AdjFeed_Consumption,0) / mg.WeightGained
			else 0 end) + ((50 - (case when isnull(mg.TransferIn_Qty,0) <> 0
			then isnull(mg.TransferIn_Wt,0) / mg.TransferIn_Qty
			else 0 end)) * 0.005) + ((270 - (case when (isnull(mg.TotalHeadProduced,0) + isnull(mg.TransportDeath_Qty,0)) <> 0
			then (isnull(mg.Prim_Wt,0) + isnull(mg.Cull_Wt,0) + isnull(mg.DeadPigsToPacker_Wt,0) + isnull(mg.TransferToTailender_Wt,0) + isnull(mg.TransferOut_Wt,0) + isnull(mg.TransportDeath_Wt,0)) / (isnull(mg.TotalHeadProduced,0) + isnull(mg.TransportDeath_Qty,0))
			else 0 end)) * 0.005)
			when Phase = 'WTF'
			then (case when isnull(mg.WeightGained,0) <> 0
			then isnull(wadj.AdjFeed_Consumption,0) / mg.WeightGained
			else 0 end) + ((270 - (case when (isnull(mg.TotalHeadProduced,0) + isnull(mg.TransportDeath_Qty,0)) <> 0
			then (isnull(mg.Prim_Wt,0) + isnull(mg.Cull_Wt,0) + isnull(mg.DeadPigsToPacker_Wt,0) + isnull(mg.TransferToTailender_Wt,0) + isnull(mg.TransferOut_Wt,0) + isnull(mg.TransportDeath_Wt,0)) / (isnull(mg.TotalHeadProduced,0) + isnull(mg.TransportDeath_Qty,0))
			else 0 end)) * 0.005)
			else (case when isnull(mg.WeightGained,0) <> 0
			then isnull(wadj.AdjFeed_Consumption,0) / mg.WeightGained
			else 0
		end) end
,[Mortality],[AveragePurchase_Wt],[AverageOut_Wt],[AverageDailyFeedIntake],[Tailender_Pct],[DeadPigsToPacker_Pct]
,[Cull_Pct],[NoValue_Pct],[MedicationCostPerHead],[VaccinationCost],[FeedCost],[HeadCapacity],[PigStartDate],[PigEndDate],[HeadSold],[AverageMarket_Wt],[DaysInGroup]
,[PigCapacityDays],[EmptyDays],[EmptyCapacityDays],[CapacityDays],[TotalCapacityDays],[AverageDaysInGroup],[AverageEmptyDays],[Utilization],[MedicationCostPerHeadSold]
,[VaccinationCostPerHeadSold],[FeedCostPerHundredGain],[AdjAverageDailyGain],[DeadOnTruck_qty],[DeadInYard_qty],[CondemnedByPacker_qty],[Condemned_qty],[DeadOnTruck_wt]
,[DeadInYard_wt],[CondemnedByPacker_wt],[Condemned_wt]
	  , DOTDIY = case when isnull(mg.HeadStarted,0) <> 0
		 then (cast(isnull(mg.DeadOnTruck_Qty+mg.DeadInYard_Qty+mg.transportdeath_qty,0) as numeric(14,2)) / cast(mg.HeadStarted as numeric(14,2))) * 100
		 else 0 end
,[DayDate],[DayName],[PICCycle],[PICDayNbr],[WeekOfDate],[FiscalPeriod],[FiscalYear]
,dw.[PICWeek],[PICYear],[PICYear_Week],[WeekEndDate],[PICQuarter]
from  dbo.cft_PIG_GROUP_ROLLUP mg (nolock)
left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw
	on mg.ActCloseDate = dw.DayDate
left join [dbo].[cft_weekly_adjustments] as wadj (nolock)
	on dw.picweek = wadj.picweek
Where mg.MasterGroup not in ( -- Ignore these sold SBF pig groups
		 56024, 56023, 56022, 56278, 56276, 56275, 56279, 56277, 55696, 55697, 55698, 55699, 57231, 57230, 57229, 57115,
		 57116, 57117, 56989, 56990, 56992, 56991, 56295, 57225, 57224, 56110, 56109, 56108, 56431, 56432, 56433, 56434,
		 57336, 57337, 57338, 57339, 57246, 57247, 57248, 56684, 56683, 56685, 57222, 57223, 56552, 56768, 56553, 55910,
		 55989, 56798, 56800, 57012, 57013, 57015, 54794, 56655, 57172, 55226, 56642, 56643, 57438, 57633, 56735, 57634,
		 56040, 56201, 56202, 56710, 56918, 56785, 56786, 56788, 56789, 56790, 57145, 56919, 57391, 57392, 56993, 56994,
		 57086, 57085, 57088, 57087, 55928, 55929, 55930, 55937, 55938, 56092, 56093, 57393, 56854, 56855, 56856, 57209,
		 57210, 56368, 56369, 56557, 56558, 56559, 56039, 56200, 56199, 56149, 56150, 56930, 56931, 56932, 56933, 55417,
		 55676, 55863, 56244, 57328, 57327, 55922, 55925, 55927, 57365, 57485, 57483, 57484, 56456, 56203, 56457, 56796,
		 57140, 57143, 57141, 57142, 56621, 56623, 56620, 56622, 57137, 57139, 57138, 57136, 56436, 56435, 56437, 56702,
		 56703, 56604, 56605, 56606, 57144, 56527, 56528, 56529, 56530, 56897, 56900, 56898, 56899, 55642, 55223, 55224,
		 56476, 56408, 56407, 56377, 56378, 56376, 56375, 56667, 56668, 56882, 56883, 57372, 57373, 57375, 57374, 57390,
		 57389, 56917, 57341, 57342, 57340, 56594, 56595, 56596, 56220, 56222, 56221, 56857, 56858, 56887, 56886, 57061,
		 57377, 57376, 57378, 56050, 56819, 56818, 56820, 56159, 56761, 56398, 56170, 56160, 56161, 56958, 56572, 56480,
		 56727, 57418, 55962, 55961, 55963, 56062, 56063, 56064, 57234, 57233, 57232, 56076, 56078, 56079, 56077, 56570,
		 56571, 57177, 57178, 57179, 56871, 56870, 55613, 57043, 57044, 57045, 55924, 55926, 57585, 56366, 56367, 56556,
		 55936, 56399, 56795, 56797, 56799, 57054, 57050, 57052, 57051, 57053, 57304, 57977, 56095, 56014, 56096, 54876,
		 54877, 56701, 56700, 56880, 56878, 56879, 56881, 55436, 55435, 55434, 55234, 55235, 55236, 56708, 56709, 56045,
		 56171, 56172, 56310, 56658, 57305, 58079, 57480, 57479, 57487, 57486, 57636
		)

END
