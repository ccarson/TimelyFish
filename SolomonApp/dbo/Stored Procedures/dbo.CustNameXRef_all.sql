 CREATE PROCEDURE CustNameXRef_all
	@parm1 varchar( 15 ),
	@parm2 varchar( 20 )
AS
	SELECT *
	FROM CustNameXRef
	WHERE CustID LIKE @parm1
	   AND NameSeg LIKE @parm2
	ORDER BY CustID,
	   NameSeg

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


