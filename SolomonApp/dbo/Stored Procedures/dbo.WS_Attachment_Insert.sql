CREATE PROCEDURE WS_Attachment_Insert @noteID int, @cpnyID char(10), @fileName varchar(64), @description varchar(255), @location varchar(255), @attachDate smalldatetime, @attachedByUser varchar(47)
AS
	INSERT INTO [vs_Attachment] 
			([NoteId],[CpnyID],[NameOfFile],[Descr],[Location],[AttachDate],[AttachedBy],[S4Future01],[S4Future02],[S4Future03],[S4Future04],[S4Future05],[S4Future06],[S4Future07],[S4Future08],[S4Future09],[S4Future10],[S4Future11],[S4Future12],[User1],[User2],[User3],[User4],[User5],[User6],[User7],[User8])
	VALUES	(@noteID ,@cpnyID ,@fileName   ,@description     ,@location ,@attachDate ,@attachedByUser,'','','','','','','','','','','','','','','','','','','','');
	
	SELECT @@IDENTITY

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_Attachment_Insert] TO [MSDSL]
    AS [dbo];

