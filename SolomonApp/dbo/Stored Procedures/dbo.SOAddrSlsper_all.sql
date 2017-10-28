 CREATE PROCEDURE SOAddrSlsper_all
	@parm1 varchar( 15 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 10 )
AS
	SELECT *
	FROM SOAddrSlsper
	WHERE CustID LIKE @parm1
	   AND ShipToID LIKE @parm2
	   AND SlsPerID LIKE @parm3
	ORDER BY CustID,
	   ShipToID,
	   SlsPerID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOAddrSlsper_all] TO [MSDSL]
    AS [dbo];

