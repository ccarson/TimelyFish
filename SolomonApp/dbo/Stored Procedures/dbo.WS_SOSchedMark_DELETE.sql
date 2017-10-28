            CREATE PROCEDURE WS_SOSchedMark_DELETE
            @CpnyID char(10),
            @LineRef char(5),
            @OrdNbr char(15),
            @SchedRef char(5),
            @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [SOSchedMark]
            WHERE [CpnyID] = @CpnyID AND 
            [LineRef] = @LineRef AND 
            [OrdNbr] = @OrdNbr AND 
            [SchedRef] = @SchedRef AND 
            [tstamp] = @tstamp;
            END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_SOSchedMark_DELETE] TO [MSDSL]
    AS [dbo];

