 CREATE PROCEDURE SOHeaderMark_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 )
AS
	SELECT *
	FROM SOHeaderMark
	WHERE CpnyID = @parm1
	   AND OrdNbr LIKE @parm2
	ORDER BY CpnyID,
	   OrdNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


