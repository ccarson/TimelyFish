

CREATE PROCEDURE [dbo].[cfp_reload_cft_sowmart_detail_data]
AS
BEGIN

/* -- ----------------------------------------------

Updated 30 Oct 2015 by BMD: Added in a section to update the mating information for sows that were bred offsite from where they farrowed
                            Added in a section to update rows with mating events to have the PigChamp Genetics name for the SemenId used
1/4/2016	BMD: Updated last two update statements to properly update the staging table
-- --------------------------------------------------- */

truncate table  [dbo].[cft_SowMart_Detail_data_stg]

truncate table  dbo.matings_stg

-- Create a temporary table to hold matings information - gets just the first mating event for each group.
  -- Speeds up performance of the rest of the load
  -- Only look at mating events for Sow/Gilt arrivals from 2006 and forward
   
-- Get all matings from the matings table
insert into  dbo.matings_stg (eventdate, event_id, identity_id, supervisor_id, male_identity_id, site_id)
select eventdate, event_id, identity_id, supervisor_id , male_identity_id, site_id
from (select m.eventdate, m.event_id, m.identity_id, m.supervisor_id , em.male_identity_id, m.site_id
                , row_number() over(partition by m.identity_id, em.service_group order by m.eventdate, m.event_id) as sowmating
       from [$(PigCHAMP)].caredata.bh_events m (NOLOCK)
       inner join [$(PigCHAMP)].caredata.ev_matings em (nolock) on em.identity_id = m.identity_id and em.event_id = m.event_id and m.deletion_date is null
       Where m.identity_id in (select identity_id from [$(PigCHAMP)].caredata.bh_events (NOLOCK) where event_type in (100,110) and eventdate >= '2006-01-01')
      ) fall
where fall.sowmating = 1

-- Now get all bred sows coming into the system as parity zero bred gilts
insert into  dbo.matings_stg (eventdate, event_id, identity_id, supervisor_id, male_identity_id, site_id)
select hs.service_date, NULL, hs.identity_id, NULL, NULL, be.site_id -- hs.sire_identity has varchar data - doesn't match bh_identity_history table
from [$(PigCHAMP)].caredata.HDR_SOWS hs (NOLOCK)
inner join [$(PigCHAMP)].caredata.BH_EVENTS be (NOLOCK) on hs.identity_id=be.identity_id and be.event_type=110 -- 110 is sow arrival
where hs.starting_parity=0 and hs.service_date is not null and hs.service_date >= '2006-01-01'


-- get mated sow transfers
select site_id, identity_id, eventdate 
into #Toff
from [$(PigCHAMP)].caredata.bh_events (nolock) where event_type = 295 and deletion_date is null

select site_id, identity_id, eventdate 
into #Ton
from [$(PigCHAMP)].caredata.bh_events (nolock) where event_type = 294 and deletion_date is null


insert into  dbo.matings_stg (eventdate, event_id, identity_id, supervisor_id, male_identity_id, site_id)
select mate.eventdate, NULL, mate.identity_id, NULL, NULL, ton.site_id 
from #Toff toff
join #Ton ton
	on ton.identity_id = toff.identity_id and ton.eventdate = toff.eventdate
join (select be.site_id, be.identity_id, be.event_type, min(be.eventdate) eventdate
      , row_number() over (partition by be.site_id, be.identity_id order by min(be.eventdate) desc) as rownumber 
      from [$(PigCHAMP)].caredata.bh_events  be (nolock)
      join  #Toff on #toff.site_id = be.site_id and #toff.identity_id = be.identity_id  and be.eventdate < #toff.eventdate --and be.event_type <>  295
      where be.deletion_date is null and be.event_type <>  295  and be.event_type <> 100	-- 20141216 added <> 100 exclude gilt arrivals as top row
      group by be.site_id, be.event_type, be.identity_id) mate
	on mate.site_id = toff.site_id and mate.identity_id = toff.identity_id and mate.rownumber = 1
where ton.site_id <> 99 and mate.event_type = 270
except
select [eventdate]      ,null      ,[identity_id]      ,null      ,null      ,[site_id]
from  dbo.matings_stg
where site_id <> 99



-- get mated sow transfers




-- Step one - build initial data including 1st mating and farrow dates
insert into  [dbo].[cft_SowMart_Detail_data_stg](
[FarmID], [SiteID], [GroupID], [SowID],
[IdentityID], [SowParity], [mating_date],
[farrow_date], [SemenID],
[Observer], [MatingNbr], born_alive_qty,
Stillborn_qty , mummy_qty , Total_born_qty,
[SowGenetics], MatingEventId)
select  SUBSTRING(farm.[farm_name],1,8) AS FarmID 
    , farm.site_id as SiteID
    , isnull(em.service_group,0) as GroupID
    , SUBSTRING(IH.[primary_identity],1,12) as SowID
    , IH.Identity_Id as IdentityID
  , (case when isnull(fe.Parity,0) = 0 -- This will happen with there is not a farrowing to match the mating
         then case when (select case when ev.eventdate < min(eventdate) then 0 else max(parity) end 
                           from  [$(PigCHAMP)].dbo.cft_sowparity (NOLOCK) where identity_id=IH.identity_id and event_type=170 group by identity_id) is null  -- This will happen when the very first mating does not match a farrowing (like a fall out event, then remated later)
              then 0
              else coalesce((select case when ev.eventdate < min(eventdate) then 0 else max(parity) end  -- This will happen if the mating event does not match a farrowing (fallout) and the mating event is in the middle of the matings/farrowings for the sow.
                      from  [$(PigCHAMP)].dbo.cft_sowparity (NOLOCK) 
                      where identity_id=IH.identity_id and eventdate < ev.eventdate and event_type=170
                      group by identity_id),0)
              END
         else isnull(fe.Parity,0) 
         END) as SowParity       
  , ev.Eventdate as mating_date
  , fe.eventdate as farrow_date
  , SUBSTRING(BIH.[primary_identity],1,10) as SemenID
  , sup.last_name as Observer
  , '1' as MatingNbr
  , ef.liveborn_gilts + liveborn_boars as born_alive_qty
  , ef.stillborn as Stillborn_qty
  , ef.mummified as mummy_qty
  , ef.liveborn_gilts + liveborn_boars + ef.stillborn + ef.mummified as Total_born_qty
  , SUBSTRING(gen.[longname],1,20) as SowGenetics
  , ev.event_id as MatingEventID

FROM [$(PigCHAMP)].[caredata].[BH_IDENTITY_HISTORY] IH (NOLOCK) 
inner join [$(PigCHAMP)].[careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id] 
-- Mating event begin
inner join  dbo.matings_stg ev  on IH.identity_id = ev.identity_id and ih.site_id = ev.site_id   
-- Mating event end
-- Group ID begin
Left join [$(PigCHAMP)].caredata.EV_MATINGS em (NOLOCK) on em.event_id=ev.event_id and em.identity_id=ev.identity_id
-- Group ID End
-- Farrowing event begin
left join  [$(PigCHAMP)].dbo.cft_sowparity fe (nolock)
  on fe.site_id = ev.site_id and fe.identity_id = ev.identity_id and ev.eventdate < fe.eventdate and fe.event_type=170
  and fe.eventdate=(select min(eventdate) from  [$(PigCHAMP)].dbo.cft_sowparity fed (nolock)
                    where fed.identity_id=fe.identity_id and fed.site_id=fe.site_id and fed.eventdate>ev.eventdate
                      and fed.eventdate < ev.eventdate+125 and fed.event_type=170
                    ) 
-- Farrowing event end
-- Farrowing production begin
left join [$(PigCHAMP)].caredata.EV_FARROWINGS ef (nolock) on fe.event_id=ef.event_id
-- Farrowing production end
left join [$(PigCHAMP)].[caredata].[HDR_SOWS] sowHdr (NOLOCK) on IH.[identity_id] = sowHdr.[identity_id]
left join [$(PigCHAMP)].[caredata].[GENETICS] gen (NOLOCK) on sowHdr.[genetics_id] = gen.[genetics_id]
left join [$(PigCHAMP)].[caredata].[SUPERVISORS] sup (NOLOCK) on ev.[supervisor_id] = sup.[supervisor_id]
left join [$(PigCHAMP)].[caredata].[BH_IDENTITY_HISTORY] BIH (NOLOCK) on ev.[male_identity_id] = BIH.[identity_id] and IH.site_id = BIH.site_id  
Where IH.deletion_date IS NULL 
--and ih.identity_id=@ID
-- End Step one


DROP TABLE #TOff ;
DROP TABLE #TOn ;


-- deal with depop events Begin

  insert into  [dbo].[cft_SowMart_Detail_data_stg](
	         [FarmID], [SiteID], [SowID], [IdentityID], [SowParity], [SowGenetics], 
	         arrival_date, arrival_picyear_week, GroupID)
    select distinct SUBSTRING(farm.[farm_name],1,8) AS FarmID 
        , farm.site_id as SiteID
        , SUBSTRING(IH.[primary_identity],1,12) as SowID
        , IH.Identity_Id as IdentityID
        , isnull(hs.starting_parity,0) sowparity
        , SUBSTRING(gen.[longname],1,20) as sowgenetics	-- 20141202 sripley replacing hs.genetics_id to fix error in genetics value
        , be.eventdate
        , dw.picyear_week
        , be.event_type as groupid
 -- into [$(CFFDB)].dbo.sowmart_detail_data_insert
      FROM [$(PigCHAMP)].[caredata].[BH_IDENTITY_HISTORY] IH (NOLOCK)				  
      inner join [$(PigCHAMP)].[careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id]
      inner join [$(PigCHAMP)].[caredata].[HDR_SOWS] hs (NOLOCK) on hs.identity_id=ih.identity_id 
		left join [$(PigCHAMP)].[caredata].[GENETICS] gen (NOLOCK) on hs.[genetics_id] = gen.[genetics_id]	-- 20141202 sripley added join to fix error in genetics
      left join [$(PigCHAMP)].[caredata].[EXTERNAL_FARMS] ef (Nolock) on ef.farm_id = hs.origin_id and ef.site_id = ih.site_id
      inner join [$(PigCHAMP)].caredata.BH_EVENTS be (NOLOCK) on be.identity_id=ih.identity_id and be.event_type=294 and be.deletion_date is null and eventdate >= '2006-01-01'
          and be.site_id = ih.site_id
      ----and ih.is_current_site = 1
      left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw on dw.daydate = be.eventdate
      where 1=1 
      and ih.identity_id not in (select IdentityID from  [dbo].[cft_SowMart_Detail_data_stg] where IdentityID = ih.Identity_ID and siteid = ih.site_id)

      
      
	update sdd
	set sdd.mating_date = src.mating_date, sdd.mating_picyear_week = src.mating_picyear_week,sdd.groupid = 0, sdd.sowparity = src.sowparity
	from  [dbo].[cft_SowMart_Detail_data_stg] sdd
	join [$(PigCHAMP)].[caredata].BH_EVENTS  be (NOLOCK)
		on be.identity_id  = sdd.identityid and be.event_type in (294,295) and be.deletion_date is null
	join [$(PigCHAMP)].[caredata].[BH_IDENTITY_HISTORY] IH (NOLOCK)
		on ih.site_id = be.site_id and ih.identity_id = be.identity_id 	
	join  [dbo].[cft_SowMart_Detail_data_stg] src
		on src.identityid = sdd.identityid and src.removal_date = sdd.arrival_date
	where sdd.groupid = '294' and sdd.mating_date is null
 
 
   Update sdd
      set sdd.farrow_date = a.eventdate, sdd.farrow_picyear_week= dw.picyear_week
      , sdd.mating_date = dateadd(dd,-119,a.eventdate), sdd.mating_picyear_week = dm.picyear_week
      , sdd.sowparity = sdd.sowparity + 1
  , sdd.born_alive_qty = ef.liveborn_gilts + liveborn_boars
  , sdd.Stillborn_qty = ef.stillborn
  , sdd.mummy_qty = ef.mummified
  , sdd.Total_born_qty = ef.liveborn_gilts + liveborn_boars + ef.stillborn + ef.mummified
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  Inner join [$(PigCHAMP)].caredata.bh_events a (NOLOCK) on a.event_type in (170) and a.identity_id=sdd.identityid and a.site_id=sdd.SiteID 
         and a.deletion_date is null
  left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw on dw.daydate = a.eventdate
  left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dm on dm.daydate = dateadd(dd,-119,a.eventdate)
  left join [$(PigCHAMP)].caredata.EV_FARROWINGS ef (nolock) on a.event_id=ef.event_id
  where sdd.mating_date is null and sdd.farrow_date is null		-- pick up missing farrowings
  
  

  --Update sdd	--   may not be allowing fallout date assignment.
  --    set sdd.farrow_date = a.eventdate, sdd.farrow_picyear_week= dw.picyear_week
  --from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  --Inner join [$(PigCHAMP)].caredata.bh_events a (NOLOCK) on a.event_type in (170) and a.identity_id=sdd.identityid and a.site_id=sdd.SiteID 
  --       and a.deletion_date is null
  --left join [dbo].[cftDayDefinition_WithWeekInfo]	dw on dw.daydate = a.eventdate
  --where sdd.mating_date is not null and sdd.farrow_date is null 
  --  and a.eventdate > sdd.mating_date	-- make sure farrow date is after mating date		

-- deal with depop events End


-- Fallout Event Begin
  Update sdd
      set sdd.fallout_date = (select min(eventdate) from  dbo.matings_stg fll (NOLOCK)
                               where sdd.identityid = fll.identity_id and sdd.siteid = fll.site_id
                                 and fll.eventdate > sdd.mating_date and sdd.mating_date+90 > fll.eventdate )
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  
  -- Sometimes matings will be more than 90 days apart without any other events.
  Update sdd
      set sdd.fallout_date = (select min(eventdate) from  dbo.matings_stg fll (NOLOCK)
                               where sdd.identityid = fll.identity_id and sdd.siteid = fll.site_id
                                 and fll.eventdate > sdd.mating_date)
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  where mating_date is not null and farrow_date is null and fallout_date is null and removal_date is null and mating_date < (dateadd(d, -230, GETDATE())) -- Only look beyond the longest possible gestation time

--  -- Sometimes matings are real close and a farrow date is assigned to a fallout date event (happens in initial insert statement).  
--    -- Remove the farrow date in these cases
--  update sdd
--    set sdd.farrow_date=NULL, sdd.total_born_qty=NULL, sdd.born_alive_qty=NULL, sdd.mummy_qty=NULL, sdd.stillborn_qty=NULL
--  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
--  where sdd.fallout_date is not null
--  -- TODO - find out the exact definition of a Fall out - doesn't appear to be a fallout code  -- 0 rows
---- Fallout Event End

-- Step Two.A - Include Final Wean date (Full Wean only)
  Update sdd
      set sdd.final_wean_date = a.eventdate, sdd.final_wean_picyear_week= dw.picyear_week
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  Inner join [$(PigCHAMP)].caredata.bh_events a (NOLOCK) on a.identity_id=sdd.identityid and a.site_id=sdd.SiteID 
         and a.eventdate >= sdd.farrow_date and a.eventdate <=sdd.farrow_date + 65 and a.deletion_date is null
  left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw on dw.daydate = a.eventdate	-- final_wean_picyear_week
         -- Spoke with Shari and 37 days is the goal.  40 should be safe.  Later changed to 50 as found some greater than 43 days
  where a.event_type in (265)  -- 220 is part wean event, 265 is full wean event
-- End Step Two.A


-- Step Two.B - Include Partial Wean date (Partial Wean only) -- Get partial wean piglets as well (like a nurse on event)
  Update sdd
      set sdd.first_wean_date = a.eventdate, sdd.first_wean_picyear_week = dw.picyear_week,
          sdd.first_wean_qty = b.weaned_boars + b.weaned_gilts, sdd.wean_qty = b.weaned_boars + b.weaned_gilts
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  Inner join [$(PigCHAMP)].caredata.bh_events a (NOLOCK) on a.identity_id=sdd.identityid and a.site_id=sdd.SiteID 
         and a.eventdate >= sdd.farrow_date and a.eventdate <=sdd.farrow_date + 65  and a.deletion_date is null
         -- Spoke with Shari and 37 days is the goal.  40 should be safe
  Inner join [$(PigCHAMP)].caredata.ev_weanings b (NOLOCK) on b.identity_id=a.identity_id and b.event_id=a.event_id
  left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw on dw.daydate = a.eventdate	-- first_wean_picyear_week
  where a.event_type in (220) and sdd.fallout_date is null  -- 220 is part wean event, 265 is full wean event
  -- 0 rows
  
-- End Step Two.B



-- Step Two.C - Weaned piglets
  -- Full Wean Event
  Update sdd
      set sdd.wean_qty = isnull(sdd.wean_qty,0) + b.weaned_boars + b.weaned_gilts
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  Inner join [$(PigCHAMP)].caredata.bh_events a (NOLOCK) on a.identity_id=sdd.identityid and a.site_id=sdd.SiteID 
         and a.eventdate = sdd.final_wean_date and a.deletion_date is null
  Inner join [$(PigCHAMP)].caredata.ev_weanings b (NOLOCK) on b.identity_id=a.identity_id and b.event_id=a.event_id
  where a.event_type in (265) and sdd.fallout_date is null  -- 220 is part wean event, 265 is full wean event

-- End Step Two.C

-- Step AAA - Insert Gilts
   -- Insert Guilt information 
   insert into  [dbo].[cft_SowMart_Detail_data_stg](
	         [FarmID], [SiteID], [SowID], [IdentityID], [SowParity], [SowGenetics], 
	         arrival_date, arrival_picyear_week, GroupID)
    select SUBSTRING(farm.[farm_name],1,8) AS FarmID 
        , farm.site_id as SiteID
        , SUBSTRING(IH.[primary_identity],1,12) as SowID
        , IH.Identity_Id as IdentityID
        , 0
        , SUBSTRING(gen.[longname],1,20) as sowgenetics	-- 20141202 sripley replacing hs.genetics_id to fix error in genetics value
        , be.eventdate
        , dw.picyear_week
        , 0
      FROM [$(PigCHAMP)].[caredata].[BH_IDENTITY_HISTORY] IH (NOLOCK) 
      inner join [$(PigCHAMP)].[careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id] 
      inner join [$(PigCHAMP)].[caredata].[HDR_SOWS] hs (NOLOCK) on hs.identity_id=ih.identity_id and hs.starting_parity is null
 		left join [$(PigCHAMP)].[caredata].[GENETICS] gen (NOLOCK) on hs.[genetics_id] = gen.[genetics_id]	-- 20141202 sripley added join to fix error in genetics
      --inner join [$(PigCHAMP)].[caredata].[EXTERNAL_FARMS] ef (Nolock) on ef.farm_id = hs.origin_id and ef.site_id = ih.site_id
      inner join [$(PigCHAMP)].caredata.BH_EVENTS be (NOLOCK) on be.identity_id=ih.identity_id and be.event_type=100 and be.deletion_date is null and eventdate >= '2006-01-01'
      left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw on dw.daydate = be.eventdate
      where cast(ih.identity_id as varchar(10))+cast(ih.site_id as varchar(2)) not in (select cast(identityid as varchar(10))+cast(siteid as varchar(2)) from  [dbo].[cft_SowMart_Detail_data_stg] where cast(ih.identity_id as varchar(10))+cast(ih.site_id as varchar(2)) = cast(identityid as varchar(10))+cast(siteid as varchar(2)))
      --where ih.identity_id not in (select IdentityID from  [dbo].[cft_SowMart_Detail_data_stg] where IdentityID = ih.Identity_ID)
      -- missing gilts that were moved before any matings.
      
-- End Step AAA - Insert Gilts

-- Step Three - Get Arrival_date
  Update sdd
      set sdd.arrival_date = a.eventdate, sdd.arrival_picyear_week = dw.picyear_week
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  Inner join [$(PigCHAMP)].caredata.bh_events a (NOLOCK) on a.identity_id=sdd.identityid and a.site_id=sdd.SiteID 
        -- and a.eventdate <= sdd.mating_date	matings can occur before arrival dates
         and a.deletion_date is null
  left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw on dw.daydate = a.eventdate	-- arrival_picyear_week
  where a.event_type in (294, 100, 110) and sdd.arrival_date is null

-- End Step Three

-- Step Four - Get Removal_date
  Update sdd
      set sdd.removal_date = a.eventdate, sdd.removal_picyear_week = dw.picyear_week
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  Inner join [$(PigCHAMP)].caredata.bh_events a (NOLOCK) on a.identity_id=sdd.identityid and a.site_id=sdd.SiteID 
         and a.eventdate >= isnull(sdd.mating_date,sdd.arrival_date) and a.deletion_date is null			--- fixes null mating date issue
  left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw on dw.daydate = a.eventdate	-- removal_picyear_week
  where a.event_type in (298, 300, 295) and sdd.removal_date is null
  
  Update sdd
    set sdd.removal_date = re.eventdate, sdd.removal_picyear_week = dw.picyear_week
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd 
  inner join [$(PigCHAMP)].caredata.bh_events re (NOLOCK) on sdd.identityId=re.identity_id and event_type in (298,300)
  left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw on dw.daydate = re.eventdate -- removal_picyear_week
  where removal_date is null and mating_date is null
  
-- End Step Four

-- Step Five - Nurse On and Nurse on Piglets
  Update sdd
      set sdd.NurseOn_date = a.eventdate, sdd.nurseon_picyear_week = dw.picyear_week,
          sdd.NurseOn_Qty = eno.piglets_on
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  Inner join [$(PigCHAMP)].caredata.bh_events a (NOLOCK) on a.identity_id=sdd.identityid and a.site_id=sdd.SiteID 
         and a.eventdate >= sdd.Farrow_date and a.eventdate <= isnull(sdd.final_wean_date,getdate())	 and a.deletion_date is null
  Inner join [$(PigCHAMP)].caredata.ev_nurse_on eno (NOLOCK) on eno.event_id=a.event_id and eno.identity_id=a.identity_id
  left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw on dw.daydate = a.eventdate	--nurseon_picyear_week
  where a.event_type in (260) and sdd.NurseOn_date is null
  
  -- Event 180 is "Foster On" and should be treated as "Nurse On" - This looks to happen after a 220 partial weaning - Wean information goes with the 220 event, not the 180 event
  Update sdd
      set sdd.NurseOn_date = a.eventdate, sdd.nurseon_picyear_week = dw.picyear_week,
          sdd.NurseOn_Qty = isnull(NurseOn_Qty,0) + efo.piglets
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  Inner join [$(PigCHAMP)].caredata.bh_events a (NOLOCK) on a.identity_id=sdd.identityid and a.site_id=sdd.SiteID 
         and a.eventdate >= sdd.Farrow_date	and a.eventdate <= sdd.final_wean_date and a.deletion_date is null	
  Inner join [$(PigCHAMP)].caredata.ev_fosters efo (NOLOCK) on efo.event_id=a.event_id and efo.identity_id=a.identity_id
  left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw on dw.daydate = a.eventdate	--nurseon_picyear_week
  where a.event_type in (180)
  
  -- Nurse On Wean Event
  Update sdd
      set sdd.wean_qty = sdd.wean_qty+ b.weaned_boars + b.weaned_gilts
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  Inner join [$(PigCHAMP)].caredata.bh_events a (NOLOCK) on a.identity_id=sdd.identityid and a.site_id=sdd.SiteID 
         and a.eventdate = sdd.NurseOn_date and a.deletion_date is null
  Inner join [$(PigCHAMP)].caredata.ev_weanings b (NOLOCK) on b.identity_id=a.identity_id and b.event_id=a.event_id
  where a.event_type = 260 
  
-- End Step Five

-- Step Six - Wean Age -- Per Shari Wean age should be counted to Sows natural litter - (Nurse On date), not final wean date after nurse on
  Update sdd
      set sdd.Wean_age = DateDiff(day, farrow_date, case when NurseOn_date is null then final_wean_date else NurseOn_date end)
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  where sdd.farrow_date is not null
  
-- End Step Six

-- Step Seven - Lact_days & gest_days
  Update  [dbo].[cft_SowMart_Detail_data_stg]
      set gest_days_qty = DateDiff(day, mating_date, farrow_date),
          lact_days_qty = DateDiff(day, farrow_date, final_wean_date)
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  where sdd.mating_date is not null


-- End Step Seven

-- Step Eight - Mortality
  Update sdd
      set sdd.PigletDeath_qty = case when (isnull(NurseOn_Qty,0)+Total_Born_qty) - wean_qty < 0 
                                     then isnull(mummy_qty,0) + isnull(stillborn_qty,0)
                                     else (isnull(NurseOn_Qty,0)+Total_Born_qty) - wean_qty
                                     end
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  where total_born_qty is not null
-- End Step Eight

-- Step Nine - Final fallout for sows with a mating, no farrow (fallout) and then removal
  Update sdd
      set sdd.fallout_date = a.eventdate
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  inner join [$(PigCHAMP)].caredata.bh_events a (NOLOCK) on a.identity_id=sdd.identityid and a.site_id=sdd.SiteID 
         and a.eventdate > sdd.mating_date 
         and a.deletion_date is null
         and a.event_type = 130 -- 130 is Pregnancy Check (can be -/+  need to check [$(PigCHAMP)].[caredata].[EV_PREG_CHECKS] event_id, identity_id
  where farrow_date is null
    and mating_date=(select max(mating_date) 
                       from  [dbo].[cft_SowMart_Detail_data_stg] sdd1 (NOLOCK)
                      where sdd1.identityid=sdd.identityid and fallout_date is null and farrow_date is null
                        and mating_date < a.eventdate) 
    and fallout_date is null
    
  Update sdd
      set sdd.fallout_date = a.eventdate
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  inner join [$(PigCHAMP)].caredata.bh_events a (NOLOCK) on a.identity_id=sdd.identityid and a.site_id=sdd.SiteID 
         and a.eventdate > sdd.mating_date 
         and a.deletion_date is null
         and a.event_type = 168 -- 168 is Natural Abortion event
  where farrow_date is null
    and mating_date=(select max(mating_date) 
                       from  [dbo].[cft_SowMart_Detail_data_stg] sdd1 (NOLOCK)
                      where sdd1.identityid=sdd.identityid and fallout_date is null and farrow_date is null
                        and mating_date < a.eventdate) 
    and fallout_date is null
    
    
  Update sdd
      set sdd.fallout_date = a.eventdate
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  inner join [$(PigCHAMP)].caredata.bh_events a (NOLOCK) on a.identity_id=sdd.identityid and a.site_id=sdd.SiteID 
         and a.eventdate > sdd.mating_date 
         and a.deletion_date is null
         and a.event_type in (300, 298) -- 300 is female sale and 298 is female death
  where farrow_date is null
    and mating_date=(select max(mating_date) 
                       from  [dbo].[cft_SowMart_Detail_data_stg] sdd1 (NOLOCK)
                      where sdd1.identityid=sdd.identityid and fallout_date is null and farrow_date is null) 
    and fallout_date is null
-- End Step Nine

-- Step Ten - Mating_Picyear_Week
  Update sdd
      set sdd.Mating_picyear_week = dw.picyear_week
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw on dw.daydate = sdd.mating_date	--mating_picyear_week
-- End Step Ten

-- Step Eleven - farrowing_Picyear_Week
  Update sdd
      set sdd.farrow_picyear_week = dw.picyear_week
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw on dw.daydate = sdd.farrow_date	--farrowing_picyear_week
  where sdd.farrow_date is not null
-- End Step Eleven

-- Step Twelve - fallout_Picyear_Week
  Update sdd
      set sdd.fallout_picyear_week = dw.picyear_week
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw on dw.daydate = sdd.fallout_date	--fallout_picyear_week
  where sdd.fallout_date is not null
-- End Step Twelve

-- Step Thirteen  -  pigflowid, reportinggroupid
SELECT  pff.[PigFlowFarmID]
      , pff.[PigFlowID]
      , pff.[ContactID]
      , pf.reportinggroupid
      , c.contactname
      ,pf.[PigFlowFromDate]
      ,pf.[PigFlowToDate]
      ,f.farm_name, f.site_id
into #pigflow
  FROM [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
  inner join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
	on pf.pigflowid = pff.pigflowid
  inner join [$(CentralData)].dbo.contact c(nolock)
	on c.contactid = pff.contactid
  inner join [$(PigCHAMP)].[careglobal].[FARMS] f (Nolock)
	on f.farm_number = pff.contactid
where pf.pigflowid <> 0
order by pf.pigflowid, pf.pigflowfromdate, pff.contactid

  Update sdd
      set sdd.pigflowid = pf.pigflowid, sdd.reportinggroupid = pf.reportinggroupid
  from  [dbo].[cft_SowMart_Detail_data_stg] sdd
  inner join #pigflow pf
	on pf.site_id = sdd.siteid
	and isnull(isnull(isnull(isnull(isnull(isnull(final_wean_date,first_wean_date),nurseon_date),farrow_date),fallout_date),removal_date),arrival_date) between pf.pigflowfromdate and isnull(pf.pigflowtodate,getdate())

-- if the farmid is not assigned to a piggroup/flow the value is null
-- rows:  (3422270 row(s) affected)  Time:  49 seconds
-- End  Step Thirteen


-- clean up


-- new code delete rows that had less than 101 gestation days and there was another row for that parity
delete from  [dbo].[cft_SowMart_Detail_data_stg]
from 
(
select identityid, sowparity, count(1) rcnt 
from  [dbo].[cft_SowMart_Detail_data_stg] 
where mating_date is not null and farrow_date is not null 
group by identityid, sowparity 
having count(1) > 1) m   
join  [dbo].[cft_SowMart_Detail_data_stg] sdd
	on m.identityid = sdd.identityid and m.sowparity = sdd.sowparity
where datediff(dd,sdd.mating_date,sdd.farrow_date) <= 100

--more deletes
delete from  [dbo].[cft_SowMart_Detail_data_stg]
from
(
select identityid, sowparity, mating_date, farrow_date, count(1) rcnt
from  [dbo].[cft_SowMart_Detail_data_stg]
where mating_date is not null and farrow_date is not null
group by identityid, sowparity, mating_date, farrow_date
having count(1) > 1) dups
join  [dbo].[cft_SowMart_Detail_data_stg] sdd
	on sdd.identityid = dups.identityid and sdd.sowparity = dups.sowparity and sdd.mating_date = dups.mating_date and sdd.groupid = '0'
	
-- rows where farrowng data need to be cleaned out as this is really a fallout row
  update fo
    set fo.farrow_date=NULL, fo.total_born_qty=NULL, fo.born_alive_qty=NULL, fo.mummy_qty=NULL, fo.stillborn_qty=NULL
from
(select identityid, sowparity, farrow_date, count(1) rcnt
from  [dbo].[cft_SowMart_Detail_data_stg]
where mating_date is not null and farrow_date is not null
group by identityid, sowparity, farrow_date
having count(1) > 1) src	-- list of sows that have duplicate row
join  [dbo].[cft_SowMart_Detail_data_stg] fo
	on fo.identityid = src.identityid and fo.sowparity = src.sowparity and fo.farrow_date = src.farrow_date and fo.fallout_date is not null
join  [dbo].[cft_SowMart_Detail_data_stg] md
	on md.identityid = src.identityid and md.sowparity = src.sowparity and md.farrow_date = src.farrow_date and md.fallout_date is null and md.mating_date = fo.fallout_date
	
-- set fallout date to null as it is a real farrowing row
update  [dbo].[cft_SowMart_Detail_data_stg]
	set fallout_date = null, fallout_picyear_week = null
from  [dbo].[cft_SowMart_Detail_data_stg]
where mating_date is not null 
  and fallout_date is not null
  and farrow_date is not null
  and datediff(dd,mating_date,farrow_date) between 90 and 125

-- Update the mating information for sows that were bred offsite from where they farrowed
-- Added 30 Oct 2015 by BMD
-- 1/4/2016 Updated to staging table
Update sd1
   set sd1.SemenID=sd2.SemenID,
       sd1.MatingEventID=sd2.MatingEventID
      from  dbo.cft_SowMart_Detail_data_stg sd1
inner join  dbo.cft_SowMart_Detail_data_stg sd2 on sd1.IdentityID=sd2.IdentityID 
           and sd1.SemenID is null 
           and sd1.MatingEventID is null
           and sd1.mating_date=sd2.mating_date
Where sd1.FarmID<>sd2.FarmID

-- Update the mating rows with the PigChamp Genetics name for the Semen used
-- Added 30 Oct 2015 by BMD
-- 1/4/2016 Updated to staging table
Update smdd
   set smdd.PigChampGeneticName = mg.longname
	from  dbo.cft_SowMart_Detail_data_stg smdd
	left JOIN [$(PigCHAMP)].caredata.ev_matings em on em.identity_id = smdd.identityid and em.event_id = smdd.MatingEventID
	left join [$(PigCHAMP)].caredata.EV_SEMEN_DELIVERIES sd on sd.identity_id = em.male_identity_id
	left join [$(PigCHAMP)].caredata.GENETICS mg on mg.genetics_id = sd.genetics_id
	where smdd.PigChampGeneticName is null and smdd.MatingEventID is not null

end


