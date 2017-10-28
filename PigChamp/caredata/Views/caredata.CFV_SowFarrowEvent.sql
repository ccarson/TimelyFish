
CREATE VIEW [caredata].[CFV_SowFarrowEvent]
AS
--This view was re-written to show the correct farrow locations of sows that have been transferred  JLM  2/15/2016
--It also is more efficient and accurate in assigning Parity to the sow farrow events.
select
      e.event_id as event_id
      ,SUBSTRING(loc.farm_name,1,8) as FarmID
      ,SUBSTRING(IH.primary_identity,1,12) as SowID
      ,e.eventdate as EventDate
      ,CASE
              WHEN e.eventdate is null THEN null
              ELSE  DateAdd(d, - (DatePart(dw,e.eventdate) -1), e.eventdate) 
	   END as WeekOfDate
      ,isnull(f.liveborn_boars,0)+isnull(f.liveborn_gilts,0) as QtyBornAlive
      ,isnull(f.stillborn,0) as QtyStillBorn
      ,isnull(f.mummified,0) as QtyMummy
      ,CASE when f.induced=0 then 'NO' else 'YES' END as Induced
      ,CASE when f.assisted=0 then 'NO' else 'YES' END as Assisted
      ,sp.parity as SowParity
      ,SUBSTRING(gen.longname,1,20) as SowGenetics
      ,e.creation_date as 'entry_creation_date'
      ,e.last_update_date as 'last_update_date'
from caredata.bh_events e
      left join caredata.EV_FARROWINGS f on e.identity_id=f.identity_id and e.event_id=f.event_id
      left join dbo.cft_SowParity sp on sp.identity_id=e.identity_id and e.eventdate between sp.eventdate and isnull(sp.enddate,'12/31/2099')
      left join careglobal.FARMS loc on e.site_id = loc.site_id and loc.main_site_id=loc.site_id
      left join caredata.BH_IDENTITY_HISTORY IH on IH.identity_id=e.identity_id and IH.site_id=e.site_id
      left join caredata.HDR_SOWS sowHdr on IH.identity_id=sowHdr.identity_id
      left join caredata.GENETICS gen on sowHdr.genetics_id = gen.genetics_id
where e.event_type = 170 and e.deletion_date is NULL

