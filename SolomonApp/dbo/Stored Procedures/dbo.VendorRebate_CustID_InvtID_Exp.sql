 CREATE PROCEDURE VendorRebate_CustID_InvtID_Exp
	@parm1 varchar( 15 ),
	@parm2 varchar( 30 ),
	@parm3min smalldatetime, @parm3max smalldatetime
AS
	SELECT *
	FROM VendorRebate
	WHERE CustID LIKE @parm1
	   AND InvtID LIKE @parm2
	   AND ExpireDate BETWEEN @parm3min AND @parm3max
	ORDER BY CustID,
	   InvtID,
	   ExpireDate

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


