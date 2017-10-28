 CREATE PROCEDURE ADG_Inventory_PV
	@parm1 varchar(30)
AS
	SELECT InvtId, Descr
	FROM Inventory
	WHERE InvtID like @parm1
	ORDER BY InvtId

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Inventory_PV] TO [MSDSL]
    AS [dbo];

