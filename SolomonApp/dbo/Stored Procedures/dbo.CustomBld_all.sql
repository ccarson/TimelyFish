 CREATE PROCEDURE CustomBld_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 4 ),
	@parm3 varchar( 30 ),
	@parm4min smallint, @parm4max smallint,
	@parm5min smallint, @parm5max smallint
AS
	SELECT *
	FROM CustomBld
	WHERE OrderNbr LIKE @parm1
	   AND ParFtrNbr LIKE @parm2
	   AND ParOptInvtID LIKE @parm3
	   AND LevelNbr BETWEEN @parm4min AND @parm4max
	   AND LineNbr BETWEEN @parm5min AND @parm5max
	ORDER BY OrderNbr,
	   ParFtrNbr,
	   ParOptInvtID,
	   LevelNbr,
	   LineNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


