--used in Health Assurance Test app to flag duplicate tests 
--for a specified date range (tomorrow to endDate)
CREATE PROC [dbo].[pUpdateDuplicateHealthTest] 
	@EndDate as smalldatetime
AS
Update SiteHealthAssuranceTest 
SET ValidTestCode=1
FROM SiteHealthAssuranceTest hat1
JOIN (Select Min(SiteHealthAssuranceTestID) as TestID,TargetTestDate, SiteContactID from 
							SiteHealthAssuranceTest
							Group By TargetTestDate,SiteContactID
							having Count(SiteHealthAssuranceTestID)>1
							and TargetTestDate between GetDate() and @EndDate) hat2
on hat1.SiteHealthAssuranceTestID=hat2.TestID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pUpdateDuplicateHealthTest] TO [MSDSL]
    AS [dbo];

