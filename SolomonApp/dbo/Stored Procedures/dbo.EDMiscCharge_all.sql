 CREATE PROCEDURE EDMiscCharge_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM EDMiscCharge
	WHERE MiscChrgID LIKE @parm1
	   AND Code LIKE @parm2
	ORDER BY MiscChrgID,
	   Code

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDMiscCharge_all] TO [MSDSL]
    AS [dbo];

