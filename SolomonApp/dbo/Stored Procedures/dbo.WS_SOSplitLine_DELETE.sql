            CREATE PROCEDURE WS_SOSplitLine_DELETE
            @CpnyID char(10),
            @LineRef char(5),
            @OrdNbr char(15),
            @SlsperId char(10),
            @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [SOSplitLine]
            WHERE [CpnyID] = @CpnyID AND 
            [LineRef] = @LineRef AND 
            [OrdNbr] = @OrdNbr AND 
            [SlsperId] = @SlsperId AND 
            [tstamp] = @tstamp;
            END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_SOSplitLine_DELETE] TO [MSDSL]
    AS [dbo];

