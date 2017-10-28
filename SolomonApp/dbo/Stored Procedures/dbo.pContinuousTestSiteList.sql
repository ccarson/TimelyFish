--used in Health Assurance Test app to list sites configured for continuous testing
--with PigMovements scheduled within a specified date range (tomorrow to endDate)
CREATE PROC [dbo].[pContinuousTestSiteList] 
	@EndDate as smalldatetime
AS

Select  ContactID,ContinuousNbrDays,Max(LastMovement) as LastMovement, ContinuousNbrDays,ContinuousAfterPreShip from 
	vContinuousTestSite v
	Where EffectiveDate=
		(Select Max(EffectiveDate) from vContinuousTestSite
		WHERE ContactID=v.ContactID 
and LastMovement between GetDate()-30 and @EndDate+30
)
	AND ContinuousNbrDays>0 
AND (isnull(ContinuousAfterPreShip,0)=0 
		or (isnull(ContinuousAfterPreShip,0)=1 and MoveDirection='OUT'))
GROUP By ContactID,ContinuousNbrDays,ContinuousAfterPreShip


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pContinuousTestSiteList] TO [MSDSL]
    AS [dbo];

