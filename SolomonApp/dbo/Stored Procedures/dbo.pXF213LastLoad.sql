CREATE   Procedure pXF213LastLoad
	@parmDate As smalldatetime
AS
Select Max(LoadNbr)
From cftFeedLoad
Where DateReq=@parmdate


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF213LastLoad] TO [MSDSL]
    AS [dbo];

