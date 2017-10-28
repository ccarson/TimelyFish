 CREATE PROCEDURE POUserSubAcct_all
	@parm1 varchar( 47 ),
	@parm2 varchar( 24 )
AS
	SELECT *
	FROM POUserSubAcct
	WHERE UserID LIKE @parm1
	   AND Sub LIKE @parm2
	ORDER BY UserID,
	   Sub

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POUserSubAcct_all] TO [MSDSL]
    AS [dbo];

