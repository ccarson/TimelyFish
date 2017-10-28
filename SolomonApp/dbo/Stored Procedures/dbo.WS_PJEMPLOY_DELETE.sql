
CREATE PROCEDURE WS_PJEMPLOY_DELETE
            @employee char(10),
            @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [PJEMPLOY]
            WHERE [employee] = @employee AND 
            [tstamp] = @tstamp;
            End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJEMPLOY_DELETE] TO [MSDSL]
    AS [dbo];

