            CREATE PROCEDURE WS_SOSplitDefaults_DELETE
            @CpnyID char(10),
            @OrdNbr char(15),
            @SlsperId char(10),
            @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [SOSplitDefaults]
            WHERE [CpnyID] = @CpnyID AND 
            [OrdNbr] = @OrdNbr AND 
            [SlsperId] = @SlsperId AND 
            [tstamp] = @tstamp;
            END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_SOSplitDefaults_DELETE] TO [MSDSL]
    AS [dbo];

