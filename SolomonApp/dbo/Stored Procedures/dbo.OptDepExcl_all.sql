 CREATE PROCEDURE OptDepExcl_all
	@parm1 varchar( 30 ),
	@parm2 varchar( 4 ),
	@parm3 varchar( 30 ),
	@parm4 varchar( 1 ),
	@parm5 varchar( 4 ),
	@parm6 varchar( 30 )
AS
	SELECT *
	FROM OptDepExcl
	WHERE InvtId LIKE @parm1
	   AND FeatureNbr LIKE @parm2
	   AND OptInvtID LIKE @parm3
	   AND DEType LIKE @parm4
	   AND DepExclFtr LIKE @parm5
	   AND DepExclOpt LIKE @parm6
	ORDER BY InvtId,
	   FeatureNbr,
	   OptInvtID,
	   DEType,
	   DepExclFtr,
	   DepExclOpt

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[OptDepExcl_all] TO [MSDSL]
    AS [dbo];

