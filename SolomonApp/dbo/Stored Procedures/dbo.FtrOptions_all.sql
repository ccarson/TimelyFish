 CREATE PROCEDURE FtrOptions_all
	@parm1 varchar( 30 ),
	@parm2 varchar( 4 ),
	@parm3 varchar( 30 )
AS
	SELECT *
	FROM FtrOptions
	WHERE InvtID LIKE @parm1
	   AND FeatureNbr LIKE @parm2
	   AND OptInvtID LIKE @parm3
	ORDER BY InvtID,
	   FeatureNbr,
	   OptInvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FtrOptions_all] TO [MSDSL]
    AS [dbo];

