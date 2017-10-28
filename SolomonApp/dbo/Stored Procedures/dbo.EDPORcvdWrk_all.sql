 CREATE PROCEDURE EDPORcvdWrk_all
	@parm1min smallint, @parm1max smallint,
	@parm2 varchar( 10 ),
	@parm3 varchar( 10 ),
	@parm4 varchar( 30 ),
	@parm5min int, @parm5max int,
	@parm6 varchar( 15 ),
	@parm7min int, @parm7max int
AS
	SELECT *
	FROM EDPORcvdWrk
	WHERE RI_ID BETWEEN @parm1min AND @parm1max
	   AND CpnyID LIKE @parm2
	   AND EDIPOID LIKE @parm3
	   AND InvtID LIKE @parm4
	   AND LineID BETWEEN @parm5min AND @parm5max
	   AND OrdNbr LIKE @parm6
	   AND LineCounter BETWEEN @parm7min AND @parm7max
	ORDER BY RI_ID,
	   CpnyID,
	   EDIPOID,
	   InvtID,
	   LineID,
	   OrdNbr,
	   LineCounter

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


