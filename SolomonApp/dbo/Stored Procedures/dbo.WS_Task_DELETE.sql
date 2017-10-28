CREATE PROCEDURE WS_Task_DELETE
	@ProjectID char(16),
	@TaskID char(32),
	@tstamp timestamp
	AS
	UPDATE [PJPENT] SET [Project] = [Project] WHERE [Project] = @ProjectID AND [Pjt_Entity] = @TaskID AND [tstamp] = @tstamp
	 IF @@ROWCOUNT > 0 
	 BEGIN
	  DELETE FROM [PJPENTEX]  
		WHERE [Project] = @ProjectID AND [Pjt_Entity] = @TaskID;  
	  DELETE FROM [PJPENT]  
		WHERE [Project] = @ProjectID AND [Pjt_Entity] = @TaskID;  
	  DELETE FROM [PJPROJMX]   
		WHERE [Project] = @ProjectID AND [Pjt_Entity] = @TaskID;  
	  DELETE FROM [PJPENTEM]  
		WHERE [Project] = @ProjectID AND [Pjt_Entity] = @TaskID; 
	 END  
