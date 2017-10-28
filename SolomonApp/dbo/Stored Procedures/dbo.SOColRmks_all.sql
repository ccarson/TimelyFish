 CREATE PROCEDURE SOColRmks_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3min smalldatetime, @parm3max smalldatetime
AS
	SELECT *
	FROM SOColRmks
	WHERE CpnyID LIKE @parm1
	   AND CustID LIKE @parm2
	   AND EntryDate BETWEEN @parm3min AND @parm3max
	ORDER BY CpnyID,
	   CustID,
	   EntryDate

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


