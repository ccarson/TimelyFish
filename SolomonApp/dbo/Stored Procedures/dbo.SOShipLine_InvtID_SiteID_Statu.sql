 CREATE PROCEDURE SOShipLine_InvtID_SiteID_Statu
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 1 )
AS
	SELECT *
	FROM SOShipLine
	WHERE InvtID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND Status LIKE @parm3
	ORDER BY InvtID,
	   SiteID,
	   Status

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipLine_InvtID_SiteID_Statu] TO [MSDSL]
    AS [dbo];

