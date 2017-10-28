 CREATE PROCEDURE WOMatlReq_all
	@parm1 varchar( 16 ),
	@parm2 varchar( 32 ),
	@parm3min smallint, @parm3max smallint
AS
	SELECT *
	FROM WOMatlReq
	WHERE WONbr LIKE @parm1
	   AND Task LIKE @parm2
	   AND LineNbr BETWEEN @parm3min AND @parm3max
	ORDER BY WONbr,
	   Task,
	   LineNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


