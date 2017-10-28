--used in Health Assurance Test app to the site's effective dated testing configuration
-- for a specific site based on a reference date
CREATE PROC [dbo].[pGetSiteTestSchedule] 
	@ContactID as integer,
	@RefDate as smalldatetime
AS

Select  *
from SiteTestSchedule sts 
where SiteContactID=@ContactID AND sts.EffectiveDate<=@RefDate

and sts.EffectiveDate=(Select Max(EffectiveDate) from SiteTestSchedule
		WHERE SiteContactID=@ContactID and EffectiveDate<=@RefDate)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pGetSiteTestSchedule] TO [MSDSL]
    AS [dbo];

