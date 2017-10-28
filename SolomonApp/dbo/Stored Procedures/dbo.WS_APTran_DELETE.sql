CREATE PROCEDURE WS_APTran_DELETE
    @Acct char(10), @BatNbr char(10), @RecordID int,
    @RefNbr char(10), @Sub char(24), @tstamp timestamp
AS
    BEGIN
     DELETE FROM [APTran]
      WHERE [Acct] = @Acct AND 
            [BatNbr] = @BatNbr AND 
            [RecordID] = @RecordID AND 
            [RefNbr] = @RefNbr AND 
            [Sub] = @Sub AND 
            [tstamp] = @tstamp;
    END
