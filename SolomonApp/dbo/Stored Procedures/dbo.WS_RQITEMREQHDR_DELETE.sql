CREATE PROCEDURE WS_RQITEMREQHDR_DELETE
            @ItemReqNbr char(10), @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [RQITEMREQHDR]
            WHERE [ItemReqNbr] = @ItemReqNbr AND 
            [tstamp] = @tstamp;
            End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_RQITEMREQHDR_DELETE] TO [MSDSL]
    AS [dbo];

