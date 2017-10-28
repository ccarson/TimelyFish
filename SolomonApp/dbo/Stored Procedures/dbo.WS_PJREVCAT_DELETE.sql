
CREATE PROCEDURE WS_PJREVCAT_DELETE
@Acct char(16), @pjt_entity char(32), @project char(16), @RevId char(4), @tstamp timestamp
AS
	DELETE FROM [PJREVCAT]
	WHERE [Acct] = @Acct AND [pjt_entity] = @pjt_entity AND [project] = @project AND
	[RevId] = @RevId AND [tstamp] = @tstamp;
	 IF @@ROWCOUNT > 0 
	 BEGIN
	  DELETE FROM [PJREVTIM]  
		WHERE [Project] = @Project and [RevId] = @RevId and [pjt_entity] = @pjt_entity and [Acct] = @Acct;
	 END  
