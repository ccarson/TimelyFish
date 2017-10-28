 CREATE PROCEDURE Component_KitID_CmpnentID_KitS
	@parm1 varchar( 30 ),
	@parm2 varchar( 30 ),
	@parm3 varchar( 10 ),
	@parm4 varchar( 1 ),
	@parm5 varchar( 10 ),
	@parm6 varchar( 5 )
AS
	SELECT *
	FROM Component
	WHERE KitID LIKE @parm1
	   AND CmpnentID LIKE @parm2
	   AND KitSiteID LIKE @parm3
	   AND KitStatus LIKE @parm4
	   AND SiteID LIKE @parm5
	   AND Sequence LIKE @parm6
	ORDER BY KitID,
	   CmpnentID,
	   KitSiteID,
	   KitStatus,
	   SiteID,
	   Sequence

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Component_KitID_CmpnentID_KitS] TO [MSDSL]
    AS [dbo];

