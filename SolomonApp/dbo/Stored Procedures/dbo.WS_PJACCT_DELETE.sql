
CREATE PROCEDURE WS_PJACCT_DELETE @acct   CHAR(16),
                                  @tstamp TIMESTAMP
AS
  BEGIN
      DELETE FROM [PJACCT]
      WHERE  [acct] = @acct
             AND [tstamp] = @tstamp;
  END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJACCT_DELETE] TO [MSDSL]
    AS [dbo];

