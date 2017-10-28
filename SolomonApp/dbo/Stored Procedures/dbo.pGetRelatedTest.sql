--used in Transportation app to find the Health Assurance Test related/affected
--by a movement at a specific site on a specific date
CREATE PROC [dbo].[pGetRelatedTest]
	@ContactID as int,
	@MovementDate as smalldatetime
AS

	Select Top 1 TestStatusID, TestResultID
	from SiteHealthAssuranceTest
	where SiteContactID=@ContactID 
	
	and TargetTestDate>@MovementDate-28 and isNull(ActualTestDate,TargetTestDate)>@MovementDate-28
	and TargetTestDate<=@MovementDate-2 and isnull(ActualtestDate,TargetTestDate)<=@MovementDate
	--and TargetTestDate+28<@MovementDate or isnull(ActualTestDate,0)+28<@MovementDate
	and isnull(RecordTypeCode,0)<>5
	--and TargetTestDate<@MovementDate
	Order by TargetTestDate DESC

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pGetRelatedTest] TO [MSDSL]
    AS [dbo];

