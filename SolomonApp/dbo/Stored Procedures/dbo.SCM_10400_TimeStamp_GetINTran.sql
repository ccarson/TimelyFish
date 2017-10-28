 Create Procedure SCM_10400_TimeStamp_GetINTran
	@RecordID	Integer,
	@TStamp1	Integer,
	@TStamp2	Integer
As
	SELECT *
	FROM INTran
	WHERE RecordID = @RecordID
	AND CONVERT(INT,SUBSTRING(TStamp,1,4)) = @TStamp1
	AND CONVERT(INT,SUBSTRING(TStamp,5,4)) = @TStamp2


