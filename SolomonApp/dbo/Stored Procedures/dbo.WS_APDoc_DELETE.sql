CREATE PROCEDURE WS_APDoc_DELETE
    @Acct char(10), @DocType char(2), @RecordID int,
    @RefNbr char(10), @Sub char(24), @tstamp timestamp
AS
    BEGIN
     DELETE FROM [APDoc]
      WHERE [Acct] = @Acct AND 
            [DocType] = @DocType AND 
            [RecordID] = @RecordID AND 
            [RefNbr] = @RefNbr AND 
            [Sub] = @Sub AND 
            [tstamp] = @tstamp;
    END
