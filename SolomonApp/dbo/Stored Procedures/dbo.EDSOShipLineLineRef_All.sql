 create proc EDSOShipLineLineRef_All @parm1 varchar(10),@parm2 varchar(15),@parm3 varchar(30) , @parm4 varchar (5) as SELECT * FROM SOShipLine WHERE CpnyID = @parm1 AND ShipperID = @parm2 AND invtid = @parm3 and LineRef LIKE @parm4 oRDER BY CpnyID, ShipperID,invtid,LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLineLineRef_All] TO [MSDSL]
    AS [dbo];

