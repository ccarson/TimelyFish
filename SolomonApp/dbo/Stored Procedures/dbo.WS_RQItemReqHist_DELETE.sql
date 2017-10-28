CREATE PROCEDURE WS_RQItemReqHist_DELETE
            @ItemReqNbr char(10), @TranDate smalldatetime, @TranTime char(10), @UniqueID char(17), @UserID char(47),
            @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [RQItemReqHist]
            WHERE [ItemReqNbr] = @ItemReqNbr AND 
            [TranDate] = @TranDate AND 
            [TranTime] = @TranTime AND 
            [UniqueID] = @UniqueID AND 
            [UserID] = @UserID AND 
            [tstamp] = @tstamp;
            End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_RQItemReqHist_DELETE] TO [MSDSL]
    AS [dbo];

