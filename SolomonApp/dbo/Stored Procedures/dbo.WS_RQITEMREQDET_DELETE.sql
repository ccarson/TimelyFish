 CREATE PROCEDURE WS_RQITEMREQDET_DELETE
            @ItemReqNbr char(10), @LineNbr smallint, @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [RQITEMREQDET]
            WHERE [ItemReqNbr] = @ItemReqNbr AND 
            [LineNbr] = @LineNbr AND 
            [tstamp] = @tstamp;
            End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_RQITEMREQDET_DELETE] TO [MSDSL]
    AS [dbo];

