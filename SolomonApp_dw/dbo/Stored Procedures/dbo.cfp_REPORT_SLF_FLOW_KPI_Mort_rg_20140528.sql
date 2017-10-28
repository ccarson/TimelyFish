



-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FLOW_KPI_Mort
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FLOW_KPI_Mort_rg_20140528]
	@mg_week char(6), @reportinggroupid_list varchar(50)
	
	AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
SET NOCOUNT ON;

declare @enddate datetime		-- last daydate value for the entered picyear_week value
declare @startdate datetime		-- fist daydate value for the 27th week prior to entered week value
declare @pyweek_start char(6)	-- picyear_week value for 27 weeks earlier than the entered value
declare @fstartdate datetime
declare @fenddate datetime
declare @fpyweek_start char(6)
declare @fpyweek_end char(6)


-- marketing pig time frames
select @enddate = max(daydate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where picyear_week = @mg_week
-- get picyear_week value for first day of the market interval
select @pyweek_start = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-25,@enddate)
-- get datetime value for first day of the interval
select @startdate = min(daydate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where picyear_week = @pyweek_start



declare @w00 char(6)			-- entered picyear_week value
	set @w00 = @mg_week
declare @w25 char(6)			-- prior 25th week
	select @w25 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-25,@enddate)
declare @w23 char(6)			-- prior 25th week
	select @w23 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-23,@enddate)	
declare @w26 char(6)			-- prior 25th week
	select @w26 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-26,@enddate)
declare @w02 char(6)			-- minus 2 weeks
	select @w02 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-2,@enddate)
declare @w27 char(6)
	select @w27 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-27,@enddate)
declare @w48 char(6)
	select @w48 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-48,@enddate)
declare @w51 char(6)
	select @w51 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-51,@enddate)
	
	
	

-- farrowing time frames
select @fpyweek_start = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-25,@startdate)
select @fstartdate = min(daydate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where picyear_week = @fpyweek_start
select @fpyweek_end = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-25,@enddate)
select @fenddate = max(daydate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
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
 where mg_week between @pyweek_start and @mg_week
 and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
 

 
 
-- Sow farrowing/weaning summary data
 select fw.reportinggroupid
 , cast(sum(Born_Alive_qty) as float) sumba
 , cast(sum(Stillborn_qty) as float) sumsb
 , cast(sum(mummy_qty) as float) summ
 , cast(sum(wean_qty) as float) sumwqty
 , 100*( cast(sum(Stillborn_qty) as float)/( cast(sum(Born_Alive_qty) as float) + cast(sum(Stillborn_qty) as float) + cast(sum(mummy_qty) as float) ) ) pctSB
 , 100*( cast(sum(mummy_qty) as float)/(cast(sum(Born_Alive_qty) as float) + cast(sum(Stillborn_qty) as float) + cast(sum(mummy_qty) as float))) pctMum
 , 100*( (cast(sum(Born_Alive_qty) as float) + cast(sum(Stillborn_qty) as float) + cast(sum(mummy_qty) as float) - cast(sum(wean_qty) as float)) 
 / (cast(sum(Born_Alive_qty) as float)+ cast(sum(Stillborn_qty) as float) + cast(sum(mummy_qty) as float)) ) PctFH
 , 100*( (cast(sum(Born_Alive_qty) as float)  - cast(sum(wean_qty) as float)) 
 / (cast(sum(Born_Alive_qty) as float)) ) pwm
 , cast(sum(Litters_farrowed_qty) as float) as farrow_litter_qty
 , cast(sum(litters_weaned_qty) as float) as wean_litter_qty 
into #FH
from [dbo].[cft_SowMart_farrow_wean_weekly_Rollup] fw (nolock)
--where fw.picyear_week between @fpyweek_start and @fpyweek_end
where fw.picyear_week  between @w51 and @w26
and fw.reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
group by fw.reportinggroupid


-- select fw.reportinggroupid, sum(Born_Alive_qty) sumba, sum(Stillborn_qty) sumsb, sum(mummy_qty) summ, sum(wean_qty) sumwqty
-- , 100*( sum(Stillborn_qty)/(sum(Born_Alive_qty) + sum(Stillborn_qty) + sum(mummy_qty))) pctSB
-- , 100*( sum(mummy_qty)/(sum(Born_Alive_qty) + sum(Stillborn_qty) + sum(mummy_qty))) pctMum
-- , 100*( (sum(Born_Alive_qty) + sum(Stillborn_qty) + sum(mummy_qty) - sum(wean_qty)) / (sum(Born_Alive_qty)+ sum(Stillborn_qty) + sum(mummy_qty)) ) PctFH
-- , sum(Litters_farrowed_qty) as farrow_litter_qty
-- , sum(litters_weaned_qty) as wean_litter_qty 
--into #w51tow25_sow
--from [dbo].[cft_SowMart_farrow_wean_weekly_Rollup] fw (nolock)
--where fw.picyear_week between @w51 and @w25
--and fw.reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
--and born_alive_qty > 0
--group by fw.reportinggroupid

select fw.reportinggroupid, sum(wean_qty) wqty, sum(nurseon_qty) sumnqty, (sum(wean_qty) - sum(nurseon_qty) ) sumwqty, sum(litters_weaned_qty) as wean_litter_qty 
into #w48tow23_sow
from [dbo].[cft_SowMart_farrow_wean_weekly_Rollup] fw (nolock)
where fw.picyear_week between @w48 and @w23
and fw.reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
and born_alive_qty > 0
group by fw.reportinggroupid

--select reportinggroupid, sum(transferinwp_qty) as wean_qty	
--into #w25tow00_wean 
--FROM [dbo].[cft_SLF_ESSBASE_DATA]
--where mg_week between @w25 and @w00
--  and phase in ('nur', 'wtf')
--  and transferinwp_qty > 0
--  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
--  group by reportinggroupid


--select fw.reportinggroupid, sum(Born_Alive_qty) sumba
--, sum(Litters_farrowed_qty) lfq
--into #w27tow02_sow
--from [dbo].[cft_SowMart_farrow_wean_weekly_Rollup] fw (nolock)
--where fw.picyear_week between @w27 and @w02
--and fw.reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
--and born_alive_qty > 0
--group by fw.reportinggroupid


-- sowdays
select pf.reportinggroupid,sum([total_sow_days]) sowdays, avg(total_sow_qty) sowqty
into #SD
from [dbo].[cft_SowMart_weekly_Rollup] sq
inner join [$(PigCHAMP)].[careglobal].[FARMS] f (nolock)
	on f.farm_name = sq.farmid
inner join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	on pff.contactid = cast(f.farm_number as int)
inner join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	on pf.pigflowid = pff.pigflowid
where sq.picyear_week between @fpyweek_start and @fpyweek_end
and pf.reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
group by pf.reportinggroupid



--NUR
select reportinggroupid,Reporting_group_description
, @pyweek_start starting_picyear_week, @mg_week ending_picyear_week	---  mortality needs to be Transport deaths on move / qty leaving sow farm  wean - (TD + db4grade + std)
--8.	Nursery DOA/DOT% = 100*Sum(Pig Transfer Death Qty Nursery Phase)/ (Sum(TransferInWP_Qty) + Sum(MoveInWP_Qty)) 6 month interval
, 100 * (  sum(pigdeathTD_qty)/( sum(transferinwp_qty) + sum(movein_qty) )  ) as NURdotpct	
--7.	Nursery Mort% =100*(Sum(Pig Death Qty Nursery Phase)+Sum(Pig Transfer Death Qty Nursery Phase))/(Sum(TransferInWP_Qty) + Sum(MoveInWP_Qty)) 6 month interval
, (sum(pigdeath_qty) + sum(pigdeathTD_qty))/((sum(transferinwp_qty) + sum(movein_qty)))*100 as NurMortpct	-- remove the pigdeathTD_qty
into #mortNUR 
FROM [dbo].[cft_SLF_ESSBASE_DATA]
where mg_week between @fpyweek_start and @fpyweek_end
  and phase in ('nur', 'wtf')
  and transferinwp_qty > 0
  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  group by reportinggroupid,Reporting_group_description
  order by Reporting_group_description
  
  
  
select reportinggroupid, Reporting_group_description	--, phase
, @pyweek_start starting_picyear_week, @mg_week ending_picyear_week
--10.	Finish DOA/DOT% = 100*(Sum(Pig Transport Death Qty Finish Phase) +Sum(DOT) + Sum(DOA))/ (Sum(TransferIn_Qty) + Sum(MoveIn_Qty)) 6 month interval
, 100 * (  ( sum(transportdeath_qty) + sum(deadontruck_qty) + sum(deadinyard_qty)  ) /( sum(transferin_qty) + sum(movein_qty) )  )  as Findoadotpct
--, sum(deadontruck_qty) + sum(transportdeath_qty) as finMort
--9.	Finish Mort% =100*(Sum(Pig Death Qty Finish Phase)+Sum(Pig Transport Death Qty Finish Phase))/(Sum(TransferIn_Qty) + Sum(MoveIn_Qty)) 6 month interval
, 100 * (  ( sum(pigdeath_qty) + sum(transportdeath_qty) ) /(sum(transferin_qty) + sum(movein_qty))  ) as finmortpct	-- 10/2/2013
into #mortFIN
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where mg_week between @pyweek_start and @mg_week
  and phase = 'FIN'
  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  group by reportinggroupid, Reporting_group_description	--, phase
order by Reporting_group_description


select reportinggroupid, Reporting_group_description	--, phase
, @pyweek_start starting_picyear_week, @mg_week ending_picyear_week
, sum(deadontruck_qty) + sum(transportdeath_qty) /(sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty))*100 as wtfdoadotpct
--, sum(deadontruck_qty) + sum(transportdeath_qty) as wtfMort
--11.	WTF Mort% =100*(Sum(Pig Death Qty WTF Phase)+Sum(Pig Transport Death Qty WTF Phase))/(Sum(TransferIn_Qty) + Sum(MoveIn_Qty)) 6 month interval
--------***************************************   need transferinwp_qty, otherwise zeros
, 100 * (( sum(pigdeath_qty) + sum(transportdeath_qty) ) / ( sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty )) ) as wtfMortpct	
into #mortWTF
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where mg_week between @pyweek_start and @mg_week
  and phase = 'WTF'
  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  group by reportinggroupid, Reporting_group_description	--, phase
order by Reporting_group_description


select reportinggroupid, Reporting_group_description	--, phase
, @pyweek_start starting_picyear_week, @mg_week ending_picyear_week
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
  , sum(prim_qty) + sum(cull_qty) as amtsold
into #mortmkt
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where mg_week between @pyweek_start and @mg_week
--  and phase in ('FIN', 'wtf')		want all phases
  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  group by reportinggroupid, Reporting_group_description	--, phase
order by Reporting_group_description

-- (w-00 to w-25) data
select reportinggroupid, reporting_group_description, sum(prim_qty) + sum(cull_qty) as amtsold
into #w25tow00_mkt
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where mg_week between @w25 and @w00
  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  group by reportinggroupid, Reporting_group_description	--, phase

order by Reporting_group_description


select S.reportinggroupid, S.Reporting_group_description
--3.	Total Born/litter = (Sum(bornlive) + Sum(stillborn) + Sum(mummies))/Sum(Sows Farrowed)
, (#FH.sumba + #FH.sumsb + #FH.summ)/ #FH.farrow_litter_qty  as born	-- total born / litter
--4.	Live Born/litter = Sum(bornlive)/Sum(Farrowed)
, #FH.sumba / #FH.farrow_litter_qty as ba								-- total born alive  / litter
--5.	Wean/litter = Sum(Good Pigs Weaned)(w-0 to w-25) / Sum(Sows Weaned)(w-0 to w-25) 
----!!!!!!!!!!!!!!!!!!!   good pigs weaned needs another data source....   !!!!!!!!!!!!!!!!!!!!!
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
--, 1.0 as [mortality tailender]
, wtf.wtfMortpct
, mkt.dotpct
, mkt.diypct
, mkt.compct
--, (mkt.amtsold/SD.sowqty)*2 as [lbs per inv sow per year]
-- 15.	Total % Mort = 100*(Pigs born alive(w-25 to w-51) – Pigs Sold(w-0 to w-25))/ Pigs born alive(w-25 to w-51)
, 100 * (cast(#FH.sumba as float) - (cast(w2500mkt.amtsold as float))) / cast(#FH.sumba as float)  as [totapctmort]
--6.	PWM % = 100*(Sum(born alive)(w-2 to w-27) – Sum(weaned)(w-0 to w-25))/ (Sum(born alive)(w-2 to w-27)
from (select distinct reportinggroupid, Reporting_Group_Description 
	  FROM [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] 
      where reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)	) S
left join #pf_list list
	on list.reportinggroupid = S.reportinggroupid
left join #FH
	on #FH.reportinggroupid = list.reportinggroupid and #fh.sumba > 0
left join #mortNUR nur
	on nur.reportinggroupid = list.reportinggroupid
left join #mortFin fin
	on fin.reportinggroupid = list.reportinggroupid
left join #mortwtf wtf
	on wtf.reportinggroupid = list.reportinggroupid
left join #mortmkt mkt
	on mkt.reportinggroupid = list.reportinggroupid
left join #SD SD
	on SD.reportinggroupid = list.reportinggroupid
left join #w25tow00_mkt w2500mkt
	on w2500mkt.reportinggroupid = list.reportinggroupid
--left join #w51tow26_sow w5126
--	on w5125.reportinggroupid = list.reportinggroupid  and w5125.sumba > 0
--left join #w27tow02_sow w2702
--	on w2702.reportinggroupid = list.reportinggroupid
left join #w48tow23_sow w4823sow
	on w4823sow.reportinggroupid = list.reportinggroupid
--left join #w25tow00_wean w2500wean
--	on w2500wean.reportinggroupid = list.reportinggroupid


END





