 CREATE PROCEDURE ADG_Inventory_Descr
	@parm1 varchar(30)
AS
	SELECT Descr
	FROM Inventory
	WHERE InvtID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Inventory_Descr] TO [MSDSL]
    AS [dbo];

