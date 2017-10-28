--used in Health Assurance Test app to list sites configured for post-arrival testing
--with PigMovements scheduled within a specified date range (tomorrow to endDate)
CREATE PROC [dbo].[pPostArriveTestSiteList] 
	@EndDate as smalldatetime
AS
Select Distinct MovementDate, sts.SiteContactID as DestinationContactID, sts.PostArriveNbrDays,ID as PigMovementID
FROM [$(SolomonApp)].dbo.cftPM pm
JOIN SiteTestSchedule sts on
	cast(pm.DestContactID as int)=sts.SiteContactID
	AND sts.EffectiveDate<=pm.MovementDate
	and sts.EffectiveDate=(Select Max(EffectiveDate) from SiteTestSchedule 
				where SiteContactID=cast(pm.DestContactID as int)
				and EffectiveDate <= pm.MovementDate)
--LEFT JOIN dbo.SitePigFlow spf on
--	pm.SourceContactId=spf.ContactID
--	and spf.EffectiveDate=(Select Max(EffectiveDate) from dbo.SitePigFlow
--				where ContactID=pm.SourceContactID
--				and EffectiveDate<=pm.MovementDate)
WHERE pm.MovementDate between DateAdd(Day,-1*((sts.PostArriveNbrDays)+1),GetDate()) and DateAdd(day,sts.PostArriveNbrDays*-1,@EndDate)
AND pm.MovementDate=(Select Max(MovementDate) from [$(SolomonApp)].dbo.cftPM
				where DestContactID=pm.DestContactID
				and MovementDate between pm.MovementDate and pm.MovementDate+7
				Group by DestContactID)
AND PigTypeID='06' or PigTypeID='01'
AND abs(PostArriveNbrDays)>0
order by MovementDate
--and spf.PigFlowID<>20
