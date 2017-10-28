 CREATE PROCEDURE SOShipHeader_CustID_ShipRegist
	@parm1 varchar( 15 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM SOShipHeader
	WHERE CustID LIKE @parm1
	   AND ShipRegisterID LIKE @parm2
	ORDER BY CustID,
	   ShipRegisterID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipHeader_CustID_ShipRegist] TO [MSDSL]
    AS [dbo];

