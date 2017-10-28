create procedure WS_CANCELSALESORDER  @parm1 varchar (15), @parm2 varchar(10)   as  
	update SOHeader set Status = 'C', Cancelled = '1', CancelDate = GETDATE() where OrdNbr = @parm1 and CpnyID = @parm2 
	update SOLine set Status = 'C' where OrdNbr = @parm1 and CpnyID = @parm2
	update SOSched set Status = 'C' where OrdNbr = @parm1 and CpnyID = @parm2
	update SOLot set Status = 'C' where OrdNbr = @parm1 and CpnyID = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_CANCELSALESORDER] TO [MSDSL]
    AS [dbo];

