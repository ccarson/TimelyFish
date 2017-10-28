 CREATE PROCEDURE WS_PJUTTYPE_DELETE
            @utilization_type char(4),
            @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [PJUTTYPE]
            WHERE [utilization_type] = @utilization_type AND 
            [tstamp] = @tstamp;
            END
            

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJUTTYPE_DELETE] TO [MSDSL]
    AS [dbo];

