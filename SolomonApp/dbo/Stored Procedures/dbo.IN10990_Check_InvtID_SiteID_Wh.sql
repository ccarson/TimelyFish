 CREATE PROCEDURE IN10990_Check_InvtID_SiteID_Wh
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 10 )
AS
	SELECT *
	FROM IN10990_Check
	WHERE InvtID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND WhseLoc LIKE @parm3
	ORDER BY InvtID,
	   SiteID,
	   WhseLoc

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IN10990_Check_InvtID_SiteID_Wh] TO [MSDSL]
    AS [dbo];

