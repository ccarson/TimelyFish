 CREATE PROCEDURE IN10550_Wrk_all
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 21 )
AS
	SELECT *
	FROM IN10550_Wrk
	WHERE KitID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND ComputerName LIKE @parm3
	ORDER BY KitID,
	   SiteID,
	   ComputerName

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IN10550_Wrk_all] TO [MSDSL]
    AS [dbo];

