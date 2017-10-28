 CREATE PROCEDURE SFSetupCury_all
	@parm1 varchar( 2 ),
	@parm2 varchar( 4 )
AS
	SELECT *
	FROM SFSetupCury
	WHERE SetupID LIKE @parm1
	   AND CuryID LIKE @parm2
	ORDER BY SetupID,
	   CuryID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SFSetupCury_all] TO [MSDSL]
    AS [dbo];

