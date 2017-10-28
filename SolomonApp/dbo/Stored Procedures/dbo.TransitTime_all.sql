 CREATE PROCEDURE TransitTime_all
	@parm1 varchar( 15 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 3 ),
	@parm4 varchar( 3 )
AS
	SELECT *
	FROM TransitTime
	WHERE ShipViaID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND Country LIKE @parm3
	   AND Zip LIKE @parm4
	ORDER BY ShipViaID,
	   SiteID,
	   Country,
	   Zip

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TransitTime_all] TO [MSDSL]
    AS [dbo];

