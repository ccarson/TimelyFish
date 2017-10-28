            CREATE PROCEDURE WS_SOMisc_DELETE
            @CpnyID char(10),
            @MiscChrgRef char(5),
            @OrdNbr char(15),
            @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [SOMisc]
            WHERE [CpnyID] = @CpnyID AND 
            [MiscChrgRef] = @MiscChrgRef AND 
            [OrdNbr] = @OrdNbr AND 
            [tstamp] = @tstamp;
            END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_SOMisc_DELETE] TO [MSDSL]
    AS [dbo];

