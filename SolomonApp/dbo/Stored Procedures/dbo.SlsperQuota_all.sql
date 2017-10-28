 CREATE PROCEDURE SlsperQuota_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 6 )
AS
	SELECT *
	FROM SlsperQuota
	WHERE SlsperID LIKE @parm1
	   AND PerNbr LIKE @parm2
	ORDER BY SlsperID,
	   PerNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SlsperQuota_all] TO [MSDSL]
    AS [dbo];

