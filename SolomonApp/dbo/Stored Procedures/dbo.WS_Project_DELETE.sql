CREATE PROCEDURE WS_Project_DELETE
	@ProjectID char(16),
	@tstamp timestamp
	AS
	UPDATE [PJPROJ] SET [Project] = [Project] WHERE [Project] = @ProjectID AND [tstamp] = @tstamp
	 IF @@ROWCOUNT > 0 
	 BEGIN
	  DELETE FROM [PJPENTEX]  
		WHERE [Project] = @ProjectID;  
	  DELETE FROM [PJPENT]  
		WHERE [Project] = @ProjectID;  
	  DELETE FROM [PJPROJEM]  
		WHERE [Project] = @ProjectID;  
	  DELETE FROM [PJPROJMX]   
		WHERE [Project] = @ProjectID;  
	  DELETE FROM [PJPENTEM]  
		WHERE [Project] = @ProjectID; 
	  DELETE FROM [PJPROJEX]  
		WHERE [Project] = @ProjectID;  
	  DELETE FROM [PJPROJ]  
		WHERE [Project] = @ProjectID; 
	  DELETE FROM [PJBILL]  
		WHERE [Project] = @ProjectID;  
	  DELETE FROM [PJADDR]  
		WHERE [Addr_Key] = @ProjectID;
	  DELETE FROM [PJPROJEDD]
	    WHERE [Project] = @ProjectID;
      DELETE FROM [PJProjEDDReceiver]
	    Where [Project] = @ProjectID; 
	 END  
