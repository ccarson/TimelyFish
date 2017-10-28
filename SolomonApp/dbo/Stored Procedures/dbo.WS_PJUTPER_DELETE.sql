			CREATE PROCEDURE WS_PJUTPER_DELETE
            @period char(6),
            @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [PJUTPER]
            WHERE [period] = @period AND 
            [tstamp] = @tstamp;
            END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJUTPER_DELETE] TO [MSDSL]
    AS [dbo];

