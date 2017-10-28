 CREATE PROCEDURE SODiscCode_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 1 )
AS
	SELECT *
	FROM SODiscCode
	WHERE CpnyID LIKE @parm1
	   AND DiscountID LIKE @parm2
	ORDER BY CpnyID,
	   DiscountID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


