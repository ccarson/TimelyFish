












-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FLOW_KPI_ADG
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FLOW_KPI_ADG_all]
	@pg_week char(6)
	AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
SET NOCOUNT ON;

declare @startday datetime

declare @start50 char(6)
declare @w23 char(6)
declare @w25 char(6)
declare @w26 char(6)
declare @w48 char(6)
declare @w51 char(6)


declare @pos int, @parmcnt int
set @pos = 1
set @parmcnt = 1

--select @pg_week = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
--where daydate = cast(getdate() as date)

-- get last date value for the selected week
select @startday = max(daydate) from  dbo.cftDayDefinition_WithWeekInfo
where picyear_week = @pg_week

select @w25 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-25,@startday)		-- Dan week0 - week25

select @start50 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-50,@startday)		-- Dan week0 - week25
--where daydate = dateadd(d,-182,@startday)

select @w23 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-23,@startday)	
select @w26 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-26,@startday)	
select @w48 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-48,@startday)		
select @w51 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-51,@startday)


select distinct reportinggroupid
,case when reporting_group_description = 'LDC' then 'C27,C28,C29,C30,C31'
     when reporting_group_description = 'ON' then 'C32,C33,C34,C35,C36,C37'
     else reporting_group_description
end reporting_group_description
into #pf_list
from [dbo].[cft_SLF_ESSBASE_DATA] 
 where pg_week between @w25 and @pg_week

 
 
select distinct reportinggroupid
,case when reporting_group_description = 'LDC' then 'C27,C28,C29,C30,C31'
     when reporting_group_description = 'ON' then 'C32,C33,C34,C35,C36,C37'
     else reporting_group_description
end reporting_group_description
, pg_week, dw23.picyear_week as w23, dw26.picyear_week as w26 
into #lookback
from [dbo].[cft_SLF_ESSBASE_DATA] eb (nolock) 
join  dbo.cftDayDefinition_WithWeekInfo dw (nolock)
	on dw.dayname = 'sunday' and dw.picyear_week = eb.pg_week
join  dbo.cftDayDefinition_WithWeekInfo dw23 (nolock)
	on dw23.dayname = 'sunday' and dateadd(ww,-22,dw.daydate) = dw23.daydate
join  dbo.cftDayDefinition_WithWeekInfo dw26 (nolock)
	on dw26.dayname = 'sunday' and dateadd(ww,-25,dw.daydate) = dw26.daydate
where pg_week between @w25 and @pg_week


select @w23 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-23,@startday)


 
--  translate the reportinggroupid to the farmid(farm text from the reporting_group_description
declare @farmid_list varchar(500)

--Select @farmid_list = COALESCE(@farmid_list + ', ', '') + reporting_group_description 
--from #pf_list

select @farmid_list = COALESCE(@farmid_list + ', ', '') + reporting_group_description
from #pf_list

declare @farmid varchar(500)
select pcf.farm_name, reportinggroupid, reporting_group_description
into #rptgrp_farmid
from 
(select distinct reportinggroupid 
	,COALESCE(@farmid + ', ', '') + 
	case when reporting_group_description = 'LDC' then 'C27,C28,C29,C30,C31'
		 when reporting_group_description = 'ON' then 'C32,C33,C34,C35,C36,C37'
		 else reporting_group_description
	end reporting_group_description 
from [dbo].[cft_SLF_ESSBASE_DATA]
where pg_week between @w26 and @pg_week) rglist
join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	on charindex(pcf.farm_name,rglist.reporting_group_description) > 0 

--   


-- provides information for #ess_nur_wgt.TransferInWP_Wt/#ess_nur_wgt.[TransferInWP_Qty] as 'Avg Wean Weight'
select reportinggroupid, case when sum(transferinwp_qty) = 0 then null else sum(transferinwp_qty) end transferinwp_qty, sum(transferinwp_wt) transferinwp_wt
into #ESS_nur_wgt
 from [dbo].[cft_SLF_ESSBASE_DATA] 
 where pg_week between @w25 and @pg_week
  and phase in ('nur','wtf')	--= 'NUR'
  and livepigdays > 0
  and TransferInWP_Qty > 0
group by reportinggroupid

select reportinggroupid
,(sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt]) 
+ sum(transferout_wt) + sum(pigdeathTD_wt) + sum(transportdeath_wt) + sum(transfertotailender_wt)  ) as final_wgt    -- final weight
, 
(sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) )  as init_wgt --initial weight
, 
case when (sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty)  - sum(moveout_qty) ) = 0 then null else
 (sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty)  - sum(moveout_qty) )
end  
as init_qty --initial quantity
,case when (sum([LivePigDays]) + sum([DeadPigDays])) = 0 then null else (sum([LivePigDays]) + sum([DeadPigDays])) end  pigdays
into #ESS_nur
from [dbo].[cft_SLF_ESSBASE_DATA] 
 where pg_week between @w25 and @pg_week
  and phase = 'NUR'
  and livepigdays > 0
  and TransferInWP_Qty > 0
group by reportinggroupid


select reportinggroupid
,(sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt]) 
+ sum(transferout_wt) + sum(pigdeathTD_wt) + sum(transportdeath_wt) + sum(transfertotailender_wt)  ) as final_wgt    -- final weight
, 
(sum([Prim_qty]) + sum([Cull_qty]) + sum([DeadOnTruck_qty]) + sum([DeadInYard_qty]) + sum([Condemn_qty]) 
+ sum(transferout_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) + sum(transfertotailender_qty)  ) as final_qty    -- final quantity
, case when  (sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) ) = 0 then null
  else (sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) )  
  end as init_wgt --initial weight
, case when (sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty)  - sum(moveout_qty) ) = 0 then null
  else (sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty)  - sum(moveout_qty) )  
  end as init_qty --initial quantity
,case when (sum([LivePigDays]) + sum([DeadPigDays])) = 0 then null else (sum([LivePigDays]) + sum([DeadPigDays])) end  pigdays
into #ESS_fin
 from [dbo].[cft_SLF_ESSBASE_DATA] 
 where pg_week between @w25 and @pg_week
  and phase = 'FIN'	
    and livepigdays > 0
group by reportinggroupid


select reportinggroupid
,(sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt]) 
+ sum(transferout_wt) + sum(pigdeathTD_wt) + sum(transportdeath_wt) + sum(transfertotailender_wt)  ) as final_wgt    -- final weight
, 
(sum([Prim_qty]) + sum([Cull_qty]) + sum([DeadOnTruck_qty]) + sum([DeadInYard_qty]) + sum([Condemn_qty]) 
+ sum(transferout_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) + sum(transfertotailender_qty)  ) as final_qty    -- final quantity
, case when  (sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) ) = 0 then null
  else (sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) )  
  end as init_wgt --initial weight
, case when (sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty)  - sum(moveout_qty) ) = 0 then null
  else (sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty)  - sum(moveout_qty) )  
  end as init_qty --initial quantity
,case when (sum([LivePigDays]) + sum([DeadPigDays])) = 0 then null else (sum([LivePigDays]) + sum([DeadPigDays])) end  pigdays
into #ESS_wtf
 from [dbo].[cft_SLF_ESSBASE_DATA] 
 where pg_week between @w25 and @pg_week
  and phase = 'wtf'	
    and livepigdays > 0
group by reportinggroupid


select farmid, sum(born_alive_qty) BA
,( sum(wean_qty) - sum(nurseon_qty) )  sumwqty,avg(wean_age) * ( sum(wean_qty) - sum(nurseon_qty) ) weandays
into #w51w26_pre
	 from  [dbo].[cft_SowMart_Detail_data] where farrow_picyear_week between @w51 and @w26 
		and farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid
	 

select fw.farmid, cast(sum(Born_Alive_qty) as float) born_alive_qty
,( sum(wean_qty) - sum(nurseon_qty) )  sumwqty,avg(wean_age) * ( sum(wean_qty) - sum(nurseon_qty) ) weandays
, (cast(sum(Born_Alive_qty) as float)  - cast(sum(wean_qty) as float) - cast(sum(nurseon_qty) as float)) pwm_num 
, (cast(sum(Born_Alive_qty) as float)) pwm_dem		-- only born alive no deads
--, (cast(sum(Born_Alive_qty) as float)+ cast(sum(Stillborn_qty) as float) + cast(sum(mummy_qty) as float)) pwm_dem
into #w48w23_pre
from [dbo].[cft_SowMart_detail_data] fw (nolock)
where fw.final_wean_picyear_week between @w48 and @w23
and fw.farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
group by fw.farmid

-- estimated to actual wean
select [FarmID]
      ,sum([Wean_qty]) Wean_qty
      ,sum([Litters_weaned_qty]) Litters_weaned_qty
into #EAwean_pre
from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
join #lookback on fw.reportinggroupid = #lookback.reportinggroupid and fw.picyear_week = #lookback.w23
where fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
group by fw.farmid

-- estimated to actual farrow
select [FarmID]
      ,sum([Litters_farrowed_qty]) Litters_farrowed_qty
      ,sum(born_alive_qty) born_alive_qty
into #EAfarrow_pre
from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
join #lookback on fw.reportinggroupid = #lookback.reportinggroupid and fw.picyear_week = #lookback.w26
where fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
group by fw.farmid


select xx.reportinggroupid, ( cast(sum(wean_qty) as float)/cast(sum(litters_weaned_qty) as float) ) gpw_per_sowwean
, (   (sum(cast(xx.born_alive_qty as float))/sum(cast(xx.litters_farrowed_qty as float)) ) - (sum(cast(xx.Wean_qty as float))/sum(cast(Litters_weaned_qty as float)) )  )
/    ( sum(cast(xx.born_alive_qty as float))/sum(cast(xx.litters_farrowed_qty as float)) ) as pwm_pct
, sum(xx.born_alive_qty) born_alive_qty
, sum(xx.litters_farrowed_qty) litters_farrowed_qty
, sum(xx.Wean_qty) Wean_qty
, sum(litters_weaned_qty) litters_weaned_qty
into #EA
	from
	(select distinct fid.reportinggroupid, f.Litters_farrowed_qty,f.born_alive_qty, w.Wean_qty, w.Litters_weaned_qty
	from #EAwean_pre w
	join #EAfarrow_pre f 
		on f.farmid = w.farmid
	join #rptgrp_farmid fid
	on fid.farm_name = w.farmid
	) xx
	group by xx.reportinggroupid
	
	

 select w25w0.reportinggroupid
, ( w25w0.TwgtM - 3*(w25w0.hs/(1- case when #ea.pwm_pct = 1 then null else #ea.pwm_pct end ))  ) 
/ ( w25w0.pigdays + ( (w25w0.hs/(1-case when #ea.pwm_pct = 1 then null else #ea.pwm_pct end)) ) * ( (w48w23.wean_age*(1-case when #ea.pwm_pct = 1 then null else #ea.pwm_pct end) ) + ( (w48w23.wean_age/2)*(#ea.pwm_pct) )  )     ) as 'ADG rollup'
into #ESS_rollup
 from 
(
select reportinggroupid
, sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt])  TwgtM   -- final weight  2014-07-03 maild from Dan
, sum(TransferInWP_qty) + Sum(TransferIn_qty) + Sum(MoveIn_qty) - sum(moveout_qty) - sum(transferout_qty)  HS
, sum(livepigdays+deadpigdays) pigdays
	 from [dbo].[cft_SLF_ESSBASE_DATA] where pg_week between @w25 and @pg_week --and phase in ('wtf', 'fin') 
	 and livepigdays > 0 
 group by reportinggroupid
 ) w25w0
 left join #EA
	on #EA.reportinggroupid = w25w0.reportinggroupid 
left join 
(
	select yy.reportinggroupid, sum(weandays)/sum(sumwqty) wean_age, sum(born_alive_qty) born_alive_qty, sum(pwm_num)/sum(pwm_dem) as pwm
	from
	(select distinct fid.reportinggroupid, f.*
	from #w48w23_pre f
	join #rptgrp_farmid fid
		on fid.farm_name = f.farmid
	) yy
	group by yy.reportinggroupid
) w48w23
	on w48w23.reportinggroupid = w25w0.reportinggroupid
where  w25w0.pigdays <> 0 and w25w0.reportinggroupid <> 0





select farmid, ( sum(wean_qty) - sum(nurseon_qty) )  sumwqty
,  avg(wean_age) * ( sum(wean_qty) - sum(nurseon_qty) ) weandays	 -- subtract nurseon
into #wean_pre
from  [dbo].[cft_SowMart_Detail_data] (nolock)
where final_wean_picyear_week between @w48 and @w23
and farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
group by farmid

select reportinggroupid, sum(sumwqty) sumwqty, sum(weandays)/sum(sumwqty) avgWage, sum(weandays) weandays
into #wean
from
(select distinct fid.reportinggroupid, f.*
from #wean_pre f
	join #rptgrp_farmid fid
		on fid.farm_name = f.farmid
join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	on f.farmid = pcf.farm_name
join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	on cast(pcf.farm_number as int) = cast(pff.contactid as int)
join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	on pff.pigflowid = pf.pigflowid
join #pf_list l
	on l.reportinggroupid = pf.reportinggroupid
	) xx
group by xx.reportinggroupid




select w.reportinggroupid
, sum(w.weandays) weandays
, case when sum(w.weandays)/sum(sumwqty) = 0 then null else  sum(w.weandays)/sum(sumwqty) end avgage
, sum(sumwqty) sumwqty
into #WeanAge
from #wean  w
group by w.reportinggroupid


select 
  @pg_week as picyearweek
, S.reportinggroupid
, S.Reporting_Group_Description
, wa.avgage as 'Avg Wean Age'
, #ess_nur_wgt.TransferInWP_Wt/#ess_nur_wgt.[TransferInWP_Qty] as 'Avg Wean Weight'
, ((#ess_nur_wgt.TransferInWP_Wt/#ess_nur_wgt.[TransferInWP_Qty]) - 3.0) / wa.avgage as 'ADG FH'		
, ( (#ess_nur.final_wgt - #ess_nur.init_wgt)/#ess_nur.pigdays ) + ( (50 - (#ess_nur.init_wgt/#ess_nur.init_qty)) * .005 ) as 'ADG Nursery'	--  ess_nur(26 weeks)
, ( (#ess_fin.final_wgt - #ess_fin.init_wgt)/#ess_fin.pigdays ) + ( (50 - (#ess_fin.init_wgt/#ess_fin.init_qty)) * .005 ) + ( (270 - (#ess_fin.final_wgt/#ess_fin.final_qty)) * .001 ) as 'ADG Finish'	-- adjusted adg
, ( (#ess_wtf.final_wgt - #ess_wtf.init_wgt)/#ess_wtf.pigdays ) + ( (270 - (#ess_wtf.final_wgt/#ess_wtf.final_qty)) * .001 ) as 'ADG WTF'	-- adjusted adg
, #ESS_rollup.[adg rollup]
from (select distinct reportinggroupid, Reporting_Group_Description 
	  FROM [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] ) S
left join #pf_list
	on #pf_list.reportinggroupid = S.reportinggroupid
left join #ess_nur	--  ess_nur_wgt(26 weeks) 	
	on #pf_list.reportinggroupid = #ess_nur.reportinggroupid
left join #ess_nur_wgt	--  ess_nur_wgt(26 weeks)
	on #pf_list.reportinggroupid = #ess_nur_wgt.reportinggroupid
left join #ess_fin	--  (26 weeks)
	on #pf_list.reportinggroupid = #ess_fin.reportinggroupid
left join #ess_wtf	--  (26 weeks)
	on #pf_list.reportinggroupid = #ess_wtf.reportinggroupid
left join #WeanAge wa	-- wa.   week interval week 48 thru week 23
	on #pf_list.reportinggroupid = wa.reportinggroupid
left join #ESS_rollup
	on #pf_list.reportinggroupid = #ESS_rollup.reportinggroupid


END






























GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_FLOW_KPI_ADG_all] TO [db_sp_exec]
    AS [dbo];

