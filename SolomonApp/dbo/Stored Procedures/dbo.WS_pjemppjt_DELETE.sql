 CREATE PROCEDURE WS_pjemppjt_DELETE
            @employee char(10),
            @effect_date smalldatetime,
            @project char(16),
            @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [pjemppjt]
            WHERE [employee] = @employee AND 
            [effect_date] = @effect_date AND 
            [project] = @project AND 
            [tstamp] = @tstamp;
            END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_pjemppjt_DELETE] TO [MSDSL]
    AS [dbo];

