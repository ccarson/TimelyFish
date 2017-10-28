 CREATE PROCEDURE INTran_BatNbr_KitID_LineNbr
	@parm1 varchar( 10 ),
	@parm2 varchar( 30 ),
	@parm3min smallint, @parm3max smallint
AS
	SELECT *
	FROM INTran
	WHERE BatNbr LIKE @parm1
	   AND KitID LIKE @parm2
	   AND LineNbr BETWEEN @parm3min AND @parm3max
	ORDER BY BatNbr,
	   KitID,
	   LineNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


