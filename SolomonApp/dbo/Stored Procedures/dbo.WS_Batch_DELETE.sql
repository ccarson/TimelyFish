CREATE PROCEDURE WS_Batch_DELETE
    @BatNbr char(10), @Module char(2), @tstamp timestamp
AS
    BEGIN
     DELETE FROM [Batch]
      WHERE [BatNbr] = @BatNbr AND 
            [Module] = @Module AND 
            [tstamp] = @tstamp;
    END
