 Create Proc EDSOShipLot_LineRef
 @parm1 varchar( 10 ),
 @parm2 varchar( 10 ),
 @parm3 varchar( 5 )
AS
 SELECT *
 FROM SOShipLot
 WHERE CpnyID LIKE @parm1
    AND ShipperID LIKE @parm2
    AND LineRef LIKE @parm3
 ORDER BY CpnyID,
    ShipperID,
    LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLot_LineRef] TO [MSDSL]
    AS [dbo];

