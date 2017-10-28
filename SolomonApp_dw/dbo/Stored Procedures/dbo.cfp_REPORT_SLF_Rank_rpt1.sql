




-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_Rank_rpt1
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_Rank_rpt1]
@PicYear_Week char(6), @SiteContactid char(6)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @phase char(3), @actstartdate smalldatetime

-- Identify the Phase
select top 1 @phase = phase, @actstartdate = actstartdate from cft_rpt_pig_master_group_dw mpg (nolock)
where picyear_week = @picyear_week and sitecontactid = @sitecontactid


	DECLARE @pigflowid int
-- Identify the pigflowid	
select @pigflowid = pigflowid from [dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
where picyear_week = @picyear_week and phase = @phase and sitecontactid = @sitecontactid

--get the previous closeout data for the site that exists before range of the current row (actclosedate < actstartdate)
declare @prior_wk char(6), @prior_mg char(10), @prior_pigflow int, @prior_phase char(3), @prior_start smalldatetime, @prior_close smalldatetime
select top 1 @prior_wk = picyear_week, @prior_mg = mastergroup, @prior_pigflow = pigflowid, @prior_phase = phase 
, @prior_start = actstartdate, @prior_close = actclosedate
from [dbo].[cft_RPT_PIG_MASTER_GROUP_DW] 
where picyear_week < @PicYear_Week
and sitecontactid = @SiteContactid
and actclosedate <= @actstartdate
order by picyear_week desc

-- generate rankings but we only want 1 row for the selected sitecontactid   !!! they want x of y rank values 1 of 10, need count of rows.
declare @adjadgrank varchar(10), @AdjFERank varchar(10), @MortRank varchar(10), @DOTDIYRank varchar(10), @ofY smallint

create table #ranking_basis
(ordgrp int not null
, sitegrp int not null
, sitecontactid char(10) not null
, picyear_week char(6) not null
, adjADG float null
, adjFE float null
, mort float null
, dotdiy float null
, phase varchar(3) not null
, pigflowid int not null
)


select @ofY = count(1)
from  dbo.cft_RPT_PIG_MASTER_GROUP_DW mgr
inner join [$(CentralData)].dbo.contact c (nolock) 
	on c.solomoncontactid = mgr.sitecontactid
where actclosedate between @prior_start and @prior_close
--picyear_week >= @prior_priordate and  picyear_week <= @Prior_Wk
and phase = @prior_phase
and pigflowid = @prior_pigflow;



WITH R (sitecontactid,picyear_week, contactname, phase, pigflowid, AdjAverageDailyGain,
AdjFeedToGain,
Mortality,
DOTDIY, adjadgrank, adjferank, mortrank, dotdiyrank)
AS
(
Select mgr.sitecontactid,PICYear_Week, c.contactname,Phase, pigflowid,AdjAverageDailyGain,AdjFeedToGain,Mortality,DOTDIY,
Rank() over (Partition by Phase, pigflowid Order by AdjAverageDailyGain desc) as 'AdjADGRank',
Rank() over (Partition by Phase, pigflowid Order by AdjFeedToGain) as 'AdjFERank',
Rank() over (Partition by Phase, pigflowid  Order by Mortality) as 'MortRank',
Rank() over (Partition by Phase, pigflowid  Order by dotdiy+1) as 'DOTDIYRank'
from  dbo.cft_RPT_PIG_MASTER_GROUP_DW mgr
inner join [$(CentralData)].dbo.contact c (nolock) 
	on c.solomoncontactid = mgr.sitecontactid
where actclosedate between @prior_start and @prior_close
and phase = @prior_phase
and pigflowid = @prior_pigflow
)
select 
  @AdjADGRank = cast(AdjADGRank as varchar(10))+' of '+cast(@ofY as varchar(5))
,  @AdjFERank = cast(AdjFERank as varchar(10))+' of '+cast(@ofY as varchar(5))
,  @MortRank =  cast(MortRank as varchar(10))+' of '+cast(@ofY as varchar(5))
,  @DOTDIYRank = cast(DOTDIYRank as varchar(10))+' of '+cast(@ofY as varchar(5))
from R
where sitecontactid = @sitecontactid
and picyear_week = @prior_wk

-- insert values for the site
insert into #ranking_basis
select 1 as ordgrp	, case when rb.sitecontactid = @sitecontactid then 1 else 0 end sitegrp
, rb.sitecontactid,rb.picyear_week
,case
      when Phase = 'NUR'
            then case when isnull(sum(TotalHeadProduced),0) = 0 then 0 
            else case when (sum(LivePigDays) / sum(TotalHeadProduced)) <= 43
            then ((43 - (sum(LivePigDays) / sum(TotalHeadProduced))) * 0.015) + (case when isnull(sum(TotalPigDays),0) <> 0 then isnull(sum(WeightGained),0) / sum(TotalPigDays) else 0	end)         
            else (case when isnull(sum(TotalPigDays),0) <> 0 then isnull(sum(WeightGained),0) / sum(TotalPigDays) else 0	end) - (((sum(LivePigDays) / sum(TotalHeadProduced)) - 43) * 0.015) end end
      when Phase = 'FIN'
            then 
			case when (sum(WeightGained) / sum(TotalPigDays)) > 0 then (sum(WeightGained) / sum(TotalPigDays))
				+ ((50 - isnull(sum(TransferIn_Wt),0) / sum(TransferIn_Qty)) * 0.005)
				+ ((270 - (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))) * 0.001) else 0 end 
	when Phase = 'WTF'
--			then case when isnull(sum(TransferIn_Wt),0) / sum(TransferIn_Qty) > 0 then isnull(sum(TransferIn_Wt),0) / sum(TransferIn_Qty)   *** wrong calc
			then case when (sum(WeightGained) / sum(TotalPigDays)) > 0 then (sum(WeightGained) / sum(TotalPigDays))
				+ ((270 - (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))) * 0.001) else 0 end
	else isnull(sum(TransferIn_Wt),0) / sum(TransferIn_Qty)
end adjADG
,case 
	when Phase = 'NUR'
		then case when isnull(sum(WeightGained),0) <> 0 then isnull(sum(Feed_Qty),0) / sum(WeightGained) else 0	end + ((50 - (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))) * 0.005)
	when Phase = 'FIN'
		then case when isnull(sum(WeightGained),0) <> 0 then isnull(sum(Feed_Qty),0) / sum(WeightGained) else 0	end + ((50 - isnull(sum(TransferIn_Wt),0) / sum(TransferIn_Qty)) * 0.005) + ((270 - (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))) * 0.005)
	when Phase = 'WTF'
		then case when isnull(sum(WeightGained),0) <> 0 then isnull(sum(Feed_Qty),0) / sum(WeightGained) else 0	end + ((270 - (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))) * 0.005)
	else case when isnull(sum(WeightGained),0) <> 0 then isnull(sum(Feed_Qty),0) / sum(WeightGained) else 0	end
end
,case when isnull(sum(HeadStarted),0) <> 0
then (cast(isnull(sum(PigDeath_Qty),0) as numeric(14,2)) / cast(sum(HeadStarted) as numeric(14,2))) * 100
else 0
end mort
,case when isnull(sum(rb.HeadStarted),0) <> 0
		 then (cast(isnull(sum(rb.DeadOnTruck_Qty)+sum(rb.DeadInYard_Qty)+sum(rb.transportdeath_qty),0) as numeric(14,2)) / cast(sum(rb.HeadStarted) as numeric(14,2))) * 100
		 else 0 end DOTDIY
, @phase
, @pigflowid
from cft_RPT_PIG_MASTER_GROUP_DW rb
where actclosedate >= @actstartdate
and  picyear_week <= @PicYear_Week
and phase = @phase
and pigflowid = @pigflowid
and sitecontactid = @sitecontactid
group by rb.sitecontactid,rb.picyear_week, rb.phase, case when rb.sitecontactid = @sitecontactid then 1 else 0 end, pigflowid

-- insert values for the other sites
insert into #ranking_basis
select 1 as ordgrp	, case when rb.sitecontactid = @sitecontactid then 1 else 0 end sitegrp
, rb.sitecontactid,rb.picyear_week
            --case
            --      when Phase = 'NUR'
            --            then case when isnull(TotalHeadProduced,0) = 0 then 0 
            --            else case when (LivePigDays / TotalHeadProduced) <= 43
            --            then ((43 - (LivePigDays / TotalHeadProduced)) * 0.015) + AverageDailyGain
            --            else AverageDailyGain - (((LivePigDays / TotalHeadProduced) - 43) * 0.015) end end
            --      when Phase = 'FIN'
            --            then case when AverageDailyGain > 0 then AverageDailyGain
            --            + ((50 - AveragePurchase_Wt) * 0.005)
            --            + ((270 - AverageOut_Wt) * 0.001) else 0 end 
            --      when Phase = 'WTF'
            --            then case when AverageDailyGain > 0 then AverageDailyGain
            --            + ((270 - AverageOut_Wt) * 0.001) else 0 end  
            --      else AverageDailyGain
            --end
,case
      when Phase = 'NUR'
            then case when isnull(sum(TotalHeadProduced),0) = 0 then 0 
            else case when (sum(LivePigDays) / sum(TotalHeadProduced)) <= 43
            then ((43 - (sum(LivePigDays) / sum(TotalHeadProduced))) * 0.015) + (case when isnull(sum(TotalPigDays),0) <> 0 then isnull(sum(WeightGained),0) / sum(TotalPigDays) else 0	end)         
            else (case when isnull(sum(TotalPigDays),0) <> 0 then isnull(sum(WeightGained),0) / sum(TotalPigDays) else 0	end) - (((sum(LivePigDays) / sum(TotalHeadProduced)) - 43) * 0.015) end end
      when Phase = 'FIN'
            then 
			case when (sum(WeightGained) / sum(TotalPigDays)) > 0 then (sum(WeightGained) / sum(TotalPigDays))
				+ ((50 - isnull(sum(TransferIn_Wt),0) / sum(TransferIn_Qty)) * 0.005)
				+ ((270 - (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))) * 0.001) else 0 end 
	when Phase = 'WTF'
--			then case when isnull(sum(TransferIn_Wt),0) / sum(TransferIn_Qty) > 0 then isnull(sum(TransferIn_Wt),0) / sum(TransferIn_Qty)   *** wrong calc
			then case when (sum(WeightGained) / sum(TotalPigDays)) > 0 then (sum(WeightGained) / sum(TotalPigDays))
				+ ((270 - (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))) * 0.001) else 0 end
	else isnull(sum(TransferIn_Wt),0) / sum(TransferIn_Qty)
end adjADG
,case 
	when Phase = 'NUR'
		then case when isnull(sum(WeightGained),0) <> 0 then isnull(sum(Feed_Qty),0) / sum(WeightGained) else 0	end + ((50 - (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))) * 0.005)
	when Phase = 'FIN'
		then case when isnull(sum(WeightGained),0) <> 0 then isnull(sum(Feed_Qty),0) / sum(WeightGained) else 0	end + ((50 - isnull(sum(TransferIn_Wt),0) / sum(TransferIn_Qty)) * 0.005) + ((270 - (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))) * 0.005)
	when Phase = 'WTF'
		then case when isnull(sum(WeightGained),0) <> 0 then isnull(sum(Feed_Qty),0) / sum(WeightGained) else 0	end + ((270 - (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0))) * 0.005)
	else case when isnull(sum(WeightGained),0) <> 0 then isnull(sum(Feed_Qty),0) / sum(WeightGained) else 0	end
end
,case when isnull(sum(HeadStarted),0) <> 0
then (cast(isnull(sum(PigDeath_Qty),0) as numeric(14,2)) / cast(sum(HeadStarted) as numeric(14,2))) * 100
else 0
end mort
,case when isnull(sum(rb.HeadStarted),0) <> 0
		 then (cast(isnull(sum(rb.DeadOnTruck_Qty)+sum(rb.DeadInYard_Qty)+sum(rb.transportdeath_qty),0) as numeric(14,2)) / cast(sum(rb.HeadStarted) as numeric(14,2))) * 100
		 else 0 end DOTDIY
, @phase
, @pigflowid
from cft_RPT_PIG_MASTER_GROUP_DW rb
where actclosedate >= @actstartdate
and  picyear_week <= @PicYear_Week
and phase = @phase
and pigflowid = @pigflowid
and sitecontactid <> @sitecontactid
group by rb.sitecontactid,rb.picyear_week, rb.phase	, case when rb.sitecontactid = @sitecontactid then 1 else 0 end
, pigflowid

Select 0 as ordgrp, case when sitecontactid = @sitecontactid and picyear_week = @picyear_week then 1 else 0 end, PICYear_Week,
case when phase = @phase then c.contactname
	 else c.contactname + ' (' + phase + ')'
end contactname,
Phase, pigflowid,
AdjAverageDailyGain,
AdjFeedToGain,
Mortality,
DOTDIY,
@AdjADGRank as 'AdjADGRank',
@AdjFERank  as 'AdjFERank',
@MortRank  as 'MortRank',
@DOTDIYRank  as 'DOTDIYRank'
from  dbo.cft_RPT_PIG_MASTER_GROUP_DW mgr
inner join [$(CentralData)].dbo.contact c (nolock) 
	on c.solomoncontactid = mgr.sitecontactid
where picyear_week = @prior_wk
and phase = @prior_phase
and pigflowid = @prior_pigflow
and mastergroup = @prior_mg 
union
Select 1 as ordgrp,case when sitecontactid = @sitecontactid and picyear_week = @picyear_week then 1 else 0 end
,rb.PICYear_Week, c.contactname,
rb.Phase, rb.pigflowid,
rb.adjadg as AdjAverageDailyGain,
rb.adjfe as AdjFeedToGain,
rb.mort as Mortality,
cast(rb.dotdiy as float) DOTDIY,
cast(Rank() over (Partition by rb.Phase, rb.pigflowid Order by rb.adjadg desc) as varchar(10)) as 'AdjADGRank',
cast(Rank() over (Partition by rb.Phase, rb.pigflowid Order by rb.adjfe) as varchar(10))  as 'AdjFERank',
cast(Rank() over (Partition by rb.Phase, rb.pigflowid  Order by rb.mort) as varchar(10))  as 'MortRank',
cast(Rank() over (Partition by rb.Phase, rb.pigflowid  Order by rb.dotdiy+1) as varchar(10))  as 'DOTDIYRank'
from #ranking_basis rb
inner join [$(CentralData)].dbo.contact c (nolock) 
	on c.solomoncontactid = rb.sitecontactid
order by ordgrp,picyear_week, 2


END

























GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_Rank_rpt1] TO [CorpReports]
    AS [dbo];

