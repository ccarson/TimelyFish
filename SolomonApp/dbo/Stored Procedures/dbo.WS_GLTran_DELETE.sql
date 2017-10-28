CREATE PROCEDURE WS_GLTran_DELETE
    @BatNbr char(10), @LineNbr smallint, @Module char(2), @tstamp timestamp
AS
    BEGIN
     DELETE FROM [GLTran]
      WHERE [BatNbr] = @BatNbr AND 
            [LineNbr] = @LineNbr AND 
            [Module] = @Module AND 
            [tstamp] = @tstamp;
    END
