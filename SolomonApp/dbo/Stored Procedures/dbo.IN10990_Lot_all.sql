 CREATE PROCEDURE IN10990_Lot_all
	@parm1min int, @parm1max int
AS
	SELECT *
	FROM IN10990_Lot
	WHERE LineID BETWEEN @parm1min AND @parm1max
	ORDER BY LineID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


