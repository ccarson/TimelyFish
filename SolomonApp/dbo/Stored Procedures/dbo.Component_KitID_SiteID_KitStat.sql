 CREATE PROCEDURE Component_KitID_SiteID_KitStat
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 1 ),
	@parm4 varchar( 30 ),
	@parm5 varchar( 1 )
AS
	SELECT *
	FROM Component
	WHERE KitID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND KitStatus LIKE @parm3
	   AND CmpnentID LIKE @parm4
	   AND Status LIKE @parm5
	ORDER BY KitID,
	   SiteID,
	   KitStatus,
	   CmpnentID,
	   Status

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Component_KitID_SiteID_KitStat] TO [MSDSL]
    AS [dbo];

