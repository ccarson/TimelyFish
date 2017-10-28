 /****** OBject: Stored Procedure dbo.ShipVia_All Script Date: 5/28/99 from DMG ******/
CREATE PROCEDURE ShipVia_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 )
AS
	SELECT *
	FROM ShipVia
	WHERE CpnyID LIKE @parm1
	   AND ShipViaID LIKE @parm2
	ORDER BY CpnyID,
	   ShipViaID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ShipVia_all] TO [MSDSL]
    AS [dbo];

