CREATE PROCEDURE WS_Attachment_Delete @ID int, @tstamp timestamp
AS
	DELETE FROM [vs_Attachment]
	WHERE [ID] = @ID AND [tstamp] = @tstamp;

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_Attachment_Delete] TO [MSDSL]
    AS [dbo];

