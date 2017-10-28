create proc XB_CheckIfReleaseFiles 
@RI_ID int
AS
DECLARE @SystemDate as smalldatetime
DECLARE @SystemTime as smalldatetime

Select @SystemDate = cast(systemdate as smalldatetime), @SystemTime = cast(systemtime as smalldatetime) 
From RptRuntime Where RI_ID = @RI_ID

Select Count(*) from vs_RPTRuntime Where ReportNbr = '03620' And RI_ID <> @RI_ID 
And systemdate = @SystemDate
And cast(systemtime as smalldatetime) between dateadd(mi,-2,@SystemTime) 
And dateadd(mi,2,@SystemTime)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XB_CheckIfReleaseFiles] TO [MSDSL]
    AS [dbo];

