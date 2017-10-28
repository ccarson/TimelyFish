 CREATE PROCEDURE SlsPrcDet_all
	@parm1 varchar( 15 ),
	@parm2 varchar( 5 )
AS
	SELECT *
	FROM SlsPrcDet
	WHERE SlsPrcID LIKE @parm1
	   AND DetRef LIKE @parm2
	ORDER BY SlsPrcID,
	   DetRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SlsPrcDet_all] TO [MSDSL]
    AS [dbo];

