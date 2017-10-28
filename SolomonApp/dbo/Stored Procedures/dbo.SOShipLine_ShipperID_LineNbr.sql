 CREATE PROCEDURE SOShipLine_ShipperID_LineNbr
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 smallint,
	@parm4 smallint
AS
	SELECT *
	FROM SOShipLine
	WHERE CpnyID = @parm1
	   AND ShipperID LIKE @parm2
	   AND LineNbr between @parm3 and @parm4
	ORDER BY CpnyID,
	   ShipperID,
	   LineNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipLine_ShipperID_LineNbr] TO [MSDSL]
    AS [dbo];

