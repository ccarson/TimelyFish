 CREATE PROCEDURE SOShipHeader_CpnyID_OrdNbr_Shi
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 15 )
AS
	SELECT *
	FROM SOShipHeader
	WHERE CpnyID LIKE @parm1
	   AND OrdNbr LIKE @parm2
	   AND ShipperID LIKE @parm3
	ORDER BY CpnyID,
	   OrdNbr,
	   ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipHeader_CpnyID_OrdNbr_Shi] TO [MSDSL]
    AS [dbo];

