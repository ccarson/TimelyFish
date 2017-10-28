 CREATE PROCEDURE CustNameXRef_NameSeg_CustID
	@parm1 varchar( 20 ),
	@parm2 varchar( 15 )
AS
	SELECT *
	FROM CustNameXRef
	WHERE NameSeg LIKE @parm1
	   AND CustID LIKE @parm2
	ORDER BY NameSeg,
	   CustID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


