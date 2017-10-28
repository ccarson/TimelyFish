            CREATE PROCEDURE WS_PJUTGOAL_DELETE
            @employee char(10),
            @fiscalno char(6),
            @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [PJUTGOAL]
            WHERE [employee] = @employee AND 
            [fiscalno] = @fiscalno AND 
            [tstamp] = @tstamp;
END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJUTGOAL_DELETE] TO [MSDSL]
    AS [dbo];

