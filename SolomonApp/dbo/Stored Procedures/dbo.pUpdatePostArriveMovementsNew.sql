
 
--used in Health Assurance Test app to update all movements related/affected
--by a test at a specific site on a specific date
--Created on 9/18/2007 by Dave Killion
--Used by the method CreatePostArriveTests in HAT

CREATE PROCEDURE [dbo].[pUpdatePostArriveMovementsNew]
@ContactID as int,
@TestDate as smalldatetime,
@Status as varchar(1)=''

AS

Update SolomonApp.dbo.cftPM 
set DestTestStatus=@Status
from SolomonApp.dbo.cftPM pm 
LEFT JOIN SolomonApp.dbo.cftPMAudit a on pm.PMID=a.PMID  
where (cast(DestContactID as int)=@ContactID)
and MovementDate = @TestDate
and PMSystemID in ('01','05')
and PigTypeID in ('06') and a.PMID is null


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pUpdatePostArriveMovementsNew] TO [MSDSL]
    AS [dbo];

