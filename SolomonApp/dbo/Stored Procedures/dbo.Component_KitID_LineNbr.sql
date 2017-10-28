 CREATE PROCEDURE Component_KitID_LineNbr
	@parm1 varchar( 30 ),
	@parm2min smallint, @parm2max smallint
AS
	SELECT *
	FROM Component
	WHERE KitID LIKE @parm1
	   AND LineNbr BETWEEN @parm2min AND @parm2max
	ORDER BY KitID,
	   LineNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Component_KitID_LineNbr] TO [MSDSL]
    AS [dbo];

