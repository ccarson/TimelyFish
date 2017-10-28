 CREATE PROCEDURE CustomFtr_InvtID_LineNbr
	@parm1 varchar( 30 ),
	@parm2min smallint, @parm2max smallint
AS
	SELECT *
	FROM CustomFtr
	WHERE InvtID LIKE @parm1
	   AND LineNbr BETWEEN @parm2min AND @parm2max
	ORDER BY InvtID,
	   LineNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CustomFtr_InvtID_LineNbr] TO [MSDSL]
    AS [dbo];

