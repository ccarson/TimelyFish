            CREATE PROCEDURE WS_SOLine_DELETE
            @CpnyID char(10),
            @LineRef char(5),
            @OrdNbr char(15),
            @tstamp timestamp
            AS
            BEGIN
            DELETE FROM [SOLine]
            WHERE [CpnyID] = @CpnyID AND 
            [LineRef] = @LineRef AND 
            [OrdNbr] = @OrdNbr AND 
            [tstamp] = @tstamp;
            
			DELETE FROM [SOSplitLine]
            WHERE [CpnyID] = @CpnyID AND 
            [LineRef] = @LineRef AND 
            [OrdNbr] = @OrdNbr;
                        
            DELETE FROM [SOSched]
            WHERE [CpnyID] = @CpnyID AND 
            [LineRef] = @LineRef AND 
            [OrdNbr] = @OrdNbr;
            
            DELETE FROM [SOLot]
            WHERE [CpnyID] = @CpnyID AND 
            [LineRef] = @LineRef AND 
            [OrdNbr] = @OrdNbr;
                        
            DELETE FROM [SOSchedMark]
            WHERE [CpnyID] = @CpnyID AND 
            [LineRef] = @LineRef AND 
            [OrdNbr] = @OrdNbr;
			END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_SOLine_DELETE] TO [MSDSL]
    AS [dbo];

