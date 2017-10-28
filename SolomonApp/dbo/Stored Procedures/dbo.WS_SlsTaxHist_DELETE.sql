CREATE PROCEDURE WS_SlsTaxHist_DELETE
    @CpnyID char(10), @TaxId char(10),
    @YrMon char(6), @tstamp timestamp
AS
    BEGIN
     DELETE FROM [SlsTaxHist]
      WHERE [CpnyID] = @CpnyID AND 
            [TaxId] = @TaxId AND 
            [YrMon] = @YrMon AND 
            [tstamp] = @tstamp;
    END
