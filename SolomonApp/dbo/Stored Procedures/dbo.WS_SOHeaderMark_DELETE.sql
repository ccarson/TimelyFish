            CREATE PROCEDURE WS_SOHeaderMark_DELETE
            @CpnyID char(10),
            @OrdNbr char(15),
            @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [SOHeaderMark]
            WHERE [CpnyID] = @CpnyID AND 
            [OrdNbr] = @OrdNbr AND 
            [tstamp] = @tstamp;
            END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_SOHeaderMark_DELETE] TO [MSDSL]
    AS [dbo];

