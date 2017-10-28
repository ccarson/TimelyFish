 CREATE PROCEDURE INUpdateQty_Wrk_all
	@parm1 varchar( 21 ),
	@parm2 varchar( 30 ),
	@parm3 varchar( 10 )
AS
	SELECT *
	FROM INUpdateQty_Wrk
	WHERE ComputerName LIKE @parm1
	   AND InvtID LIKE @parm2
	   AND SiteID LIKE @parm3
	ORDER BY ComputerName,
	   InvtID,
	   SiteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INUpdateQty_Wrk_all] TO [MSDSL]
    AS [dbo];

