 CREATE PROCEDURE ED850SubLineItem_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 ),
	@parm3min smallint, @parm3max smallint
AS
	SELECT *
	FROM ED850SubLineItem
	WHERE CpnyID LIKE @parm1
	   AND EDIPOID LIKE @parm2
	   AND LineNbr BETWEEN @parm3min AND @parm3max
	ORDER BY CpnyID,
	   EDIPOID,
	   LineNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


