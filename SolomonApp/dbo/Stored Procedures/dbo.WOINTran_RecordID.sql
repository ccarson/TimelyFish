 CREATE PROCEDURE WOINTran_RecordID
	@RecordID		  int

AS
	SELECT           *
	FROM             INTran
	WHERE            RecordID = @RecordID


