 CREATE PROCEDURE SFSetupSOTypes_all
	@parm1 varchar( 2 ),
	@parm2 varchar( 4 )
AS
	SELECT *
	FROM SFSetupSOTypes
	WHERE SetupID LIKE @parm1
	   AND SOTypeID LIKE @parm2
	ORDER BY SetupID,
	   SOTypeID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SFSetupSOTypes_all] TO [MSDSL]
    AS [dbo];

