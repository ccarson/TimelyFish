 CREATE PROCEDURE Book_CpnyID_SlsperID_EffDate_B
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 ),
	@parm3min smalldatetime, @parm3max smalldatetime,
	@parm4min float, @parm4max float,
	@parm5min float, @parm5max float
AS
	SELECT *
	FROM Book
	WHERE CpnyID LIKE @parm1
	   AND SlsperID LIKE @parm2
	   AND EffDate BETWEEN @parm3min AND @parm3max
	   AND BookSls BETWEEN @parm4min AND @parm4max
	   AND BookCost BETWEEN @parm5min AND @parm5max
	ORDER BY CpnyID,
	   SlsperID,
	   EffDate,
	   BookSls,
	   BookCost

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Book_CpnyID_SlsperID_EffDate_B] TO [MSDSL]
    AS [dbo];

