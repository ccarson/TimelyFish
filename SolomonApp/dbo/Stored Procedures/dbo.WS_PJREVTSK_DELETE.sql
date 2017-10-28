
CREATE PROCEDURE WS_PJREVTSK_DELETE
@pjt_entity char(32), @project char(16), @revid char(4), @tstamp timestamp
AS
DELETE FROM [PJREVTSK]
WHERE [pjt_entity] = @pjt_entity AND [project] = @project AND [revid] = @revid AND [tstamp] = @tstamp;
	 IF @@ROWCOUNT > 0 
	 BEGIN
	  DELETE FROM [PJREVCAT]  
		WHERE [pjt_entity] = @pjt_entity AND [Project] = @Project and [RevId] = @RevId;  
	  DELETE FROM [PJREVTIM]  
		WHERE [pjt_entity] = @pjt_entity AND [Project] = @Project and [RevId] = @RevId;  
	 END  
