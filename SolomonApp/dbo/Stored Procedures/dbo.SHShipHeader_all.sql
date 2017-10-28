 CREATE PROCEDURE SHShipHeader_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 )
AS
	SELECT *
	FROM SHShipHeader
	WHERE CpnyID = @parm1
	   AND ShipperID LIKE @parm2
	ORDER BY CpnyID,
	   ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SHShipHeader_all] TO [MSDSL]
    AS [dbo];

