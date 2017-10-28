
--used in Health Assurance Test app to update all movements related/affected
--by a test at a specific site on a specific date
--Updated 9/18/2007 by Dave Killion
--Proc now accepts an additional parameter for the Enddate
--thus removing the need to cross servers

CREATE PROCEDURE [dbo].[pUpdateRelatedMovementsNew]
      @ContactID as int,
      @TestDate as smalldatetime,
      @Status as varchar(1)='',
      @EndDate as datetime

AS

Update SolomonApp.dbo.cftPM 
set SourceTestStatus=@Status
from SolomonApp.dbo.cftPM pm 
LEFT JOIN SolomonApp.dbo.cftPMAudit a on pm.PMID=a.PMID 
where (cast(SourceContactID as int)= @ContactID )
and (MovementDate between  @TestDate  and  @EndDate) and a.PMID is null 

Update SolomonApp.dbo.cftPM 
set SourceTestStatus='' 
from SolomonApp.dbo.cftPM pm 
LEFT JOIN SolomonApp.dbo.cftPMAudit a on pm.PMID=a.PMID 
where (cast(SourceContactID as int)= @ContactID )
and (MovementDate between  @TestDate  and  @EndDate) 
and PigTypeID='02' and a.PMID is null
if (@Status)='2'
BEGIN
Update SolomonApp.dbo.cftPM 
set DestTestStatus=@Status
from SolomonApp.dbo.cftPM pm 
LEFT JOIN SolomonApp.dbo.cftPMAudit a on pm.PMID=a.PMID 
where (Cast(DestContactID as int)=@ContactID)
and MovementDate between  @TestDate  and  @EndDate 
and PigTypeID<>'04' and PigTypeID<>'05' and a.PMID is null
END

else
BEGIN
Update SolomonApp.dbo.cftPM 
set DestTestStatus=@Status
from SolomonApp.dbo.cftPM pm 
LEFT JOIN SolomonApp.dbo.cftPMAudit a on pm.PMID=a.PMID 
where (cast(DestContactID as int)=@ContactID)
and (MovementDate between  @TestDate  and  @EndDate)
and PMSystemID in ('01','05')
and PigTypeID in ('01','02','03','06','08','09') and a.PMID is null
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pUpdateRelatedMovementsNew] TO [MSDSL]
    AS [dbo];

