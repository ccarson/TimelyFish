CREATE PROCEDURE WS_HistDocSlsTax_DELETE
    @DocType char(2), @RefNbr char(10), @TaxId char(10),
    @YrMon char(6), @tstamp timestamp
AS
    BEGIN
     DELETE FROM [HistDocSlsTax]
      WHERE [DocType] = @DocType AND 
            [RefNbr] = @RefNbr AND 
            [TaxId] = @TaxId AND 
            [YrMon] = @YrMon AND 
            [tstamp] = @tstamp;
    END
