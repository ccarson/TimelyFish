









-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FLOW_KPI_Mort
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
-- Update: Fixed the Wean/Litter and PWM % accounts by removing the code that was subtracting real wean pigs (nurse_qty) from the correct numbers
-- jlm 04/29/2016
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FLOW_KPI_mort_rg]
	@mg_week char(6), @reportinggroupid_list varchar(50)
	
	AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
SET NOCOUNT ON;

declare @pg_week char(6)
set @pg_week = @mg_week

declare @enddate datetime		-- last daydate value for the entered picyear_week value
declare @startdate datetime		-- fist daydate value for the 27th week prior to entered week value	
declare @fstartdate datetime
declare @fenddate datetime
declare @fpyweek_start char(6)
declare @fpyweek_end char(6)
declare @w25 char(6)


-- marketing pig time frames
select @enddate = max(daydate) from  dbo.cftDayDefinition_WithWeekInfo
where picyear_week = @pg_week
-- get picyear_week value for first day of the market interval
select @w25 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-25,@enddate)
-- get datetime value for first day of the interval
select @startdate = min(daydate) from  dbo.cftDayDefinition_WithWeekInfo
where picyear_week = @w25



declare @w00 char(6)			-- entered picyear_week value
	set @w00 = @pg_week
declare @w23 char(6)			-- prior 25th week
	select @w23 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-23,@enddate)	
declare @w26 char(6)			-- prior 25th week
	select @w26 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-26,@enddate)
declare @w02 char(6)			-- minus 2 weeks
	select @w02 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-2,@enddate)
declare @w27 char(6)
	select @w27 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-27,@enddate)
declare @w48 char(6)
	select @w48 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-48,@enddate)
declare @w51 char(6)
	select @w51 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-51,@enddate)
declare @w74 char(6)
	select @w74 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-74,@enddate)
declare @w77 char(6)
	select @w77 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-77,@enddate)
	
	
	

-- farrowing time frames
select @fpyweek_start = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-25,@startdate)
select @fstartdate = min(daydate) from  dbo.cftDayDefinition_WithWeekInfo
where picyear_week = @fpyweek_start
select @fpyweek_end = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-25,@enddate)
select @fenddate = max(daydate) from  dbo.cftDayDefinition_WithWeekInfo
where picyear_week = @fpyweek_end



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
where reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)

--

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
where reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
and pg_week between @w25 and @pg_week

  


select fw.farmid
 , cast(sum(Born_Alive_qty) as float) Born_Alive_qty
 , cast(sum(Stillborn_qty) as float) Stillborn_qty
 , cast(sum(mummy_qty) as float) mummy_qty
 , cast(sum(Litters_farrowed_qty) as float) as Litters_farrowed_qty
into #FH_pre
from [dbo].[cft_SowMart_farrow_wean_weekly_Rollup] fw (nolock)
where fw.picyear_week between @w51 and @w26
and fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
group by fw.farmid



select xx.reportinggroupid
 , cast(sum(Born_Alive_qty) as float) sumba
 , cast(sum(Stillborn_qty) as float) sumsb
 , cast(sum(mummy_qty) as float) summ
 , 100*( cast(sum(Stillborn_qty) as float)/( cast(sum(Born_Alive_qty) as float) + cast(sum(Stillborn_qty) as float) + cast(sum(mummy_qty) as float) ) ) pctSB
 , 100*( cast(sum(mummy_qty) as float)/(cast(sum(Born_Alive_qty) as float) + cast(sum(Stillborn_qty) as float) + cast(sum(mummy_qty) as float))) pctMum
 , cast(sum(Litters_farrowed_qty) as float) as farrow_litter_qty

into #FH
	from
	(select distinct fid.reportinggroupid, f.*
	from #FH_pre f
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

select fw.farmid
 , sum(wean_qty) wean_qty, sum(nurseon_qty) nurseon_qty, count(1) as litters_weaned_qty 
into #w48tow23_sow_pre
from [dbo].[cft_SowMart_detail_data] fw (nolock)
where fw.final_wean_picyear_week between @w48 and @w23
and fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
and fw.born_alive_qty > 0
group by fw.farmid
--select fw.farmid
-- , sum(wean_qty) wean_qty, sum(nurseon_qty) nurseon_qty, sum(litters_weaned_qty) as litters_weaned_qty 
--into #w48tow23_sow_pre
--from [dbo].[cft_SowMart_farrow_wean_weekly_Rollup] fw (nolock)
--where fw.picyear_week between @w48 and @w23
--and fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
--and fw.born_alive_qty > 0
--group by fw.farmid

select xx.reportinggroupid
/* Stop subtracting the "nurseon_qty" from the weaned pig totals.  The value in wean_qty is the closest value to actual weaned pigs */
/* that comes from this current data source (cft_SowMart_farrow_wean_weekly_Rollup)  jlm 4/29/2016  */
--, sum(wean_qty) wqty, sum(nurseon_qty) sumnqty, (sum(wean_qty) - sum(nurseon_qty) ) sumwqty, sum(litters_weaned_qty) as wean_litter_qty
, sum(wean_qty) wqty, sum(nurseon_qty) sumnqty, sum(wean_qty) sumwqty, sum(litters_weaned_qty) as wean_litter_qty
into #w48tow23_sow
	from
	(select distinct fid.reportinggroupid, f.*
	from #w48tow23_sow_pre f
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

----NUR
--select reportinggroupid,Reporting_group_description
--, @w25 starting_picyear_week, @pg_week ending_picyear_week	---  mortality needs to be Transport deaths on move / qty leaving sow farm  wean - (TD + db4grade + std)
----8.	Nursery DOA/DOT% = 100*Sum(Pig Transfer Death Qty Nursery Phase)/ (Sum(TransferInWP_Qty) + Sum(MoveInWP_Qty)) 6 month interval
--, 100 * (  sum(cast(pigdeathTD_qty as float))/( sum(cast(transferinwp_qty as float)) + sum(cast(movein_qty as float)) )  ) as NURdotpct	
----7.	Nursery Mort% =100*(Sum(Pig Death Qty Nursery Phase)+Sum(Pig Transfer Death Qty Nursery Phase))/(Sum(TransferInWP_Qty) + Sum(MoveInWP_Qty)) 6 month interval
----, (sum(pigdeath_qty) + sum(pigdeathTD_qty))/((sum(transferinwp_qty) + sum(movein_qty)))*100 as NurMortpct	-- remove the pigdeathTD_qty
----, (sum(pigdeath_qty) + sum(pigdeathTD_qty) + sum(TransportDeath_Qty))/((sum(Transferinwp_qty) + sum(TransferIn_qty) + sum(MoveIn_qty) - sum(MoveOut_qty) ))*100 as NurMortpct
----, ((sum(pigdeath_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty))/((sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty) - sum(MoveOut_qty) - sum(transferout_qty))))*100 as NurMortpct
--, ((sum(pigdeath_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty))/((sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty) - sum(MoveOut_qty))))*100 as NurMortpct

--into #mortNUR 
--FROM [dbo].[cft_SLF_ESSBASE_DATA]
--where pg_week between @w25 and @pg_week
--  and phase = 'nur'	--in ('nur', 'wtf')
--  and transferinwp_qty > 0
--  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
--  group by reportinggroupid,Reporting_group_description
--  order by Reporting_group_description
--NUR
select reportinggroupid,Reporting_group_description
, @w25 starting_picyear_week, @pg_week ending_picyear_week
, 100 * (  sum(cast(pigdeathTD_qty as float))/( sum(cast(transferinwp_qty as float)) + sum(cast(movein_qty as float)) )  ) as NURdotpct	
, ((sum(pigdeath_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty))/((sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty) - sum(MoveOut_qty))))*100 as NurMortpct

into #mortNUR 
FROM [dbo].[cft_SLF_ESSBASE_DATA]
where pg_week between @w25 and @pg_week
  and phase = 'nur'
  and transferinwp_qty > 0
  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  group by reportinggroupid,Reporting_group_description
  order by Reporting_group_description
  
  
  
select reportinggroupid, Reporting_group_description	--, phase
, @w25 starting_picyear_week, @pg_week ending_picyear_week
--10.	Finish DOA/DOT% = 100*(Sum(Pig Transport Death Qty Finish Phase) +Sum(DOT) + Sum(DOA))/ (Sum(TransferIn_Qty) + Sum(MoveIn_Qty)) 6 month interval
, 100 * (  ( sum(transportdeath_qty) + sum(deadontruck_qty) + sum(deadinyard_qty)  ) /( sum(transferin_qty) + sum(movein_qty) )  )  as Findoadotpct
--, sum(deadontruck_qty) + sum(transportdeath_qty) as finMort
--9.	Finish Mort% =100*(Sum(Pig Death Qty Finish Phase)+Sum(Pig Transport Death Qty Finish Phase))/(Sum(TransferIn_Qty) + Sum(MoveIn_Qty)) 6 month interval
--, 100 * (  ( sum(pigdeath_qty) + sum(transportdeath_qty) ) /(sum(transferin_qty) + sum(movein_qty))  ) as finmortpct	-- 10/2/2013
--, (sum(pigdeath_qty) + sum(pigdeathTD_qty) + sum(TransportDeath_Qty))/((sum(Transferinwp_qty) + sum(TransferIn_qty) + sum(MoveIn_qty) - sum(MoveOut_qty)))*100 as finmortpct
, (sum(pigdeath_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty))/((sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty) - sum(MoveOut_qty) - sum(transferout_qty)))*100 as finmortpct
into #mortFIN
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where pg_week between @w25 and @pg_week		-- 25 to 0
  and phase = 'FIN'
  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  group by reportinggroupid, Reporting_group_description	--, phase
order by Reporting_group_description


select reportinggroupid, Reporting_group_description	--, phase
, @w25 starting_picyear_week, @pg_week ending_picyear_week
, sum(deadontruck_qty) + sum(transportdeath_qty) /(sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty))*100 as wtfdoadotpct
--, sum(deadontruck_qty) + sum(transportdeath_qty) as wtfMort
--11.	WTF Mort% =100*(Sum(Pig Death Qty WTF Phase)+Sum(Pig Transport Death Qty WTF Phase))/(Sum(TransferIn_Qty) + Sum(MoveIn_Qty)) 6 month interval
--------***************************************   need transferinwp_qty, otherwise zeros
--, 100 * (( sum(pigdeath_qty) + sum(transportdeath_qty) ) / ( sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty )) ) as wtfMortpct	
--, (sum(pigdeath_qty) + sum(pigdeathTD_qty) + sum(TransportDeath_Qty))/((sum(Transferinwp_qty) + sum(TransferIn_qty) + sum(MoveIn_qty) - sum(MoveOut_qty)))*100 as wtfMortpct
, (sum(pigdeath_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty))/((sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty) - sum(MoveOut_qty) - sum(transferout_qty)))*100 as wtfMortpct

into #mortWTF
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where pg_week between @w25 and @pg_week		-- 25 to 0
  and phase = 'WTF'
  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  group by reportinggroupid, Reporting_group_description	--, phase
order by Reporting_group_description









select reportinggroupid, Reporting_group_description	--, phase
, @w25 starting_picyear_week, @pg_week ending_picyear_week
  , sum(deadontruck_qty) + sum(deadinyard_qty)+ sum(condemn_qty) dotdiyc
--12.	% DOA = 100*(Sum(Dead on Truck Qty All Phases))/(Sum(TransferIn_Qty all phases) + Sum(MoveIn_Qty all phases)) 6 month interval
  ,           100 * (  sum(deadontruck_qty) / ( sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty) )) as dotpct
--13.	% DIY = 100*(Sum(Dead In Yard Qty All Phases))/(Sum(TransferIn_Qty all phases) + Sum(MoveIn_Qty all phases)) 6 month interval
  ,             100*( sum(deadinyard_qty) / ( sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty) ) ) as diypct
-- 14.	% Condemns = 100*(Sum(Condemns Qty All Phases))/(Sum(TransferIn_Qty all phases) + Sum(MoveIn_Qty all phases)) 6 month interval
  ,                  100*(sum(condemn_qty)/(sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty)) ) as compct
  , sum(prim_qty)
  /((sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty) 
  - (sum(moveout_qty) + sum(transferout_qty) + SUM(transfertotailender_qty)+sum(pigdeath_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) )))*100 as primpct	-- per marketed pig
  , sum(cull_qty) /((sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty) 
  - (sum(moveout_qty) + sum(transferout_qty) + SUM(transfertotailender_qty)+sum(pigdeath_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) )))*100 as cullpct	-- per marketed pig 
, sum(pigdeath_qty) + sum(pigdeathtd_qty) + sum(transportdeath_qty) PDtot
, sum(prim_qty) + sum(cull_qty) as amtsold
, sum(TransferInWP_qty) + Sum(TransferIn_qty) + Sum(MoveIn_qty) - sum(moveout_qty) - sum(transferout_qty)  HS
, sum(prim_qty) + sum(cull_qty) + sum(deadontruck_qty) + sum(deadinyard_qty) + sum(condemn_qty) THP
into #mortmkt
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where pg_week between @w25 and @pg_week		-- 25 to 0
  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  group by reportinggroupid, Reporting_group_description	--, phase
order by Reporting_group_description

-- estimated to actual wean
--select [FarmID]
--      ,sum([Wean_qty]) Wean_qty
--      ,sum([Litters_weaned_qty]) Litters_weaned_qty
--into #EAwean_pre
--from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
--where fw.picyear_week between @w74 and @w23
--and fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
--group by fw.farmid

select [FarmID]
      ,sum([Wean_qty]) Wean_qty
      ,sum([Litters_weaned_qty]) Litters_weaned_qty
into #EAwean_pre
from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
join #lookback on fw.reportinggroupid = #lookback.reportinggroupid and fw.picyear_week = #lookback.w23
where fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
group by fw.farmid



-- estimated to actual farrow
--select [FarmID]
--      ,sum([Litters_farrowed_qty]) Litters_farrowed_qty
--into #EAfarrow_pre
--from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
--where fw.picyear_week between @w77 and @w26
--and fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
--group by fw.farmid

select [FarmID]
      ,sum([Litters_farrowed_qty]) Litters_farrowed_qty
      ,sum(born_alive_qty) born_alive_qty
into #EAfarrow_pre
from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
join #lookback on fw.reportinggroupid = #lookback.reportinggroupid and fw.picyear_week = #lookback.w26
where fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
group by fw.farmid



select xx.reportinggroupid, ( cast(sum(wean_qty) as float)/cast(sum(litters_weaned_qty) as float) ) gpw_per_sowwean
, sum(litters_farrowed_qty) litters_farrowed_qty
, (   (sum(cast(xx.born_alive_qty as float))/sum(cast(xx.litters_farrowed_qty as float)) ) - (sum(cast(xx.Wean_qty as float))/sum(cast(Litters_weaned_qty as float)) )  )
/    ( sum(cast(xx.born_alive_qty as float))/sum(cast(xx.litters_farrowed_qty as float)) ) as pwm_pct
, sum(xx.born_alive_qty) born_alive_qty
into #EA
	from
	(select distinct fid.reportinggroupid,f.born_alive_qty, f.Litters_farrowed_qty, w.Wean_qty, w.Litters_weaned_qty
	from #EAwean_pre w
	join #EAfarrow_pre f 
		on f.farmid = w.farmid
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
	--join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	--	on w.farmid = pcf.farm_name
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	--	on cast(pcf.farm_number as int) = cast(pff.contactid as int)
	--join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	--	on pff.pigflowid = pf.pigflowid
	--join #pf_list l
	--	on l.reportinggroupid = pf.reportinggroupid
	) xx
	group by xx.reportinggroupid

---- (w-00 to w-25) data
--select reportinggroupid, reporting_group_description, sum(prim_qty) + sum(cull_qty) as amtsold
--into #w25tow00_mkt
--FROM [dbo].[cft_SLF_ESSBASE_DATA] 
--where pg_week between @w25 and @w00
--  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
--  group by reportinggroupid, Reporting_group_description	--, phase

--order by Reporting_group_description


select S.reportinggroupid, S.Reporting_group_description
--3.	Total Born/litter = (Sum(bornlive) + Sum(stillborn) + Sum(mummies))/Sum(Sows Farrowed)
, (#FH.sumba + #FH.sumsb + #FH.summ)/ #FH.farrow_litter_qty  as born	-- total born / litter
--4.	Live Born/litter = Sum(bornlive)/Sum(Farrowed)
, #FH.sumba / #FH.farrow_litter_qty as ba								-- total born alive  / litter
--5.	Wean/litter = Sum(Good Pigs Weaned)(w-0 to w-25) / Sum(Sows Weaned)(w-0 to w-25) 
--,  cast(w2500wean.wean_qty as float)/ cast(w2500sow.wean_litter_qty as float) as [Wean/Litter]	
,  cast(w4823sow.sumwqty as float)/ cast(w4823sow.wean_litter_qty as float) as [Wean/Litter]					
, #FH.pctMum
, #FH.pctSB
--, #fh.pwm as pctfh 
--, 100 * ( ( cast(w2702.sumBA as float) - cast(w2500sow.sumwqty as float) ) / cast(w2702.sumBA as float) ) as pctfh		-- PWM
, 100 * 
( 
	( (cast(#FH.sumba as float)/#FH.farrow_litter_qty) - (  cast(w4823sow.sumwqty as float)/ cast(w4823sow.wean_litter_qty as float) )  ) 
	/ 
	( (cast(#FH.sumba as float)/#FH.farrow_litter_qty) )
) as pctfh		-- PWM
, nur.NURdotpct				-- ? nursery doa/dot %
, nur.NurMortpct			-- 100 * (  (sum(pigdeathqtyNur) + sum(TDNur) ) / ( sum(tiwp) + sum(miwp) )  ) --6 month interval
, fin.Findoadotpct
, fin.finMortpct
, wtf.wtfdoadotpct
, wtf.wtfMortpct
, mkt.dotpct
, mkt.diypct
, mkt.compct
--,100 * (mkt.PDtot / (((mkt.HS/#ea.gpw_per_sowwean)/#EA.litters_farrowed_qty) * cast(#FH.sumba as float) ) )  as [totapctmort]
, (  ( mkt.hs / (1-#ea.pwm_pct) ) - (mkt.thp) )/ (mkt.hs / (1-#ea.pwm_pct))*100    as [totapctmort]
from (select distinct reportinggroupid, Reporting_Group_Description 
	  FROM [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] 
      where reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)	) S
left join #pf_list list
	on list.reportinggroupid = S.reportinggroupid
left join #FH		-- 51 to 26
	on #FH.reportinggroupid = S.reportinggroupid and #fh.sumba > 0
left join #mortNUR nur	-- 50 to 25 weeks
	on nur.reportinggroupid = S.reportinggroupid
left join #mortFin fin	-- 25 to 0 weeks
	on fin.reportinggroupid = S.reportinggroupid
left join #mortwtf wtf		-- 25 to 0
	on wtf.reportinggroupid = S.reportinggroupid
left join #mortmkt mkt		-- 25 to 0
	on mkt.reportinggroupid = S.reportinggroupid
left join #w48tow23_sow w4823sow
	on w4823sow.reportinggroupid = S.reportinggroupid
left join #ea
	on #ea.reportinggroupid = S.reportinggroupid



END

























GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_FLOW_KPI_mort_rg] TO [db_sp_exec]
    AS [dbo];

