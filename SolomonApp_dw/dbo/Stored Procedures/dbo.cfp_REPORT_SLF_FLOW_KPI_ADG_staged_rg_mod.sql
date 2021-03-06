﻿
-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FLOW_KPI_ADG
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FLOW_KPI_ADG_staged_rg_mod]
	@mg_week char(6), @reportinggroupid_list varchar(50)
	
	AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
SET NOCOUNT ON;

declare @startday datetime
declare @pg_week char(6)
declare @start50 char(6)
declare @w23 char(6)
declare @w25 char(6)
declare @w26 char(6)
declare @w48 char(6)
declare @w51 char(6)
declare @pf1 varchar(5)
declare @pf2 varchar(5)
declare @pf3 varchar(5)
declare @pf4 varchar(5)
declare @pf5 varchar(5)
declare @pf6 varchar(5)
declare @pf7 varchar(5)

set @pf1 = null
set @pf2 = null
set @pf3 = null
set @pf4 = null
set @pf5 = null
set @pf6 = null
set @pf7 = null

declare @pos int, @parmcnt int
set @pos = 1
set @parmcnt = 1

set @pg_week = @mg_week

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

--select @pos, @parmcnt, @reportinggroupid_list, 'begin'

while (charindex(',',@reportinggroupid_list) > 0) or ( (charindex(',',@reportinggroupid_list) = 0) and (len(@reportinggroupid_list) >= 2) or @parmcnt <= 4)
begin

if (charindex(',',@reportinggroupid_list) = 0) GOTO LAST_ONLY

select @pos = charindex(',',@reportinggroupid_list)

if (@parmcnt = 1)
	begin
		select @pf1 = substring(@reportinggroupid_list,1,@pos - 1)
		select @reportinggroupid_list = substring(@reportinggroupid_list,@pos+1,30)
	end
	
if (@parmcnt = 2)
	begin
		select @pf2 = substring(@reportinggroupid_list,1,@pos - 1)
		select @reportinggroupid_list = substring(@reportinggroupid_list,@pos+1,30)
	end
	
if (@parmcnt = 3)
	begin
		select @pf3 = substring(@reportinggroupid_list,1,@pos - 1)
		select @reportinggroupid_list = substring(@reportinggroupid_list,@pos+1,30)
	end
	
if (@parmcnt = 4)
	begin
		select @pf4 = substring(@reportinggroupid_list,1,@pos - 1)
		select @reportinggroupid_list = substring(@reportinggroupid_list,@pos+1,30)
	end
	
if (@parmcnt = 5)
	begin
		select @pf5 = substring(@reportinggroupid_list,1,@pos - 1)
		select @reportinggroupid_list = substring(@reportinggroupid_list,@pos+1,30)
	end

	
if (@parmcnt = 6)
	begin
		select @pf6 = substring(@reportinggroupid_list,1,@pos - 1)
		select @reportinggroupid_list = substring(@reportinggroupid_list,@pos+1,30)
	end

	
if (@parmcnt = 7)
	begin
		select @pf7 = substring(@reportinggroupid_list,1,@pos - 1)
		select @reportinggroupid_list = substring(@reportinggroupid_list,@pos+1,30)
	end

set @parmcnt = @parmcnt + 1
--select 'bottom of loop', @parmcnt

end

BYPASS:
	GOTO SKIPIT

LAST_ONLY:


if @parmcnt = 1  set @pf1 = substring(@reportinggroupid_list,1,4)
else if @parmcnt = 2  set @pf2 = substring(@reportinggroupid_list,1,4)
else if @parmcnt = 3  set @pf3 = substring(@reportinggroupid_list,1,4)
else if @parmcnt = 4  set @pf4 = substring(@reportinggroupid_list,1,4)
else if @parmcnt = 5  set @pf5 = substring(@reportinggroupid_list,1,4)
else if @parmcnt = 6  set @pf6 = substring(@reportinggroupid_list,1,4)
else if @parmcnt = 7  set @pf7 = substring(@reportinggroupid_list,1,4)

SKIPIT:

select distinct reportinggroupid, Reporting_Group_Description
into #pf_list
from [dbo].[cft_SLF_ESSBASE_DATA] 
 where pg_week between @w25 and @pg_week
 and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
 
--  translate the reportinggroupid to the farmid(farm text from the reporting_group_description
declare @farmid_list varchar(500)

--Select @farmid_list = COALESCE(@farmid_list + ', ', '') + reporting_group_description 
--from #pf_list

select @farmid_list = COALESCE(@farmid_list + ', ', '') + 
case when reporting_group_description = 'LDC' then 'C27,C28,C29,C30,C31'
     when reporting_group_description = 'ON' then 'C32,C33,C34,C35,C36,C37'
     else reporting_group_description
end
from #pf_list
--   


-- provides information for #ess_nur_wgt.TransferInWP_Wt/#ess_nur_wgt.[TransferInWP_Qty] as 'Avg Wean Weight'
select reportinggroupid, sum(transferinwp_qty) transferinwp_qty, sum(transferinwp_wt) transferinwp_wt
into #ESS_nur_wgt
 from [dbo].[cft_SLF_ESSBASE_DATA] 
 where pg_week between @w25 and @pg_week
  and phase in ('nur','wtf')	--= 'NUR'
  and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  and livepigdays > 0
  and TransferInWP_Qty > 0
group by reportinggroupid

select reportinggroupid
,(sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt]) 
+ sum(transferout_wt) + sum(pigdeathTD_wt) + sum(transportdeath_wt) + sum(transfertotailender_wt)  ) as final_wgt    -- final weight
, 
(sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) )  as init_wgt --initial weight
, 
(sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty)  - sum(moveout_qty) )  as init_qty --initial quantity
,(sum([LivePigDays]) + sum([DeadPigDays])) pigdays
into #ESS_nur
from [dbo].[cft_SLF_ESSBASE_DATA] 
 where pg_week between @w25 and @pg_week
  and phase = 'NUR'
  and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
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
,(sum([LivePigDays]) + sum([DeadPigDays])) pigdays
into #ESS_fin
 from [dbo].[cft_SLF_ESSBASE_DATA] 
 where pg_week between @w25 and @pg_week
  and phase = 'FIN'	
    and livepigdays > 0
  and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
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
,(sum([LivePigDays]) + sum([DeadPigDays])) pigdays
into #ESS_wtf
 from [dbo].[cft_SLF_ESSBASE_DATA] 
 where pg_week between @w25 and @pg_week
  and phase = 'wtf'	
    and livepigdays > 0
  and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
group by reportinggroupid


select farmid, sum(born_alive_qty) BA
,( sum(wean_qty) - sum(nurseon_qty) )  sumwqty,avg(wean_age) * ( sum(wean_qty) - sum(nurseon_qty) ) weandays
into #w51w26_pre
	 from  [dbo].[cft_SowMart_Detail_data] where farrow_picyear_week between @w51 and @w26 
		and farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid

select xx.reportinggroupid, sum(BA) BA, sum(weandays)/sum(sumwqty) avgWage
into #w51w26
from
(select distinct l.reportinggroupid, f.*
from #w51w26_pre f
join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	on f.farmid = pcf.farm_name
join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	on cast(pcf.farm_number as int) = cast(pff.contactid as int)
join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	on pff.pigflowid = pf.pigflowid
join #pf_list l
	on l.reportinggroupid = pf.reportinggroupid) xx
group by xx.reportinggroupid	 

select fw.farmid, cast(sum(Born_Alive_qty) as float) born_alive_qty
,( sum(wean_qty) - sum(nurseon_qty) )  sumwqty,avg(wean_age) * ( sum(wean_qty) - sum(nurseon_qty) ) weandays
--, (cast(sum(Born_Alive_qty) as float)  - cast(sum(wean_qty) as float) - cast(sum(nurseon_qty) as float)) pwm_num 
--, (cast(sum(Born_Alive_qty) as float)) pwm_dem		-- only born alive no deads
--, (cast(sum(Born_Alive_qty) as float)+ cast(sum(Stillborn_qty) as float) + cast(sum(mummy_qty) as float)) pwm_dem
, count(1) as litters_weaned_qty 
, sum(wean_qty) wean_qty
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
where fw.picyear_week between @w48 and @w23
and fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
group by fw.farmid

-- estimated to actual farrow
select [FarmID]
      ,sum([Litters_farrowed_qty]) Litters_farrowed_qty
into #EAfarrow_pre
from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
where fw.picyear_week between @w51 and @w26
and fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
group by fw.farmid

select xx.reportinggroupid, ( cast(sum(wean_qty) as float)/cast(sum(litters_weaned_qty) as float) ) gpw_per_sowwean
, sum(litters_farrowed_qty) litters_farrowed_qty
into #EA
	from
	(select distinct l.reportinggroupid, f.Litters_farrowed_qty, w.Wean_qty, w.Litters_weaned_qty
	from #EAwean_pre w
	join #EAfarrow_pre f 
		on f.farmid = w.farmid
	join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
		on w.farmid = pcf.farm_name
	join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
		on cast(pcf.farm_number as int) = cast(pff.contactid as int)
	join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
		on pff.pigflowid = pf.pigflowid
	join #pf_list l
		on l.reportinggroupid = pf.reportinggroupid) xx
	group by xx.reportinggroupid
	
--select fw.farmid, cast(sum(Born_Alive_qty) as float) born_alive_qty
--,( sum(wean_qty) - sum(nurseon_qty) )  sumwqty,avg(wean_age) * ( sum(wean_qty) - sum(nurseon_qty) ) weandays
--, (cast(sum(Born_Alive_qty) as float)  - cast(sum(wean_qty) as float) - cast(sum(nurseon_qty) as float)) pwm_num 
--, (cast(sum(Born_Alive_qty) as float)) pwm_dem		-- only born alive no deads
----, (cast(sum(Born_Alive_qty) as float)+ cast(sum(Stillborn_qty) as float) + cast(sum(mummy_qty) as float)) pwm_dem
--into #w48w23_pre
--from [dbo].[cft_SowMart_detail_data] fw (nolock)
--where fw.final_wean_picyear_week between @w48 and @w23
--and fw.farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
--group by fw.farmid
	
select yy.reportinggroupid, sum(yy.weandays)/sum(yy.sumwqty) wean_age
, sum(yy.sumwqty) sumwqty, sum(yy.litters_weaned_qty) as wean_litter_qty
, sum(#w51w26.BA) born_alive_qty
--, sum(pwm_num)/sum(pwm_dem) as pwm
, ( 
	( (cast(sum(#w51w26.BA) as float)/sum(#EA.litters_farrowed_qty)) - (  cast(sum(yy.sumwqty) as float)/ cast(sum(yy.litters_weaned_qty) as float) )  ) 
	/ 
	( (cast(sum(#w51w26.BA) as float)/sum(#EA.litters_farrowed_qty)) )
) as PWM
into #w48w23
from
(select distinct l.reportinggroupid, f.*
from #w48w23_pre f
join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	on f.farmid = pcf.farm_name
join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	on cast(pcf.farm_number as int) = cast(pff.contactid as int)
join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	on pff.pigflowid = pf.pigflowid
join #pf_list l
	on l.reportinggroupid = pf.reportinggroupid) yy
left join #EA
	on #ea.reportinggroupid = yy.reportinggroupid
left join #w51w26
	on #w51w26.reportinggroupid = yy.reportinggroupid
group by yy.reportinggroupid
/*  #fh  52 to 26    w4823
( 
	( (cast(#FH.sumba as float)/#FH.farrow_litter_qty) - (  cast(w4823sow.sumwqty as float)/ cast(w4823sow.wean_litter_qty as float) )  ) 
	/ 
	( (cast(#FH.sumba as float)/#FH.farrow_litter_qty) )
) as PWM
*/
	
	

 select w25w0.reportinggroupid
, ( w25w0.TwgtM - (3*w51w26.BA) * ((w25w0.HS/#ea.gpw_per_sowwean)/#EA.litters_farrowed_qty)  )
/ ( (26.0/49.0)*(w48w0.pdays) + ( (w51w26.ba*((w25w0.HS/#ea.gpw_per_sowwean)/#EA.litters_farrowed_qty) * ( (w48w23.wean_age * (1-w48w23.pwm) + ((w48w23.wean_age/2) * w48w23.pwm)) ) ) )  )  as 'ADG rollup'
into #ESS_rollup
 from 
(
select reportinggroupid
, sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt])  TwgtM   -- final weight  2014-07-03 maild from Dan
, sum(TransferInWP_qty) + Sum(TransferIn_qty) + Sum(MoveIn_qty) - sum(moveout_qty) - sum(transferout_qty)  HS
	 from [dbo].[cft_SLF_ESSBASE_DATA] where pg_week between @w25 and @pg_week and phase in ('wtf', 'fin') 
	 and livepigdays > 0 
  and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
 group by reportinggroupid
 ) w25w0
 left join #EA
	on #EA.reportinggroupid = w25w0.reportinggroupid 
 join
 (
 select reportinggroupid, sum([LivePigDays]) + sum([DeadPigDays])   pdays
	 from [dbo].[cft_SLF_ESSBASE_DATA] where pg_week between @w48 and @pg_week --and phase in ('wtf', 'fin')  
	 and livepigdays > 0 
	   and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
	 group by reportinggroupid
 ) w48w0
	on w48w0.reportinggroupid = w25w0.reportinggroupid
 left join #w51w26 w51w26
	on w51w26.reportinggroupid = w25w0.reportinggroupid
left join #w48w23 w48w23
	on w48w23.reportinggroupid = w25w0.reportinggroupid
where w48w0.pdays <> 0 and w25w0.reportinggroupid <> 0







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
(select distinct l.reportinggroupid, f.*
from #wean_pre f
join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	on f.farmid = pcf.farm_name
join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	on cast(pcf.farm_number as int) = cast(pff.contactid as int)
join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	on pff.pigflowid = pf.pigflowid
join #pf_list l
	on l.reportinggroupid = pf.reportinggroupid) xx
group by xx.reportinggroupid




select w.reportinggroupid
, sum(w.weandays) weandays
, sum(w.weandays)/sum(sumwqty) avgage
, sum(sumwqty) sumwqty
into #WeanAge
from #wean  w
group by w.reportinggroupid


select S.reportinggroupid
, S.Reporting_Group_Description
, wa.avgage as 'Avg Wean Age'
, #ess_nur_wgt.TransferInWP_Wt/#ess_nur_wgt.[TransferInWP_Qty] as 'Avg Wean Weight'
, ((#ess_nur_wgt.TransferInWP_Wt/#ess_nur_wgt.[TransferInWP_Qty]) - 3.0) / wa.avgage as 'ADG FH'		
, ( (#ess_nur.final_wgt - #ess_nur.init_wgt)/#ess_nur.pigdays ) + ( (50 - (#ess_nur.init_wgt/#ess_nur.init_qty)) * .005 ) as 'ADG Nursery'	--  ess_nur(26 weeks)
, ( (#ess_fin.final_wgt - #ess_fin.init_wgt)/#ess_fin.pigdays ) + ( (50 - (#ess_fin.init_wgt/#ess_fin.init_qty)) * .005 ) + ( (270 - (#ess_fin.final_wgt/#ess_fin.final_qty)) * .001 ) as 'ADG Finish'	-- adjusted adg
, 1.0 as 'No TE info available'
, ( (#ess_wtf.final_wgt - #ess_wtf.init_wgt)/#ess_wtf.pigdays ) + ( (270 - (#ess_wtf.final_wgt/#ess_wtf.final_qty)) * .001 ) as 'ADG WTF'	-- adjusted adg
, #ESS_rollup.[adg rollup]
from (select distinct reportinggroupid, Reporting_Group_Description 
	  FROM [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] 
      where reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)	) S
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
    ON OBJECT::[dbo].[cfp_REPORT_SLF_FLOW_KPI_ADG_staged_rg_mod] TO [db_sp_exec]
    AS [dbo];

