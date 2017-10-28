 CREATE PROCEDURE SOVoidInvc_ShipRegisterID
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM SOVoidInvc
	WHERE ShipRegisterID LIKE @parm1
	ORDER BY ShipRegisterID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOVoidInvc_ShipRegisterID] TO [MSDSL]
    AS [dbo];

