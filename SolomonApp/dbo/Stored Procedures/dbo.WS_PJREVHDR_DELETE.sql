CREATE PROCEDURE WS_PJREVHDR_DELETE
@Project char(16),@RevId char(4),@tstamp timestamp
AS
DELETE FROM [PJREVHDR] WHERE [Project] = @Project AND [RevId] = @RevId AND [tstamp] = @tstamp;
	 IF @@ROWCOUNT > 0 
	 BEGIN
	  DELETE FROM [PJREVTSK]  
		WHERE [Project] = @Project and [RevId] = @RevId;  
	  DELETE FROM [PJREVCAT]  
		WHERE [Project] = @Project and [RevId] = @RevId;  
	  DELETE FROM [PJREVTIM]  
		WHERE [Project] = @Project and [RevId] = @RevId;  
	 END  
