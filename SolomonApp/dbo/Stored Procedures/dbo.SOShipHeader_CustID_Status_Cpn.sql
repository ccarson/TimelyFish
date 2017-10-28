 CREATE PROCEDURE SOShipHeader_CustID_Status_Cpn
	@parm1 varchar( 15 ),
	@parm2 varchar( 1 ),
	@parm3 varchar( 10 ),
	@parm4 varchar( 15 )
AS
	SELECT *
	FROM SOShipHeader
	WHERE CustID LIKE @parm1
	   AND Status LIKE @parm2
	   AND CpnyID LIKE @parm3
	   AND ShipperID LIKE @parm4
	ORDER BY CustID,
	   Status,
	   CpnyID,
	   ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipHeader_CustID_Status_Cpn] TO [MSDSL]
    AS [dbo];

