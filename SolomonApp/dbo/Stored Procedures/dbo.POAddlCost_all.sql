 CREATE PROCEDURE POAddlCost_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 5 )
AS
	SELECT *
	FROM POAddlCost
	WHERE PONbr LIKE @parm1
	   AND LineRef LIKE @parm2
	ORDER BY PONbr,
	   LineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


