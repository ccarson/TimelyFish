 CREATE PROCEDURE Inventory_Descr_InvtID
	@parm1 varchar( 60 ),
	@parm2 varchar( 30 )
AS
	SELECT *
	FROM Inventory
	WHERE Descr LIKE @parm1
	   AND InvtID LIKE @parm2
	ORDER BY Descr,
	   InvtID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Inventory_Descr_InvtID] TO [MSDSL]
    AS [dbo];

