CREATE PROCEDURE WS_RQReason_DELETE
            @ItemNbr char(10), @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [RQReason]
            WHERE [ItemNbr] = @ItemNbr AND 
            [tstamp] = @tstamp;
            End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_RQReason_DELETE] TO [MSDSL]
    AS [dbo];

