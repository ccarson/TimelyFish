--used in Health Assurance Test app to flag existing tests
--for a specified date range (tomorrow to endDate)
CREATE PROC [dbo].[pUpdateValidTestCodeExisting]
	@EndDate as smalldatetime
AS

Update SiteHealthAssuranceTest
SET ValidTestCode=2
WHERE TargetTestDate between GetDate()+1 and @EndDate
AND RecordTypeCode<>1 and ActualTestDate is null 
--and ManOvrRide is null

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pUpdateValidTestCodeExisting] TO [MSDSL]
    AS [dbo];

