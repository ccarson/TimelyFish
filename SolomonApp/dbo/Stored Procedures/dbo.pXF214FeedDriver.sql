CREATE   Procedure pXF214FeedDriver
	 @Location As varchar(30), @parmContact As varchar(6)
AS
Select fd.*, c.*
From cftFeedDriver fd
LEFT JOIN cftContact c ON fd.ContactID=c.ContactID
Where fd.CF01=@Location AND fd.ContactID LIKE @parmContact

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF214FeedDriver] TO [MSDSL]
    AS [dbo];

