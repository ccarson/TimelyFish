CREATE   Procedure pXF212AsnDriverPV
	 @Location As varchar(30), @parmContact As varchar(6)
AS
Select fd.*, c.*
From cftFeedDriver fd
LEFT JOIN cftContact c ON fd.ContactID=c.ContactID
Where fd.CF01=@Location AND
fd.ContactID LIKE @parmContact

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF212AsnDriverPV] TO [MSDSL]
    AS [dbo];

