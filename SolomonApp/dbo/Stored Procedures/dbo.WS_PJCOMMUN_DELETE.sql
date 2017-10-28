
CREATE PROCEDURE WS_PJCOMMUN_DELETE 
	@msg_key    CHAR(48), @msg_suffix CHAR(2), @msg_type   CHAR(6), @tstamp     TIMESTAMP
AS
  BEGIN
      DELETE FROM [PJCOMMUN]
      WHERE  [msg_key] = @msg_key
             AND [msg_suffix] = @msg_suffix
             AND [msg_type] = @msg_type
             AND [tstamp] = @tstamp;
  END 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJCOMMUN_DELETE] TO [MSDSL]
    AS [dbo];

