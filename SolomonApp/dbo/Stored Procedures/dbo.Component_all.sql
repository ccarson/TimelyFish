 CREATE PROCEDURE Component_all
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 1 ),
	@parm4min smallint, @parm4max smallint,
	@parm5 varchar( 30 )
AS
	SELECT *
	FROM Component
	WHERE KitID LIKE @parm1
	   AND KitSiteID LIKE @parm2
	   AND KitStatus LIKE @parm3
	   AND LineNbr BETWEEN @parm4min AND @parm4max
	   AND CmpnentID LIKE @parm5
	ORDER BY KitID,
	   KitSiteID,
	   KitStatus,
	   LineNbr,
	   CmpnentID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Component_all] TO [MSDSL]
    AS [dbo];

