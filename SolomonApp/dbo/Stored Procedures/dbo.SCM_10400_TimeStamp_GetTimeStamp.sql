 Create Procedure SCM_10400_TimeStamp_GetTimeStamp
	@RecordID	Integer
As
	SELECT
	CONVERT(INT,SUBSTRING(TStamp,1,4)),
	CONVERT(INT,SUBSTRING(TStamp,5,4))
	FROM INTran (NOLOCK)
	WHERE RecordID = @RecordID


