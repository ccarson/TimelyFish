CREATE PROCEDURE WS_RQAlter_DELETE
            @AlterNbr char(10), @AlterType char(1), @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [RQAlter]
            WHERE [AlterNbr] = @AlterNbr AND 
            [AlterType] = @AlterType AND 
            [tstamp] = @tstamp;
            End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_RQAlter_DELETE] TO [MSDSL]
    AS [dbo];

