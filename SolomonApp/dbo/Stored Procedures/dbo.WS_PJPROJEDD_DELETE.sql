
CREATE PROCEDURE WS_PJPROJEDD_DELETE
     @DocType char(2), @Project char(16), @TStamp timestamp
AS
  BEGIN
    DELETE 
      FROM [PJPROJEDD]
     WHERE [DocType] = @DocType AND 
           [Project] = @Project AND 
           [TStamp] = @TStamp;
	DELETE
	  FROM [PJProjEDDReceiver]
	 WHERE [DocType] = @DocType AND
	       [Project] = @Project
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJPROJEDD_DELETE] TO [MSDSL]
    AS [dbo];

