            CREATE PROCEDURE WS_SOSched_DELETE
            @CpnyID char(10),
            @LineRef char(5),
            @OrdNbr char(15),
            @SchedRef char(5),
            @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [SOSched]
            WHERE [CpnyID] = @CpnyID AND 
            [LineRef] = @LineRef AND 
            [OrdNbr] = @OrdNbr AND 
            [SchedRef] = @SchedRef AND 
            [tstamp] = @tstamp;
            
            DELETE FROM [SOLot]
            WHERE [CpnyID] = @CpnyID AND 
            [LineRef] = @LineRef AND 
            [OrdNbr] = @OrdNbr AND 
            [SchedRef] = @SchedRef;
                        
            DELETE FROM [SOSchedMark]
            WHERE [CpnyID] = @CpnyID AND 
            [LineRef] = @LineRef AND 
            [OrdNbr] = @OrdNbr AND 
            [SchedRef] = @SchedRef;
            END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_SOSched_DELETE] TO [MSDSL]
    AS [dbo];

