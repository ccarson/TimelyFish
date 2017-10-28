 CREATE PROCEDURE ItemXRef_all
	@parm1 varchar( 30 ),
	@parm2 varchar( 1 ),
	@parm3 varchar( 15 ),
	@parm4 varchar( 30 )
AS
	SELECT *
	FROM ItemXRef
	WHERE InvtID LIKE @parm1
	   AND AltIDType LIKE @parm2
	   AND EntityID LIKE @parm3
	   AND AlternateID LIKE @parm4
	ORDER BY InvtID,
	   AltIDType,
	   EntityID,
	   AlternateID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


