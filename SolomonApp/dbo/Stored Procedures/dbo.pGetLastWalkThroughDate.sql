
CREATE PROC [dbo].[pGetLastWalkThroughDate] 
	@ContactID as int,
	@OutDate as smalldatetime OUTPUT
AS
	Select @OutDate=(Select Max(ActualTestDate) from SiteHealthAssuranceTest
		WHERE SiteContactID=@ContactID and isnull(RecordTypeCode,0)=5)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pGetLastWalkThroughDate] TO [MSDSL]
    AS [dbo];

