 CREATE PROCEDURE UserSlsper_all
	@parm1 varchar( 47 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM UserSlsper
	WHERE UserID LIKE @parm1
	   AND SlsperID LIKE @parm2
	ORDER BY UserID,
	   SlsperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[UserSlsper_all] TO [MSDSL]
    AS [dbo];

