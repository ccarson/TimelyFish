 CREATE PROCEDURE FtrOptions_InvtID_FeatureNbr_L
	@parm1 varchar( 30 ),
	@parm2 varchar( 4 ),
	@parm3min smallint, @parm3max smallint
AS
	SELECT *
	FROM FtrOptions
	WHERE InvtID LIKE @parm1
	   AND FeatureNbr LIKE @parm2
	   AND LineNbr BETWEEN @parm3min AND @parm3max
	ORDER BY InvtID,
	   FeatureNbr,
	   LineNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FtrOptions_InvtID_FeatureNbr_L] TO [MSDSL]
    AS [dbo];

