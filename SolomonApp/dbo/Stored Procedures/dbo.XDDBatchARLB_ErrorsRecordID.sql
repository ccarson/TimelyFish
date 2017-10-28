
CREATE PROCEDURE XDDBatchARLB_ErrorsRecordID
	@RecordID	int
	
AS
	SELECT		*
	FROM		XDDBatchARLBErrors (nolock)
	WHERE		RecordID = @RecordID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLB_ErrorsRecordID] TO [MSDSL]
    AS [dbo];

