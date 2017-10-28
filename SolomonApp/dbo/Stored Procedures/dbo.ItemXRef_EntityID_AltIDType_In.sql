 CREATE PROCEDURE ItemXRef_EntityID_AltIDType_In
	@parm1 varchar( 15 ),
	@parm2 varchar( 1 ),
	@parm3 varchar( 30 )
AS
	SELECT *
	FROM ItemXRef
	WHERE EntityID LIKE @parm1
	   AND AltIDType LIKE @parm2
	   AND InvtID LIKE @parm3
	ORDER BY EntityID,
	   AltIDType,
	   InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


