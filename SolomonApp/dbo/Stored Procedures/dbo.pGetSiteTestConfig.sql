--stored procedure used by Health Assurance Testing Application
--finds the Site Testing Configuration based on EffectiveDate
CREATE PROC [dbo].[pGetSiteTestConfig] 
	@SiteContactID int, @EffectiveDate smalldatetime
	As
	Select Top 1 * from SiteTestSchedule st
	where (EffectiveDate) <= @EffectiveDate and SiteContactID=@SiteContactID
	ORDER BY EffectiveDate DESC

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pGetSiteTestConfig] TO [MSDSL]
    AS [dbo];

