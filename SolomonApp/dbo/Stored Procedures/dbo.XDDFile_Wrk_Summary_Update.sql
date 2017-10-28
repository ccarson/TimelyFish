
CREATE PROCEDURE XDDFile_Wrk_Summary_Update
   @RecordID		int

AS
   UPDATE	XDDFile_Wrk
   SET		RecordSummary = DepRecord
   WHERE	RecordID = @RecordID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFile_Wrk_Summary_Update] TO [MSDSL]
    AS [dbo];

