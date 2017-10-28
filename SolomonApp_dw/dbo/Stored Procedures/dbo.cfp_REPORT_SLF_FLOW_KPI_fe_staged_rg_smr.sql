





-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FLOW_KPI_FE_staged_rg_smr
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FLOW_KPI_fe_staged_rg_smr]
	@mg_week char(6), @reportinggroupid_list varchar(50)
	
	AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
SET NOCOUNT ON;

declare @pg_week char(6)
set @pg_week = @mg_week



declare @startdate datetime
declare @enddate datetime
declare @fstartdate datetime
declare @fenddate datetime
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

declare @wk00 char(6), @wk23 char(6), @wk25 char(6), @wk26 char(6), @wk42 char(6), @wk48 char(6), @wk17 char(6), @wk51 char(6), @wk68 char(6), @wk49 char(6), @wk74 char(6), @wk77 char(6)
, @wk94 char(6), @start char(6)

-- marketing pig time frames
-- get datetime value for last day of the market interval
select @enddate = max(daydate) from  dbo.cftDayDefinition_WithWeekInfo
where picyear_week = @pg_week
-- get picyear_week value for first day of the market interval
select @wk26 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-26,@enddate)
-- get datetime value for first day of the interval
select @startdate = min(daydate) from  dbo.cftDayDefinition_WithWeekInfo
where picyear_week = @wk26

select @start = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(d,-182,@enddate)


set @wk00 = @pg_week
select @wk23 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-23,@enddate)
select @wk25 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-25,@enddate)
select @wk26 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-26,@enddate)
select @wk68 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-68,@enddate)
select @wk42 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-42,@enddate)
select @wk48 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-48,@enddate)
select @wk49 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-49,@enddate)
select @wk17 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-17,@enddate)
select @wk51 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-51,@enddate)
select @wk74 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-74,@enddate)
select @wk77 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-77,@enddate)
select @wk94 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-94,@enddate)





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

--select @pos, @parmcnt, @reportinggroupid_list, 'last only'

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
 where pg_week between @wk25 and @pg_week	-- 26 weeks ago    and inputted week
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

--select distinct reportinggroupid
--,case when reporting_group_description = 'LDC' then 'C27,C28,C29,C30,C31'
--     when reporting_group_description = 'ON' then 'C32,C33,C34,C35,C36,C37'
--     else reporting_group_description
--end reporting_group_description
--, pg_week, dw23.picyear_week as w23, dw26.picyear_week as w26 
--into #lookback
--from [dbo].[cft_SLF_ESSBASE_DATA] eb (nolock) 
--join  dbo.cftDayDefinition_WithWeekInfo dw (nolock)
--	on dw.dayname = 'sunday' and dw.picyear_week = eb.pg_week
--join  dbo.cftDayDefinition_WithWeekInfo dw23 (nolock)
--	on dw23.dayname = 'sunday' and dateadd(ww,-22,dw.daydate) = dw23.daydate
--join  dbo.cftDayDefinition_WithWeekInfo dw26 (nolock)
--	on dw26.dayname = 'sunday' and dateadd(ww,-25,dw.daydate) = dw26.daydate
--where reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
--and pg_week between @wk26 and @pg_week


select distinct reportinggroupid
,case when reporting_group_description = 'LDC' then 'C27,C28,C29,C30,C31'
     when reporting_group_description = 'ON' then 'C32,C33,C34,C35,C36,C37'
     else reporting_group_description
end reporting_group_description
, pg_week, dw23.picyear_week as w23, dw26.picyear_week as w26 
, dw25.picyear_week as w25, dw42.picyear_week as w42
into #lookback
from [dbo].[cft_SLF_ESSBASE_DATA] eb (nolock) 
join  dbo.cftDayDefinition_WithWeekInfo dw (nolock)
	on dw.dayname = 'sunday' and dw.picyear_week = eb.pg_week
join  dbo.cftDayDefinition_WithWeekInfo dw23 (nolock)
	on dw23.dayname = 'sunday' and dateadd(ww,-22,dw.daydate) = dw23.daydate
join  dbo.cftDayDefinition_WithWeekInfo dw25 (nolock)
	on dw25.dayname = 'sunday' and dateadd(ww,-24,dw.daydate) = dw25.daydate
join  dbo.cftDayDefinition_WithWeekInfo dw26 (nolock)
	on dw26.dayname = 'sunday' and dateadd(ww,-25,dw.daydate) = dw26.daydate
join  dbo.cftDayDefinition_WithWeekInfo dw42 (nolock)
	on dw42.dayname = 'sunday' and dateadd(ww,-41,dw.daydate) = dw42.daydate
where reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
and pg_week between @wk26 and @pg_week


--declare @farmid varchar(500)

--select pcf.farm_name, reportinggroupid, reporting_group_description
--into #rptgrp_farmid
--from 
--(select distinct reportinggroupid 
--	,COALESCE(@farmid + ', ', '') + 
--	case when reporting_group_description = 'LDC' then 'C27,C28,C29,C30,C31'
--		 when reporting_group_description = 'ON' then 'C32,C33,C34,C35,C36,C37'
--		 else reporting_group_description
--	end reporting_group_description 
--from [dbo].[cft_SLF_ESSBASE_DATA]
--where pg_week between @wk26 and @pg_week) rglist
--join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
--	on charindex(pcf.farm_name,rglist.reporting_group_description) > 0 
--where reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)



declare @farmid varchar(500)

select distinct pcf.farm_name, reportinggroupid, reporting_group_description
into #rptgrp_farmid
from 
(select distinct reportinggroupid 
	,COALESCE(@farmid + ', ', '') + 
	case when reporting_group_description = 'LDC' then 'C27,C28,C29,C30,C31'
		 when reporting_group_description = 'ON' then 'C32,C33,C34,C35,C36,C37'
		 else reporting_group_description
	end reporting_group_description 
from [dbo].[cft_SLF_ESSBASE_DATA]
where pg_week between @wk26 and @pg_week) rglist
join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	on charindex(pcf.farm_name,rglist.reporting_group_description) > 0 
where reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
--   
 
 -- the slf kpi report requests a picyear_week value.   this represents the last picyear_week value of a 6 month interval (a market pig's sold interval)
-- sow farrowing and weaning events that create the pigs marketed occur in a prior 6 month interval
-- this also applies to the feed consumed by the sows.


select reportinggroupid, Reporting_group_description	--, phase
, @wk51 starting_picyear_week, @wk00 ending_picyear_week
--, case
--	when patindex('%m%',reporting_group_description) > 0 then sum(prim_wt) + sum(transferout_wt)
--	else sum(prim_wt)  
--  end as wtsold
--, case
--	when patindex('%m%',reporting_group_description) > 0 then sum(prim_qty) + sum(transferout_qty)
--	else sum(prim_qty)  
--  end as qtysold
, sum(prim_wt) as wtsold
, sum(prim_qty) as qtysold
, sum(TransferInWP_qty) + Sum(TransferIn_qty) + Sum(MoveIn_qty) - sum(moveout_qty) - sum(transferout_qty)  HS
into #w51w00
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where pg_week between @wk51 and @wk00 
  and phase in ('FIN', 'wtf')
  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  group by reportinggroupid, Reporting_group_description	--, phase
order by Reporting_group_description;

-- estimated to actual wean
select [FarmID]
      ,sum([Wean_qty]) Wean_qty
      ,sum([Litters_weaned_qty]) Litters_weaned_qty
into #EAwean_pre
from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
where fw.picyear_week between @wk74 and @wk23
and fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
group by fw.farmid

-- estimated to actual farrow
select [FarmID]
      ,sum([Litters_farrowed_qty]) Litters_farrowed_qty
into #EAfarrow_pre
from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
where fw.picyear_week between @wk77 and @wk26
and fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
group by fw.farmid

select xx.reportinggroupid, ( cast(sum(wean_qty) as float)/cast(sum(litters_weaned_qty) as float) ) gpw_per_sowwean
, sum(litters_farrowed_qty) litters_farrowed_qty
into #EA
	from
	(select distinct fid.reportinggroupid, f.Litters_farrowed_qty, w.Wean_qty, w.Litters_weaned_qty
	from #EAwean_pre w
	join #EAfarrow_pre f 
		on f.farmid = w.farmid
join #rptgrp_farmid fid
	on fid.farm_name = w.farmid
	--join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	--	on w.farmid = pcf.farm_name
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	--	on cast(pcf.farm_number as int) = cast(pff.contactid as int)
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	----	on pff.pigflowid = pf.pigflowid
	--join #pf_list l
	--	on l.reportinggroupid = pf.reportinggroupid
	) xx
	group by xx.reportinggroupid
	
select fw.farmid, sum([Lact_sow_Days]) Lact_sow_Days
into #Ldays_pre
from [dbo].[cft_SowMart_weekly_Rollup] fw (nolock)
where fw.picyear_week between @wk77 and @wk23
and fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
group by fw.farmid

select xx.reportinggroupid, ( sum([Lact_sow_Days]) / 385) lday385
into #Ldays
	from
	(select distinct fid.reportinggroupid, f.*
	from #Ldays_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
	--join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	--	on f.farmid = pcf.farm_name
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	--	on cast(pcf.farm_number as int) = cast(pff.contactid as int)
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	--	on pff.pigflowid = pf.pigflowid
	--join #pf_list l
	--	on l.reportinggroupid = pf.reportinggroupid
		) xx
	group by xx.reportinggroupid



select fw.farmid, sum([gest_sow_Days]) gest_sow_Days
into #Gdays_pre
from [dbo].[cft_SowMart_weekly_Rollup] fw (nolock)
where fw.picyear_week between @wk94 and @wk26 
and fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
group by fw.farmid

select xx.reportinggroupid, ( sum([gest_sow_Days]) / 483) gday483
into #Gdays
	from
	(select distinct fid.reportinggroupid, f.*
	from #Gdays_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
	--join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	--	on f.farmid = pcf.farm_name
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	--	on cast(pcf.farm_number as int) = cast(pff.contactid as int)
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	--	on pff.pigflowid = pf.pigflowid
	--join #pf_list l
	--	on l.reportinggroupid = pf.reportinggroupid
		) xx
	group by xx.reportinggroupid




-- lactating Sow Info

select farmid
, sum(lact_sow_days) Ldays, avg(lact_sow_qty) avgLsowcnt
, sum(lact_feed_lbs) lact_feed_lbs
, sum(cast(lact_feed_lbs as float))/sum(cast(lact_sow_days as float)) as lacfeedlbsperday
into #LSowinfo_pre
	 from  [dbo].[cft_SowMart_weekly_Rollup]
where picyear_week between  @wk51 and @wk23		
		and farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid

select xx.reportinggroupid
, sum(Ldays) Ldays
, sum(lact_feed_lbs) lact_feed_lbs
, sum(cast(lact_feed_lbs as float))/sum(cast(Ldays as float)) as lacfeedlbsperday
into #LSowinfo
	from
	(select distinct fid.reportinggroupid, f.*
	from #LSowinfo_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
	--join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	--	on f.farmid = pcf.farm_name
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	--	on cast(pcf.farm_number as int) = cast(pff.contactid as int)
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	--	on pff.pigflowid = pf.pigflowid
	--join #pf_list l
	--	on l.reportinggroupid = pf.reportinggroupid
		) xx
	group by xx.reportinggroupid
	
	
	

select farmid
--, avg(cast(lact_days_qty as float)) avgLdays
, sum(lact_days_qty) lact_days_qty
, cast(count(distinct sowid+cast(sowparity as varchar(2))) as float) sow_qty
into #LSowAvg_pre
	 from  [dbo].[cft_SowMart_Detail_data]
where isnull(farrow_picyear_week,getdate()) between @wk51 and @wk23	
		and farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid
	 
select xx.reportinggroupid
, sum(cast(lact_days_qty as float))/ sum(cast(sow_qty as float)) avgLdays
into #LSowAvg
	from
	(select distinct fid.reportinggroupid, f.*
	from #LSowAvg_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
	--join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	--	on f.farmid = pcf.farm_name
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	--	on cast(pcf.farm_number as int) = cast(pff.contactid as int)
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	--	on pff.pigflowid = pf.pigflowid
	--join #pf_list l
	--	on l.reportinggroupid = pf.reportinggroupid
		) xx
	group by xx.reportinggroupid
	 



-- Gestating Sow Info

select farmid
, sum(gest_sow_days) gest_sow_days	
, sum(gest_feed_lbs) gest_feed_lbs
, sum(nonprod_sow_days) nonprod_sow_days
into #GSowinfo_pre
	 from  [dbo].[cft_SowMart_weekly_Rollup]
where picyear_week between  @wk68 and @wk26
		and farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid

select xx.reportinggroupid
, sum(gest_sow_days) Gdays	
, sum(gest_feed_lbs) gest_feed_lbs
, sum(cast(gest_feed_lbs as float))/( sum(cast(gest_sow_days as float)) + sum(cast(nonprod_sow_days as float)) ) as gesfeedlbsperday
into #GSowinfo
	from
	(select distinct fid.reportinggroupid, f.*
	from #GSowinfo_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
	--join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	--	on f.farmid = pcf.farm_name
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	--	on cast(pcf.farm_number as int) = cast(pff.contactid as int)
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	--	on pff.pigflowid = pf.pigflowid
	--join #pf_list l
	--	on l.reportinggroupid = pf.reportinggroupid
		) xx
	group by xx.reportinggroupid
	 


select farmid
, sum(gest_days_qty) gest_days_qty	
, cast(count(distinct sowid+cast(sowparity as varchar(2))) as float) sow_qty
into #GSowAvg_pre
	 from  [dbo].[cft_SowMart_Detail_data]
where isnull(farrow_picyear_week,getdate()) between @wk68 and @wk26
		and farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid

select xx.reportinggroupid
, sum(gest_days_qty)/sum(sow_qty) avgGdays
into #GSowAvg
	from
	(select distinct fid.reportinggroupid, f.*
	from #GSowAvg_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
	--join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	--	on f.farmid = pcf.farm_name
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	--	on cast(pcf.farm_number as int) = cast(pff.contactid as int)
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	--	on pff.pigflowid = pf.pigflowid
	--join #pf_list l
	--	on l.reportinggroupid = pf.reportinggroupid
		) xx
	group by xx.reportinggroupid


 
-- market hog information     nursery,fin,wtf feed consumed, pig lbs sold   ??  include dead weight  too??
select es.reportinggroupid, sum(es.feed_qty) feed_qty
, sum(es.[Prim_Wt]) + sum(es.[Cull_Wt]) + sum(es.[DeadOnTruck_Wt]) + sum(es.[DeadInYard_Wt]) + sum(es.[Condemn_Wt]) 
  + sum(es.moveout_wt) + sum(es.transferout_wt) + sum(es.pigdeathTD_wt) + sum(es.transportdeath_wt) + sum(es.transfertotailender_wt)    
as mtkwgt	-- total weight produced
, sum(es.[Prim_qty]) + sum(es.[Cull_qty]) + sum(es.[DeadOnTruck_qty]) + sum(es.[DeadInYard_qty]) + sum(es.[Condemn_qty]) 
  + sum(es.moveout_qty) + sum(es.transferout_qty) + sum(es.pigdeathTD_qty) + sum(es.transportdeath_qty) + sum(es.transfertotailender_qty)    
as mtkqty	-- total head produced
into #market
from  dbo.cft_slf_essbase_data es (nolock)
where es.pg_week between @wk25 and @pg_week
  and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
group by es.reportinggroupid

select reportinggroupid, Reporting_group_description	--, phase
, @start starting_picyear_week, @pg_week ending_picyear_week
  , sum(deadontruck_qty) + sum(deadinyard_qty)+ sum(condemn_qty) dotdiyc
  , sum(deadontruck_qty)/(sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty))*100 as dotpct
  , sum(deadinyard_qty)/(sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty))*100 as diypct
  , sum(condemn_qty)/(sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty))*100 as compct
  , sum(TransferInWP_qty) + Sum(TransferIn_qty) + Sum(MoveIn_qty) - sum(moveout_qty) - sum(transferout_qty)  HS
  , sum(prim_qty)  / (sum(prim_qty) + sum(cull_qty) )*100 as primpct	-- per marketed pig
  , sum(cull_qty)  / (sum(prim_qty) + sum(cull_qty) )*100 as cullpct	-- per marketed pig
  , sum(prim_wt) + sum(cull_wt) + sum(deadontruck_wt) + sum(deadinyard_wt) + sum(condemn_wt) as wgt_produced
  , sum(prim_qty) + sum(cull_qty) + sum(deadontruck_qty) + sum(deadinyard_qty) + sum(condemn_qty) as head_produced
into #mkt
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where pg_week between @start and @pg_week
  and phase in ('FIN', 'wtf')
  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  group by reportinggroupid, Reporting_group_description	--, phase
order by Reporting_group_description



select farmid
, sum(lact_feed_lbs) lact_feed_lbs
into #w5123_pre
	 from  [dbo].[cft_SowMart_weekly_Rollup]
where picyear_week between  @wk51 and @wk23
		and farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid

select xx.reportinggroupid
, sum(lact_feed_lbs) lact_feed_lbs
into #w5123
	from
	(select distinct fid.reportinggroupid, f.*
	from #w5123_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
	--join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	--	on f.farmid = pcf.farm_name
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	--	on cast(pcf.farm_number as int) = cast(pff.contactid as int)
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	--	on pff.pigflowid = pf.pigflowid
	--join #pf_list l
	--	on l.reportinggroupid = pf.reportinggroupid
		) xx
	group by xx.reportinggroupid


select farmid
,sum(gest_feed_lbs) gest_feed_lbs
into #w6826_pre
	 from  [dbo].[cft_SowMart_weekly_Rollup]
where picyear_week between @wk68 and @wk26
		and farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid

select xx.reportinggroupid
, sum(gest_feed_lbs) gest_feed_lbs
into #w6826
	from
	(select distinct fid.reportinggroupid, f.*
	from #w6826_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
	--join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	--	on f.farmid = pcf.farm_name
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	--	on cast(pcf.farm_number as int) = cast(pff.contactid as int)
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	--	on pff.pigflowid = pf.pigflowid
	--join #pf_list l
	--	on l.reportinggroupid = pf.reportinggroupid
		) xx
	group by xx.reportinggroupid
	
	


select farmid
, sum(lact_days_qty) lact_days_qty	
, sum(gest_days_qty) gest_days_qty	
, cast(count(distinct sowid+cast(sowparity as varchar(2))) as float) sow_qty
into #cycles_dd_pre
	 from  [dbo].[cft_SowMart_Detail_data]
where farrow_picyear_week between @wk51 and @pg_week
		and farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid
	 
select farmid
,sum(nonprod_sow_days) nonprod_sow_days
,sum(nonprod_sow_qty) nonprod_sow_qty
into #cycles_wr_pre
	 from  [dbo].[cft_SowMart_weekly_Rollup]
where picyear_week between @wk51 and @pg_week
		and farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid
	 
select x1.reportinggroupid, x1.avgldays, x1.avggday, x2.nondays
,  x1.avgldays+x1.avggday+x2.nondays Tdays
, 365/(x1.avgldays+x1.avggday+x2.nondays) cyc
into #cycles
from 
(select xx.reportinggroupid
 , sum(cast(lact_days_qty as float))/sum(cast(sow_qty as float)) avgLdays
 , sum(cast(gest_days_qty as float))/sum(cast(sow_qty as float)) avgGday
 from
	(select distinct fid.reportinggroupid, f.*
	from #cycles_dd_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
	--join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	--	on f.farmid = pcf.farm_name
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	--	on cast(pcf.farm_number as int) = cast(pff.contactid as int)
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	--	on pff.pigflowid = pf.pigflowid
	--join #pf_list l
	--	on l.reportinggroupid = pf.reportinggroupid
		) xx
	group by xx.reportinggroupid) x1
join  
(select xx.reportinggroupid, sum(nonprod_sow_days)/sum(nonprod_sow_qty) nondays
 from
	(select distinct fid.reportinggroupid, f.*
	from #cycles_wr_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
	--join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	--	on f.farmid = pcf.farm_name
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	--	on cast(pcf.farm_number as int) = cast(pff.contactid as int)
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	--	on pff.pigflowid = pf.pigflowid
	--join #pf_list l
	--	on l.reportinggroupid = pf.reportinggroupid
		) xx
	group by xx.reportinggroupid) x2
	on x2.reportinggroupid = x1.reportinggroupid
	

select reportinggroupid, Reporting_group_description	--, phase
, sum(prim_wt) as wtsold	-- 2014-07-03 email from Dan  no difference between mult and commercial
, sum(prim_qty) as qtysold	-- 2014-07-03 email from Dan  no difference between mult and commercial
into #w25w00
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where pg_week between @wk25 and @wk00 
  and phase in ('FIN', 'wtf')
  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  group by reportinggroupid, Reporting_group_description	--, phase
order by Reporting_group_description;
	
	
	
--select fid.reportinggroupid, #lookback.pg_week, #lookback.w23, #lookback.w26
--      ,sum(cast(isnull(wean_qty,0)+.00001 as float)) Wean_qty		-- deal with zero or nulls
--      ,sum(cast(isnull([Litters_weaned_qty],0)+.001 as float)) sw
--      , sum(cast(isnull(wean_qty,0)+.00001 as float))/sum(cast(isnull([Litters_weaned_qty],0)+.001 as float)) gpw
--into #wean
--from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
--join #rptgrp_farmid fid
--	on fid.farm_name = fw.farmid
--join #lookback on fid.reportinggroupid = #lookback.reportinggroupid and fw.picyear_week = #lookback.w23 
--group by fid.reportinggroupid, #lookback.pg_week, #lookback.w23, #lookback.w26
----having sum(Litters_weaned_qty) > 0 and avg(cast(wean_qty as float)/cast([Litters_weaned_qty] as float)) > 0

--select fid.reportinggroupid, #lookback.pg_week, #lookback.w23, #lookback.w26
--      ,sum([Litters_farrowed_qty]) sf
--into #farrow
--from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
--join #rptgrp_farmid fid
--	on fid.farm_name = fw.farmid
--join #lookback on fid.reportinggroupid = #lookback.reportinggroupid and fw.picyear_week = #lookback.w26 
--group by fid.reportinggroupid, #lookback.pg_week, #lookback.w23, #lookback.w26

--select #farrow.reportinggroupid,#farrow.pg_week, #farrow.w23, #farrow.w26 
--, #wean.wean_qty, #farrow.sf, #wean.wean_qty/#farrow.sf as gpw
--into #wf
--from #farrow 
--join #wean
--	on #wean.reportinggroupid = #farrow.reportinggroupid
--	and #wean.pg_week = #farrow.pg_week
--	and #wean.w23 = #farrow.w23
--	and #wean.w26 = #farrow.w26

	
	
--select lb.reportinggroupid, lb.pg_week, lb.w23
--, sum(pgw.prim_qty) PQ
--, sum(pgw.prim_wt) Pw
--, sum(TransferInWP_qty) + Sum(TransferIn_qty) + Sum(MoveIn_qty) - sum(moveout_qty) - sum(transferout_qty)  HS
--into #MktWk
--FROM #lookback lb
--join [dbo].[cft_SLF_ESSBASE_DATA] pgw
--	on pgw.reportinggroupid = lb.reportinggroupid and pgw.pg_week = lb.pg_week
--group by lb.reportinggroupid, lb.pg_week, lb.w23

--select fw.reportinggroupid, lb.pg_week, lb.w23
--, sum([total_sow_qty]) FI
--, sum([lact_sow_days]) LD
--, sum([Gest_sow_days]) GD
--, sum([total_sow_days]) td
--into #wrollup
--from [dbo].[cft_SowMart_weekly_Rollup] fw (nolock)
--join #rptgrp_farmid fid
--	on fid.farm_name = fw.farmid --and fid.reportinggroupid = fw.reportinggroupid  
--join  #lookback lb
--	on fid.reportinggroupid = lb.reportinggroupid and fw.picyear_week = lb.w23 
--group by fw.reportinggroupid, lb.pg_week, lb.w23

--select lb.reportinggroupid, avg( m.pq /(( ((m.HS/#wf.GPw)/#wf.sf ) / 52 ) * (ru.fi*((ru.ld+ru.gd)/ru.td)))) psy
--, avg( m.pw /(( ((m.HS/#wf.GPw)/#wf.sf ) / 52 ) * (ru.fi*((ru.ld+ru.gd)/ru.td)))) lbsy
--into #sowyear
--from  #lookback lb 
--join #MktWk	m
--	on m.reportinggroupid = lb.reportinggroupid and m.w23 = lb.w23
--left join #wean w
--	on w.reportinggroupid = lb.reportinggroupid and w.pg_week = lb.pg_week and w.w23 =lb.w23
--left join #wrollup ru
--	on ru.reportinggroupid = lb.reportinggroupid and ru.pg_week = lb.pg_week and ru.w23 =lb.w23
--left join #wf 
--	on #wf.reportinggroupid = lb.reportinggroupid and #wf.pg_week = lb.pg_week and #wf.w23 =lb.w23 
--group by lb.reportinggroupid

select fid.reportinggroupid, #lookback.pg_week, #lookback.w23, #lookback.w26
      ,sum(cast(isnull(wean_qty,0)+.00001 as float)) Wean_qty		-- deal with zero or nulls
      ,sum(cast(isnull([Litters_weaned_qty],0)+.001 as float)) sw
      , sum(cast(isnull(wean_qty,0)+.00001 as float))/sum(cast(isnull([Litters_weaned_qty],0)+.001 as float)) gpw
into #wean
from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
join #rptgrp_farmid fid
	on fid.farm_name = fw.farmid
join #lookback on fid.reportinggroupid = #lookback.reportinggroupid and fw.picyear_week = #lookback.w23 
group by fid.reportinggroupid, #lookback.pg_week, #lookback.w23, #lookback.w26
--having sum(Litters_weaned_qty) > 0 and avg(cast(wean_qty as float)/cast([Litters_weaned_qty] as float)) > 0

select fid.reportinggroupid, #lookback.pg_week, #lookback.w23, #lookback.w26
      ,sum([Litters_farrowed_qty]) sf
into #farrow
from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
join #rptgrp_farmid fid
	on fid.farm_name = fw.farmid
join #lookback on fid.reportinggroupid = #lookback.reportinggroupid and fw.picyear_week = #lookback.w26 
group by fid.reportinggroupid, #lookback.pg_week, #lookback.w23, #lookback.w26

select #farrow.reportinggroupid,#farrow.pg_week, #farrow.w23, #farrow.w26 
, #wean.wean_qty, #farrow.sf, #wean.wean_qty/#farrow.sf as gpw
into #wf
from #farrow 
join #wean
	on #wean.reportinggroupid = #farrow.reportinggroupid
	and #wean.pg_week = #farrow.pg_week
	and #wean.w23 = #farrow.w23
	and #wean.w26 = #farrow.w26

	
	
select lb.reportinggroupid, lb.pg_week, lb.w23
, sum(pgw.prim_qty) PQ
, sum(pgw.prim_wt) Pw
, sum(TransferInWP_qty) + Sum(TransferIn_qty) + Sum(MoveIn_qty) - sum(moveout_qty) - sum(transferout_qty)  HS
into #MktWk
FROM #lookback lb
join [dbo].[cft_SLF_ESSBASE_DATA] pgw
	on pgw.reportinggroupid = lb.reportinggroupid and pgw.pg_week = lb.pg_week
group by lb.reportinggroupid, lb.pg_week, lb.w23

select fid.reportinggroupid, lb_lac.pg_week, fw.picyear_week
, sum(fw.lact_sow_qty) lacdays
into #sum_farm_lac
from [dbo].[cft_SowMart_weekly_Rollup] fw (nolock)
join #rptgrp_farmid fid
	on fid.farm_name = fw.farmid 
join  #lookback lb_lac
	on fid.reportinggroupid = lb_lac.reportinggroupid and fw.picyear_week between lb_lac.w25 and lb_lac.w23 
group by fid.reportinggroupid, lb_lac.pg_week, fw.picyear_week

select fid.reportinggroupid, lb_ges.pg_week, fw.picyear_week
, sum(fw.gest_sow_qty) gesdays	-- chg
into #sum_farm_ges
from [dbo].[cft_SowMart_weekly_Rollup] fw (nolock)
join #rptgrp_farmid fid
	on fid.farm_name = fw.farmid 
join  #lookback lb_ges
	on fid.reportinggroupid = lb_ges.reportinggroupid and fw.picyear_week between lb_ges.w42 and lb_ges.w26
group by fid.reportinggroupid, lb_ges.pg_week, fw.picyear_week

select reportinggroupid, pg_week
, avg(lacdays) lacdays	-- chg
into #wrollup_lac
from #sum_farm_lac 
group by reportinggroupid, pg_week

select reportinggroupid, pg_week
, avg(gesdays) gesdays	-- chg
into #wrollup_ges
from #sum_farm_ges 
group by reportinggroupid, pg_week

select lb.reportinggroupid
, avg( m.pq /(( ((m.HS/#wf.GPw)/#wf.sf ) / 52 ) * (lac.lacdays+ges.gesdays))) psy
, avg( m.pw /(( ((m.HS/#wf.GPw)/#wf.sf ) / 52 ) * (lac.lacdays+ges.gesdays))) lbsy
into #sowyear
from  #lookback lb 
join #MktWk	m
	on m.reportinggroupid = lb.reportinggroupid and m.w23 = lb.w23
left join #wrollup_lac lac
	on lac.reportinggroupid = lb.reportinggroupid and lac.pg_week = lb.pg_week
left join #wrollup_ges ges
	on ges.reportinggroupid = lb.reportinggroupid and ges.pg_week = lb.pg_week
left join #wf 
	on #wf.reportinggroupid = lb.reportinggroupid and #wf.pg_week = lb.pg_week
group by lb.reportinggroupid

	
	
	


select distinct S.reportinggroupid, S.Reporting_Group_Description
--1.	Lac Feed lbs/day =  (Total Lac Feed delivered in 6 months  – Total Lac Feed transferred away in 6 months)/(Total Sow Lac Days in 6 months)
, #LSowinfo.lacfeedlbsperday as 'Llbsday'
, #LSowAvg.avgLdays as lactdays
--, #sowinfo.lacfeedlbsperday* as 'LlbsSowYear'
, ( #LSowinfo.lacfeedlbsperday * #LSowAvg.avgLdays * CY.cyc)  as 'LlbsSowYear'
, #GSowinfo.gesfeedlbsperday as 'Glbsday'
, #GSowAvg.avgGdays as gestdays
--, #sowinfo.gesfeedlbsperday*365 as 'GlbsSowYear'
,( #GSowinfo.gesfeedlbsperday * #GSowAvg.avgGdays * CY.cyc)  as 'GlbsSowYear'
, ( ( #LSowinfo.lacfeedlbsperday * #LSowAvg.avgLdays * CY.cyc) + ( #GSowinfo.gesfeedlbsperday * #GSowAvg.avgGdays * CY.cyc) )/2000 'Total Tons/sow/year'
, nur.nurfe
, fin.finfe
, wtf.wtffe
--, ( (#market.feed_qty) + (((( ( #LSowinfo.lacfeedlbsperday * #LSowAvg.avgLdays * CY.cyc) + ( #GSowinfo.gesfeedlbsperday * #GSowAvg.avgGdays * CY.cyc) ))/((w51w00.qtysold)/ ( ((w51w00.HS/#ea.gpw_per_sowwean)/#EA.litters_farrowed_qty) * (#ldays.lday385 + #gdays.gday483) )))*#market.mtkqty)  )  
--/ #market.mtkwgt as [Whole Herd FE]	
--, ( #market.feed_qty + ( ( ( #LSowinfo.lacfeedlbsperday * #LSowAvg.avgLdays * CY.cyc) + ( #GSowinfo.gesfeedlbsperday * #GSowAvg.avgGdays * CY.cyc) ) 
--/ ((w51w00.qtysold)/ ( ((w51w00.HS/#ea.gpw_per_sowwean)/#EA.litters_farrowed_qty) * (#ldays.lday385 + #gdays.gday483) )) ) * (w25w00.qtysold) ) 
--/ (w25w00.wtsold) as [Whole Herd FE]
 --, (w51w00.qtysold)/ ( ((w51w00.HS/#ea.gpw_per_sowwean)/#EA.litters_farrowed_qty) * (#ldays.lday385 + #gdays.gday483) ) as [pigs mkt per inv sow per year]
, ( #market.feed_qty + ( ( ( #LSowinfo.lacfeedlbsperday * #LSowAvg.avgLdays * CY.cyc) + ( #GSowinfo.gesfeedlbsperday * #GSowAvg.avgGdays * CY.cyc) ) 
/ (#sowyear.psy) ) * (w25w00.qtysold) ) 
/ (w25w00.wtsold) as [Whole Herd FE]

from (select distinct reportinggroupid, Reporting_Group_Description 
	  FROM [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] 
      where reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)	) S
left join #pf_list
	on #pf_list.reportinggroupid = S.reportinggroupid
left join #LSowinfo
	on #LSowinfo.reportinggroupid = S.reportinggroupid
left join #LSowAvg
	on #LSowAvg.reportinggroupid = S.reportinggroupid
left join #GSowinfo
	on #GSowinfo.reportinggroupid = S.reportinggroupid
left join #GSowAvg
	on #GSowAvg.reportinggroupid = S.reportinggroupid
left join #market
	on #market.reportinggroupid = S.reportinggroupid
left join #w5123
	on #w5123.reportinggroupid = S.reportinggroupid
left join #w25w00 w25w00
	on w25w00.reportinggroupid = S.reportinggroupid
left join #w6826
	on #w6826.reportinggroupid = S.reportinggroupid
left join #cycles CY
on CY.reportinggroupid = s.reportinggroupid
left join #sowyear
on #sowyear.reportinggroupid = s.reportinggroupid
--left join #w51w00 w51w00
--on w51w00.reportinggroupid = s.reportinggroupid
--left join #ea 
--on #ea.reportinggroupid = s.reportinggroupid
--left join #Ldays	-- weeks 77 - 23
--	on #Ldays.reportinggroupid = S.reportinggroupid
--left join #Gdays	-- weeks 94 - 26
--	on #Gdays.reportinggroupid = S.reportinggroupid
left join 
	(select es.reportinggroupid 
, case 
	  when isnull( (isnull(sum(es.feed_qty),0) / ((sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt]) + sum(transferout_wt) + sum(pigdeathTD_wt) + sum(transportdeath_wt) + sum(transfertotailender_wt)  )
   - (sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) ) )),0) <> 0 
	  then isnull(sum(es.feed_qty),0) / ((sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt]) + sum(transferout_wt) + sum(pigdeathTD_wt) + sum(transportdeath_wt) + sum(transfertotailender_wt)  )
   - (sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) ) ) else 0 end
	  +  ((50 - case when (isnull((sum([Prim_qty]) + sum([Cull_qty]) + sum([DeadOnTruck_qty]) + sum([DeadInYard_qty]) + sum([Condemn_qty]) 
									+ sum(transferout_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) + sum(transfertotailender_qty)  ),0) ) <> 0 
					 then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadOnTruck_Wt),0) + isnull(sum(DeadInYard_wt),0) + isnull(sum(Condemn_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(pigdeathTD_Wt),0) + isnull(sum(TransportDeath_Wt),0)) 
					 / (isnull( (sum([Prim_qty]) + sum([Cull_qty]) + sum([DeadOnTruck_qty]) + sum([DeadInYard_qty]) + sum([Condemn_qty]) 
									+ sum(transferout_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) + sum(transfertotailender_qty) ),0) ) 
					 else 0 end) * 0.005)  nurfe		
		from  dbo.cft_slf_essbase_data es (nolock)
		where es.pg_week between @wk26 and @pg_week
		  and es.phase in ('nur','wtf') and es.prim_wt = 0
		  and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
		group by es.reportinggroupid) as NUR
			on nur.reportinggroupid = S.reportinggroupid
left join 
	(select es.reportinggroupid		
, case 
	  when isnull( (isnull(sum(es.feed_qty),0) / ((sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt]) + sum(transferout_wt) + sum(pigdeathTD_wt) + sum(transportdeath_wt) + sum(transfertotailender_wt)  )
   - (sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) ) )),0) <> 0 
	  then isnull(sum(es.feed_qty),0) / ((sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt]) + sum(transferout_wt) + sum(pigdeathTD_wt) + sum(transportdeath_wt) + sum(transfertotailender_wt)  )
   - (sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) ) ) else 0 end
	  +  ((50 - case when (isnull((sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) ),0) ) <> 0 
					 then ((sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) )) 
					 / (isnull( ((sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_wt)  - sum(moveout_qty) )) ,0) ) 
					 else 0 end) * 0.005)
	  + ( ( 270 - (case when (isnull((sum([Prim_qty]) + sum([Cull_qty]) + sum([DeadOnTruck_qty]) + sum([DeadInYard_qty]) + sum([Condemn_qty]) 
									+ sum(transferout_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) + sum(transfertotailender_qty)  ),0) ) <> 0 
					 then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadOnTruck_Wt),0) + isnull(sum(DeadInYard_wt),0) + isnull(sum(Condemn_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(pigdeathTD_Wt),0) + isnull(sum(TransportDeath_Wt),0)) 
					 / (isnull( (sum([Prim_qty]) + sum([Cull_qty]) + sum([DeadOnTruck_qty]) + sum([DeadInYard_qty]) + sum([Condemn_qty]) 
									+ sum(transferout_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) + sum(transfertotailender_qty) ),0) ) 
					 else 0 end) ) * .001) finfe
		from  dbo.cft_slf_essbase_data es (nolock)
		where es.pg_week between @wk26 and @pg_week
		  and es.phase = 'FIN' 
		  and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
		group by es.reportinggroupid) as FIN
			on fin.reportinggroupid = S.reportinggroupid
left join 
	(select es.reportinggroupid
	 , case 
	  when isnull( (isnull(sum(es.feed_qty),0) / ((sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt]) + sum(transferout_wt) + sum(pigdeathTD_wt) + sum(transportdeath_wt) + sum(transfertotailender_wt)  )
   - (sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) ) )),0) <> 0 
	  then isnull(sum(es.feed_qty),0) / ((sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt]) + sum(transferout_wt) + sum(pigdeathTD_wt) + sum(transportdeath_wt) + sum(transfertotailender_wt)  )
   - (sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) ) ) else 0 end
	  + ( ( 270 - (case when (isnull((sum([Prim_qty]) + sum([Cull_qty]) + sum([DeadOnTruck_qty]) + sum([DeadInYard_qty]) + sum([Condemn_qty]) 
									+ sum(transferout_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) + sum(transfertotailender_qty)  ),0) ) <> 0 
					 then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadOnTruck_Wt),0) + isnull(sum(DeadInYard_wt),0) + isnull(sum(Condemn_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(pigdeathTD_Wt),0) + isnull(sum(TransportDeath_Wt),0)) 
					 / (isnull( (sum([Prim_qty]) + sum([Cull_qty]) + sum([DeadOnTruck_qty]) + sum([DeadInYard_qty]) + sum([Condemn_qty]) 
									+ sum(transferout_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) + sum(transfertotailender_qty) ),0) ) 
					 else 0 end) ) * .001)	  wtffe
		from  dbo.cft_slf_essbase_data es (nolock)
		where es.pg_week between @wk26 and @pg_week
		  and es.phase = 'wtf' 
		  and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
		group by es.reportinggroupid) as WTF
			on wtf.reportinggroupid = S.reportinggroupid




END














GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_FLOW_KPI_fe_staged_rg_smr] TO PUBLIC
    AS [dbo];

