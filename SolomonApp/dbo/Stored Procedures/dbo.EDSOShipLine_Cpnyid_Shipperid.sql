 CREATE PROCEDURE EDSOShipLine_Cpnyid_Shipperid
 @parm1 varchar( 10 ),
 @parm2 varchar( 15 )
 AS
 SELECT *
 FROM SOShipLine
 WHERE CpnyID LIKE @parm1
    AND ShipperID LIKE @parm2
 ORDER BY CpnyID, ShipperID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLine_Cpnyid_Shipperid] TO [MSDSL]
    AS [dbo];

