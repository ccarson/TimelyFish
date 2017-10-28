 CREATE PROCEDURE FtrDepExcl_all
	@parm1 varchar( 30 ),
	@parm2 varchar( 4 ),
	@parm3 varchar( 1 ),
	@parm4min smallint, @parm4max smallint
AS
	SELECT *
	FROM FtrDepExcl
	WHERE InvtID LIKE @parm1
	   AND FeatureNbr LIKE @parm2
	   AND DEType LIKE @parm3
	   AND DepExclFtr BETWEEN @parm4min AND @parm4max
	ORDER BY InvtID,
	   FeatureNbr,
	   DEType,
	   DepExclFtr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FtrDepExcl_all] TO [MSDSL]
    AS [dbo];

