










-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FLOW_KPI_Mkting
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FLOW_KPI_Mkting_rg_20140528]
	@mg_week char(6), @reportinggroupid_list varchar(50)
	
	AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
SET NOCOUNT ON;

declare @startdate datetime
declare @enddate datetime
declare @start char(6)
declare @FES_picyear_week char(6)
declare @FEE_picyear_week char(6)
declare @TLactDays float
declare @TGestDays float

-- get last date value for the selected week
select @enddate = max(daydate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where picyear_week = @mg_week

select @start = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where daydate = dateadd(d,-182,@enddate)

select @startdate = min(daydate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where daydate = dateadd(d,-182,@enddate)
select @FEE_picyear_week = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo	-- farrowing_end_picyear_week value for 6 months earlier	(start of the market interval)
where daydate = dateadd(ww,-27,@enddate) 

select @FES_picyear_week = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo	-- farrowing_end_picyear_week value for 6 months earlier	(start of the market interval)
where daydate = dateadd(ww,-52,@enddate) 

declare @w00 char(6)			-- entered picyear_week value
	set @w00 = @mg_week
declare @w23 char(6)			-- prior 22h week
	select @w23= picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-23,@enddate)
declare @w26 char(6)
	select @w26 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-26,@enddate)
declare @w51 char(6)
	select @w51 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-51,@enddate)
declare @w77 char(6)
	select @w77 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-77,@enddate)
declare @w94 char(6)
	select @w94 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-94,@enddate)

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


select distinct reportinggroupid, Reporting_group_description
into #pf_list
from [dbo].[cft_SLF_ESSBASE_DATA] 
 where mg_week between @start and @mg_week
 and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)


select reportinggroupid, Reporting_group_description	--, phase
, @start starting_picyear_week, @mg_week ending_picyear_week
  , sum(deadontruck_qty) + sum(deadinyard_qty)+ sum(condemn_qty) dotdiyc
  , sum(deadontruck_qty)/(sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty))*100 as dotpct
  , sum(deadinyard_qty)/(sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty))*100 as diypct
  , sum(condemn_qty)/(sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty))*100 as compct
  , sum(prim_qty)
  /((sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty) 
  - (sum(moveout_qty) + sum(transferout_qty) + SUM(transfertotailender_qty)+sum(pigdeath_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) )))*100 as primpct	-- per marketed pig
  , sum(cull_qty) /((sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty) 
  - (sum(moveout_qty) + sum(transferout_qty) + SUM(transfertotailender_qty)+sum(pigdeath_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) )))*100 as cullpct	-- per marketed pig 
  , sum(prim_wt) + sum(cull_wt) as wtsold
  , sum(prim_qty) + sum(cull_qty) as qtysold
  , sum(prim_wt) + sum(cull_wt) + sum(deadontruck_wt) + sum(deadinyard_wt) + sum(condemn_wt) as wgt_produced
  , sum(prim_qty) + sum(cull_qty) + sum(deadontruck_qty) + sum(deadinyard_qty) + sum(condemn_qty) as head_produced
into #mkt
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where mg_week between @start and @mg_week
  and phase in ('FIN', 'wtf')
  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  group by reportinggroupid, Reporting_group_description	--, phase
order by Reporting_group_description


select reportinggroupid, Reporting_group_description	--, phase
, @w51 starting_picyear_week, @w00 ending_picyear_week
--, sum(prim_wt) + sum(cull_wt) as wtsold
--, sum(prim_qty) + sum(cull_qty) as qtysold
, sum(prim_wt)  as wtsold
, sum(prim_qty)  as qtysold
into #w51w00
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where mg_week between @w51 and @w00 
  and phase in ('FIN', 'wtf')
  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  group by reportinggroupid, Reporting_group_description	--, phase
order by Reporting_group_description;



select wr.reportinggroupid,( sum([Lact_sow_Days]) / 385) lday385
into #Ldays
from [dbo].[cft_SowMart_weekly_Rollup] wr
where wr.picyear_week between @w77 and @w23 
and wr.reportinggroupid in  (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
group by wr.reportinggroupid


--select wr.reportinggroupid,( ( sum([gest_sow_Days]) + sum([nonprod_sow_Days]) )  / 490) gday490	
select wr.reportinggroupid,( ( sum([gest_sow_Days])  )  / 483) gday483	
--select wr.reportinggroupid,( sum([gest_sow_Days])   / 490) gday490	
into #Gdays
from [dbo].[cft_SowMart_weekly_Rollup] wr
where wr.picyear_week between @w94 and @w26 
and wr.reportinggroupid in  (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
group by wr.reportinggroupid





--select reportinggroupid, Reporting_group_description
--, min(picyear_week) min_py, min(daydate) min_day
--, max(picyear_week) max_py, max(daydate) max_day
--, datediff(week, min(daydate),  max(daydate)) mrktweeks
--into #mweeks
--FROM [dbo].[cft_SLF_ESSBASE_DATA] dat
--join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dur
--	on dur.picyear_week = dat.mg_week
--where mg_week between @start and @mg_week
--  and phase in ('FIN', 'wtf')
--  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
--  group by reportinggroupid, Reporting_group_description	--, phase
--having datediff(week, min(daydate),  max(daydate)) > 0


  select S.reportinggroupid, S.Reporting_group_description
  , mkt.primpct pctprim
  , '' pctresales
  , mkt.cullpct pctcull
  , mkt.wgt_produced/mkt.head_produced avg_mkt_wgt
--3.	Lbs/Sow/Yr = [Sum (Prim Wt) (w-0 to w-51) + Sum (Cull Wt) (w-0 to w-51)] / [(Total Lac Days / 399)(w-22 to w-78) + (Total Gest Days / 490)(w-25 to w-94)]
  , (w51w00.wtsold)/ (#ldays.lday385 + #gdays.gday483) as [LBS mkt per inv sow per year]
--4.	Pigs Marketed/Sow/Yr = [Sum (Prim Qty)(w-0 to w-51) + Sum (Cull Qty) (w-0 to w-51)] / [(Total Lac Days / 399)(w-22 to w-78) + (Total Gest Days / 490)(w-25 to w-94)]
 , (w51w00.qtysold)/ (#ldays.lday385 + #gdays.gday483) as [pigs mkt per inv sow per year]
from (select distinct reportinggroupid, Reporting_Group_Description 
	  FROM [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] 
      where reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)	) S
left join #pf_list
	on #pf_list.reportinggroupid = S.reportinggroupid
left join #mkt mkt
	on mkt.reportinggroupid = S.reportinggroupid
left join #w51w00 w51w00
	on w51w00.reportinggroupid = S.reportinggroupid
--left join #SD SD
--	on SD.reportinggroupid = S.reportinggroupid
--left join #mweeks
--	on #mweeks.reportinggroupid = S.reportinggroupid
left join #Ldays
	on #Ldays.reportinggroupid = S.reportinggroupid
left join #Gdays
	on #Gdays.reportinggroupid = S.reportinggroupid



END








