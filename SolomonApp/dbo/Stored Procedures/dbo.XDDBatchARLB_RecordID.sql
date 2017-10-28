
CREATE PROCEDURE XDDBatchARLB_RecordID
	@RecordID	int
	
AS
	SELECT		*
	FROM		XDDBatchARLB (nolock)
	WHERE		RecordID = @RecordID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLB_RecordID] TO [MSDSL]
    AS [dbo];

