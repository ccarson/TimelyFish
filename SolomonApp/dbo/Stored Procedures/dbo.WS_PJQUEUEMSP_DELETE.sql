
CREATE PROCEDURE WS_PJQUEUEMSP_DELETE @PjqueueMsp_PK INT,
                                      @TStamp        TIMESTAMP
AS
  BEGIN
      DELETE FROM [PJQUEUEMSP]
      WHERE  [PjqueueMsp_PK] = @PjqueueMsp_PK
             AND [TStamp] = @TStamp;
  END 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJQUEUEMSP_DELETE] TO [MSDSL]
    AS [dbo];

