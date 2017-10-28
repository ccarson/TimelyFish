 CREATE PROCEDURE MiscCharge_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM MiscCharge
	WHERE MiscChrgID LIKE @parm1
	ORDER BY MiscChrgID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[MiscCharge_all] TO [MSDSL]
    AS [dbo];

