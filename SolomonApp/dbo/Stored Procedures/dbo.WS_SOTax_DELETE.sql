            CREATE PROCEDURE WS_SOTax_DELETE
            @CpnyID char(10),
            @OrdNbr char(15),
            @TaxCat char(10),
            @TaxID char(10),
            @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [SOTax]
            WHERE [CpnyID] = @CpnyID AND 
            [OrdNbr] = @OrdNbr AND 
            [TaxCat] = @TaxCat AND 
            [TaxID] = @TaxID AND 
            [tstamp] = @tstamp;
            END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_SOTax_DELETE] TO [MSDSL]
    AS [dbo];

