--used in Health Assurance Test app to list sites configured for preship testing
--with PigMovements scheduled within a specified date range (tomorrow to endDate)
CREATE PROC [dbo].[pPreShipTestSiteList] 
	@EndDate as smalldatetime
AS

Select  MovementDate, sts.SiteContactID as SourceContactID ,sts.PreShipNbrDays,
Min(ID) as PigMovementID,sts.AuthorizeDays
FROM SolomonApp.dbo.cftPM pm
JOIN SiteTestSchedule sts on pm.SourceContactID=sts.SiteContactID AND sts.EffectiveDate<=pm.MovementDate

and sts.EffectiveDate=(Select Max(EffectiveDate) from SiteTestSchedule
		WHERE SiteContactID=cast(pm.SourceContactID as integer) and EffectiveDate<=pm.MovementDate)
WHERE pm.MovementDate between GetDate()+4 and 
@EndDate+10
	and MovementDate=(Select Min(MovementDate) from SolomonApp.dbo.cftPM 
			where SourceContactID=cast(pm.SourceContactID as int)
			--AND MovementDate > DateAdd(day,-21,pm.MovementDate) 
			AND MovementDate between GetDate()+4 and 
@EndDate+10
			and (PigTypeID in ('06','08','03','09','01')) 
			Group by SourceContactID)
	and (PigTypeID in ('06','08','03','09','01') and PreShipNbrDays>0)
	--and (pm.SourceBarnNbr<>'' or pm.SourceBarnNbr is null)
Group by MovementDate, sts.SiteContactID , sts.PreShipNbrDays
UNION 
Select  MovementDate, sts.SiteContactID,sts.PreShipNbrDays,
min(ID) as PigMovementID,sts.AuthorizeDays
FROM SolomonApp.dbo.cftPM pm
JOIN SiteTestSchedule sts on cast(pm.SourceContactID as int)=sts.SiteContactID AND sts.EffectiveDate<=pm.MovementDate

and sts.EffectiveDate=(Select Max(EffectiveDate) from SiteTestSchedule
		WHERE SiteContactID=1217 and EffectiveDate<=pm.MovementDate)
WHERE pm.MovementDate between GetDate()+4 and @EndDate+10
	--and MovementDate=(Select Min(MovementDate) from PigMovement where SourceContactID=pm.SourceContactID
			--AND MovementDate > DateAdd(day,-21,pm.MovementDate) 
			--AND MovementDate between GetDate()+4 and @EndDate+10
			--Group by SourceContactID)
	and (PigTypeID in ('06','08','03','09','01')) and PreShipNbrDays>0
	--and (pm.SourceBarnNbr<>'0' or pm.SourceBarnNbr is null) 
	and pm.SourceContactID=1217
Group by MovementDate, sts.SiteContactID, sts.PreShipNbrDays



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pPreShipTestSiteList] TO [MSDSL]
    AS [dbo];

