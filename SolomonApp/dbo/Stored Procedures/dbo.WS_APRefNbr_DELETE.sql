CREATE PROCEDURE WS_APRefNbr_DELETE
    @RefNbr char(10), @tstamp timestamp
AS
    BEGIN
     DELETE FROM [APRefNbr]
      WHERE [RefNbr] = @RefNbr AND 
            [tstamp] = @tstamp;
    END
