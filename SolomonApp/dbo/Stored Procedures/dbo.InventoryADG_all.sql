 CREATE PROCEDURE InventoryADG_all
	@parm1 varchar( 30 )
AS
	SELECT *
	FROM InventoryADG
	WHERE InvtID LIKE @parm1
	ORDER BY InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[InventoryADG_all] TO [MSDSL]
    AS [dbo];

