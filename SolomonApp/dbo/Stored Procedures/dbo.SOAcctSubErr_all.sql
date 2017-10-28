 CREATE PROCEDURE SOAcctSubErr_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 31 ),
	@parm4 varchar( 15 ),
	@parm5 varchar( 5 )
AS
	SELECT *
	FROM SOAcctSubErr
	WHERE CpnyID LIKE @parm1
	   AND Acct LIKE @parm2
	   AND Sub LIKE @parm3
	   AND ShipperID LIKE @parm4
	   AND ErrorRef LIKE @parm5
	ORDER BY CpnyID,
	   Acct,
	   Sub,
	   ShipperID,
	   ErrorRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOAcctSubErr_all] TO [MSDSL]
    AS [dbo];

