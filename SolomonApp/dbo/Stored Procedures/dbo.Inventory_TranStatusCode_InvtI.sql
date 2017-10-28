 CREATE PROCEDURE Inventory_TranStatusCode_InvtI
	@parm1 varchar( 2 ),
	@parm2 varchar( 30 )
AS
	SELECT *
	FROM Inventory
	WHERE TranStatusCode LIKE @parm1
	   AND InvtID LIKE @parm2
	ORDER BY TranStatusCode,
	   InvtID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Inventory_TranStatusCode_InvtI] TO [MSDSL]
    AS [dbo];

