
CREATE PROC [dbo].[pGetLastTestDate] 
	@ContactID as int,
	@OutDate as smalldatetime OUTPUT
AS
BEGIN
	DECLARE @ActualDate as smalldatetime, @TargetDate as smalldatetime
	SET @ActualDate=(Select Max(ActualTestDate) from SiteHealthAssuranceTest
		WHERE SiteContactID=@ContactID and isnull(RecordTypeCode,0)<>5 
--and isnull(ValidTestCode,0)<>2
			) 
	SET @TargetDate=(Select Max(TargetTestDate) from SiteHealthAssuranceTest
		WHERE SiteContactID=@ContactID and isnull(RecordTypeCode,0)<>5 
--and isnull(ValidTestCode,0)<>2
			) 
	IF @ActualDate + 14 < @TargetDate
		BEGIN Set @OutDate=@TargetDate END
	ELSE
		BEGIN Set @OutDate=@ActualDate END
END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pGetLastTestDate] TO [MSDSL]
    AS [dbo];

