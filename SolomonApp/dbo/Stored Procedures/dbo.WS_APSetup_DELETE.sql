CREATE PROCEDURE WS_APSetup_DELETE
    @SetupId char(2), @tstamp timestamp
AS
    BEGIN
     DELETE FROM [APSetup]
      WHERE [SetupId] = @SetupId AND 
            [tstamp] = @tstamp;
    END
