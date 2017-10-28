 CREATE PROCEDURE PurOrdLSDet_PONbr_LineID_LineN
	@parm1 varchar( 10 ),
	@parm2min int, @parm2max int,
	@parm3min smallint, @parm3max smallint
AS
	SELECT *
	FROM PurOrdLSDet
	WHERE PONbr LIKE @parm1
	   AND LineID BETWEEN @parm2min AND @parm2max
	   AND LineNbr BETWEEN @parm3min AND @parm3max
	ORDER BY PONbr,
	   LineID,
	   LineNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdLSDet_PONbr_LineID_LineN] TO [MSDSL]
    AS [dbo];

