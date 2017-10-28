 CREATE PROCEDURE CustItem_all
	@parm1 varchar( 15 ),
	@parm2 varchar( 30 ),
	@parm3 varchar( 4 )
AS
	SELECT *
	FROM CustItem
	WHERE CustID LIKE @parm1
	   AND InvtID LIKE @parm2
	   AND FiscYr LIKE @parm3
	ORDER BY CustID,
	   InvtID,
	   FiscYr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


