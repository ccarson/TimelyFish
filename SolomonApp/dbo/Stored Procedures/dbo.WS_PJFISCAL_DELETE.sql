
CREATE PROCEDURE WS_PJFISCAL_DELETE @fiscalno CHAR(6),
                                    @tstamp   TIMESTAMP
 AS
   BEGIN
       DELETE FROM [PJFISCAL]
       WHERE  [fiscalno] = @fiscalno
              AND [tstamp] = @tstamp;
   END 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJFISCAL_DELETE] TO [MSDSL]
    AS [dbo];

