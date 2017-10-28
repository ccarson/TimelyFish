 CREATE PROCEDURE SOShipLine_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 5 )
AS
	SELECT *
	FROM SOShipLine
	WHERE CpnyID = @parm1
	   AND ShipperID LIKE @parm2
	   AND LineRef LIKE @parm3
	ORDER BY CpnyID,
	   ShipperID,
	   LineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipLine_all] TO [MSDSL]
    AS [dbo];

